package game.managers.auth.ios
{
	import com.apptem.commonssdk.CommonsANE;
	import game.managers.auth.AuthFileManager;
	import game.managers.auth.IDeviceAuthManager;
	import game.modules.logs.ILogger;
	import game.net.ServerRequest;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class IOSAthManager implements IDeviceAuthManager
	{
		[Inject]
		public var request:ServerRequest;
		[Inject]
		public var logger:ILogger;
		
		private var _file:AuthFileManager;
		
		public function IOSAthManager()
		{
			_file = new AuthFileManager(IOSData);
		}
		
		/* INTERFACE game.managers.auth.IDeviceAuthManager */
		
		public function auth():void
		{
			try
			{
				var deviceId:String = com.apptem.commonssdk.CommonsANE.Init().GetIDFA();
				logger.note("deviceId IDFA: " + deviceId);
				request.authByIOS(deviceId);
			}
			catch (e:Error)
			{
				logger.error("[game.managers.auth.ios.IOSAthManager][auth]", e);
			}
		}
	
	}

}