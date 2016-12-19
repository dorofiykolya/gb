package game.managers.auth
{
	import common.events.EventDispatcher;
	import common.events.IDispatcher;
	import common.system.ClassType;
	import common.system.Environment;
	import common.system.application.Application;
	import common.system.utils.ObjectUtils;
	import game.configurations.Configuration;
	import game.modules.logs.ILogger;
	import game.modules.net.ISocketConnection;
	import game.modules.net.events.NetEvent;
	import game.modules.storage.StorageManager;
	import game.net.ServerRequest;
	
	[Event(name = "success", type = "game.managers.auth.AuthEvent")]
	[Event(name = "lost", type = "game.managers.auth.AuthEvent")]
	[Event(name = "reAuth", type = "game.managers.auth.AuthEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AuthManager extends EventDispatcher
	{
		private static const STORAGE_KEY:String = "storage_key";
		private static const AUTH_KEY:String = "auth_key";
		
		[Inject]
		public var configuration:Configuration;
		[Inject]
		public var request:ServerRequest;
		[Inject]
		public var storage:StorageManager;
		[Inject]
		public var application:Application;
		[Inject]
		public var dispatcher:IDispatcher;
		[Inject]
		public var device:IDeviceAuthManager;
		[Inject]
		public var logger:ILogger;
		
		private var _authorized:Boolean;
		private var _userAuthInfo:UserAuthInfo;
		
		public function AuthManager(connection:ISocketConnection)
		{
			connection.addEventListener(NetEvent.CLOSE, onSocketClose);
		}
		
		private function onSocketClose(e:NetEvent):void
		{
			authLost();
		}
		
		public function setAuthStatus(state:int):void
		{
			switch (state)
			{
				case AuthState.SUCCESS: 
					_authorized = true;
					
					dispatchEventAs(AuthEvent, AuthEvent.SUCCESS);
					dispatcher.dispatchEventAs(AuthEvent, AuthEvent.SUCCESS);
					break;
				default: 
					_authorized = false;
					reAuth();
					dispatchEventAs(AuthEvent, AuthEvent.RE_AUTH);
					dispatcher.dispatchEventAs(AuthEvent, AuthEvent.RE_AUTH);
					break;
			}
		}
		
		public function get authorized():Boolean
		{
			return _authorized;
		}
		
		public function get browserSocialType():int
		{
			var parameters:Object = application.parameters;
			var socialId:int = (parameters && "social_id" in parameters) ? parseInt(parameters["social_id"]) : -1;
			return socialId;
		}
		
		public function authByBrowser():void
		{
			_authorized = false;
			var auth_data:Object = JSON.parse(application.parameters.auth_data);
			var authInfo:UserAuthInfo = UserAuthInfo(ObjectUtils.toType(auth_data.userAuthInfo, UserAuthInfo));
			setAuthInfo(authInfo);
		}
		
		public function authByDeveloper():void
		{
			_authorized = false;
			request.authByDeveloper(configuration.developerId);
		}
		
		public function authByIOS():void
		{
			device.auth();
			logger.note(String(device) + ", authByIOS");
		}
		
		public function authByAndroid():void
		{
			device.auth();
			logger.note(String(device) + ", authByAndroid");
		}
		
		public function get authData():UserAuthInfo
		{
			var storageAuth:Object = storage.map(STORAGE_KEY, AUTH_KEY).value;
			if (storageAuth != null)
			{
				var userAuth:UserAuthInfo = UserAuthInfo(ObjectUtils.toType(storageAuth, UserAuthInfo));
				return userAuth;
			}
			return null;
		}
		
		public function clearAuth():void
		{
			_authorized = false;
			storage.map(STORAGE_KEY, AUTH_KEY).deleteValue();
		}
		
		public function reAuth():void
		{
			clearAuth();
			auth();
		}
		
		public function auth():void
		{
			_authorized = false;
			
			var userAuth:UserAuthInfo;
			var storageAuth:Object = storage.map(STORAGE_KEY, AUTH_KEY).value;
			
			if (storageAuth != null)
			{
				userAuth = UserAuthInfo(ObjectUtils.toType(storageAuth, UserAuthInfo));
			}
			
			if (userAuth != null && validSocialType(userAuth))
			{
				request.userAuth(userAuth.userKey, userAuth.authTS, userAuth.authKey, userAuth.isBrowser);
			}
			else
			{
				if (configuration.isBrowser)
				{
					authByBrowser();
					logger.note("authByBrowser");
				}
				else if (configuration.isDeveloper)
				{
					authByDeveloper();
					logger.note("authByDeveloper");
				}
				else if (Environment.isIOS)
				{
					authByIOS();
					logger.note("authByIOS");
				}
				else if (Environment.isAndroid)
				{
					authByAndroid();
					logger.note("authByAndroid");
				}
				else
				{
					logger.alert("incorrect auth selector");
				}
			}
		}
		
		public function setAuthInfo(userAuth:UserAuthInfo):void
		{
			if (configuration.isBrowser)
			{
				userAuth.socialType = browserSocialType;
			}
			_userAuthInfo = userAuth;
			request.userAuth(_userAuthInfo.userKey, _userAuthInfo.authTS, _userAuthInfo.authKey, _userAuthInfo.isBrowser);
			storage.map(STORAGE_KEY, AUTH_KEY).value = ObjectUtils.toObject(userAuth);
		}
		
		private function authLost():void
		{
			_authorized = false;
			dispatchEventAs(AuthEvent, AuthEvent.LOST);
			dispatcher.dispatchEventAs(AuthEvent, AuthEvent.LOST);
		}
		
		private function validSocialType(userAuth:UserAuthInfo):Boolean
		{
			if (userAuth == null)
			{
				return false;
			}
			if (configuration.isBrowser)
			{
				if (browserSocialType == -1)
				{
					return true;
				}
				return userAuth.socialType == browserSocialType;
			}
			return true;
		}
	}
}