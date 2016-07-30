package game.managers.integration.ok 
{
	import com.adobe.serialization.json.JSONDecoder;
	import com.api.forticom.ApiCallbackEvent;
	import com.api.forticom.ForticomAPI;
	import com.api.forticom.SignUtil;
	import common.context.IContext;
	import common.system.application.Application;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import game.GameApplication;
	import game.managers.localizations.ILocalizeProvider;
	import game.managers.localizations.LocalizationManager;
	import game.managers.users.UserManager;
	import game.Texts;
	import integration.External;
	import integration.ISocialService;
	import integration.SocialType;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author Mike Silanin
	 */
	public class OKSocialService implements ISocialService, IConfigurable
	{
		[Inject]
		public var localize:ILocalizeProvider;
		
		[Inject]
		public var application:Application;
		
		[Inject]
		public var userManager:UserManager;
		
		[Inject]
		public var gameApplication:GameApplication;
		
		[Inject]
		public var localizationManager:LocalizationManager;
		
		private var _req:Object;
		private var balance:int;
		private var currencyPrefix:String;
		private var request:URLRequest;
		private var loader:URLLoader;
			
		public function get id():int
		{
			return SocialType.ODNOKLASSNIKI;
		}
		
		public function get prefix():String
		{
			return "ok";
		}
		
		public function config(context:IContext):void
		{
			
		}
		
		public function initilize():void 
		{
			var params:Object = getParams;
			
			SignUtil.applicationKey = params.application_key;
			SignUtil.secretSessionKey = params.session_secret_key;
			SignUtil.secretKey = "F395E3DB4AD35E003159CA07";
			SignUtil.sessionKey = params.session_key;
			
			External.call('eval', 'function flashSetSize(width,height){document.getElementById("flashcontent").style.height=height+"px";}');
			/**
			 * fix bug in Firefox
			 */
			//tabVisible
			External.call("eval", "" + "function tabVisible() {" + "var myObj = document.getElementById('flashcontent');" + "myObj.eventActive();" + "}");
			
			//tabHide
			External.call("eval", "" + "function tabHide() {" + "var myObj = document.getElementById('flashcontent');" + "myObj.eventDeActive();" + "}");
			External.call("eval", "" + "var val = navigator.userAgent.toLowerCase();" + "if(val.indexOf('firefox') > -1)" + "{" + "window.onfocus = tabVisible;" + "window.onblur = tabHide;" + "}");
			
			External.addCallBack('eventActive', eventActive);
			External.addCallBack('eventDeActive', eventDeActive);
			
			try
			{
				var apiconection:String = params.apiconnection;
				ForticomAPI.addEventListener(ForticomAPI.CONNECTED, onODNOKLASSNIKIConnected);
				ForticomAPI.connection = apiconection;
			}
			catch (e:Error)
			{
				if (External.available)
				{
					External.call('console.log', '[integration.odnoklassniki.OKSocialService][config] error');
					External.call('console.log', e);
				}
				//onInitializeError.Invoke();
			}
		}
		
		public function getUserData():void 
		{
			getAppUsersPhoto();
		}
		
		private function onODNOKLASSNIKIConnected(e:Event):void
		{
			ForticomAPI.addEventListener(ApiCallbackEvent.CALL_BACK, callBackOdnoklassniki);
			//onInitializeSuccess.Invoke();
		}
		
		private function callBackOdnoklassniki(e:ApiCallbackEvent):void
		{
			External.call("console.log", 'ApiCallbackEvent -> method ' + e.method);

			if (e.method == "showPayment")
			{
				if (e.result == "ok")
				{
					External.call("console.log", 'пользователь подтвердил оплату');
				}
				else
				{
					External.call("console.log", 'пользователь отклонил оплату');
				}
			}
			else if (e.method == "showConfirmation")
			{
				if (e.result == "ok")
				{
					External.call("console.log", 'пользователь подтвердил действие');
					_req["resig"] = e.data;
				}
				else
				{
					External.call("console.log", 'пользователь отклонил действие');
				}
			}
			else if (e.method == "showInvite")
			{
				if (e.result == "ok")
				{
					External.call("console.log", 'пользователь пригласил друзей');
				}
				else
				{
					External.call("console.log", 'пользователь не пригласил друзей');
				}
			}
		}
		
		private function onAppInstalled(result:Object = null):void
		{
			//showSettings();
		}
		
		public function wallPost(message:String):void
		{
			var att:Object = {"caption": message, "media": [{"href": "link", "src": "https://pp.vk.me/c315425/v315425992/b020/6EX-lKVI2kA.jpg", "type": "image"}]};
			var act:Object = [{"text": "перейти к игре", "href": "http://www.odnoklassniki.ru/game/1246901504"}];
			_req = {method: "stream.publish", attachment: JSON.stringify(att), action_links: JSON.stringify(act), message: message};
			_req = SignUtil.signRequest(_req, true, 'XML');
			ForticomAPI.showConfirmation("stream.publish", message, _req["sig"]);
		}
		
		//public function get balancePrefix():String
		//{
		//	return getCurrencyPrefix(balance);
		//}
		
		/*override public function ShowInstall():void
		   {
		   if (External.available)
		   {
		   External.call("eval", 'VK.callMethod("showInstallBox");');
		   }
		   }
		
		   override public function ShowSettings():void
		   {
		   if (External.available)
		   {
		   External.call("eval", 'VK.callMethod("showSettingsBox", 8195);');
		   }
		 }*/
		
		public function getCurrencyPrefix(currency:int):String
		{
			var s:String = String(currency);
			var v:uint = parseInt(s.charAt(s.length - 1));
			if (v == 1)
			{
				currencyPrefix = " OK";
			}
			else if (v > 1 && v < 5)
			{
				currencyPrefix = " OKа";
			}
			else
			{
				currencyPrefix = " OKов";
			}
			
			return currencyPrefix;
		}
		
		public function get photoSizePrefix():String
		{
			return "pic_2";
		}
		
		public function setSize(width:Number, height:Number):void
		{
			if (External.available)
			{
				External.call('flashSetSize', width, height);
			}
		}
		
		public function showInviteBox():void
		{
			try
			{
				var gameString:String = JSON.stringify({direct: 'http://www.odnoklassniki.ru/game/1246901504'});
				ForticomAPI.showInvite("Пираты: королевские бои", gameString);
			}
			catch (error:Error)
			{
				if (External.available)
				{
					External.call('console.log', '[integration.odnoklassniki.OKSocialService][ShowInviteBox] error');
					External.call('console.log', error);
				}
			}
		}
		
		public function getAppUsers():void
		{
			try
			{
				var params:Object = getParams;
				var _URL:String = params.api_server;
				var requestData:Object = SignUtil.signRequest({method: 'friends.getAppUsers'}, false, "XML");
				
				request = new URLRequest(checkURL('http://api.odnoklassniki.ru/api/friends/getAppUsers'));
				request.data = getUrlVars(requestData);
				request.method = URLRequestMethod.POST;
				
				loader = new URLLoader();
				loader.addEventListener(flash.events.Event.COMPLETE, onGetAppUsers, false, 0, false);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onRequestFailure, false, 0, true);
				loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityViolation, false, 0, true);
				loader.load(request);
			}
			catch (error:Error)
			{
				if (External.available)
				{
					External.call('console.log', '[integration.odnoklassniki.OKSocialService][GetAppUsers] error');
					External.call('console.log', error);
				}
			}
		}
		
		public function getAppUsersPhoto():void
		{
			try
			{
				var params:Object = getParams;
				var _URL:String = params.api_server;
				
				var idList:Vector.<String> = new Vector.<String>();
				idList.push(application.parameters.viewer_id);
				
				var requestData:Object = SignUtil.signRequest({method: 'users.getInfo', uids: (idList.join(',')), fields: 'uid, pic_1, pic_2, pic_3, first_name, last_name', emptyPictures: 'true'}, false, "XML");
				
				request = new URLRequest(checkURL(_URL ? _URL + 'fb.do' : '/fb.do?'));
				request.data = getUrlVars(requestData);
				request.method = URLRequestMethod.POST;
				
				loader = new URLLoader();
				loader.addEventListener(flash.events.Event.COMPLETE, onGetAppUsersPhoto, false, 0, false);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onRequestFailure, false, 0, true);
				loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityViolation, false, 0, true);
				loader.load(request);
			}
			catch (error:Error)
			{
				if (External.available)
				{
					External.call('console.log', '[integration.odnoklassniki.OKSocialService][GetAppUsersPhoto] error');
					External.call('console.log', error);
				}
			}
		}
		
		public function getBalance():void
		{
			if (External.available)
			{
				External.call('getBalance');
			}
		}
		
		public function showPayment(price:int, resourseCount:int, item:String):void
		{
			try
			{
				External.call("console.log", 'showPayment ' + price + getCurrencyPrefix(price) + ' resourseCount: ' + resourseCount);
				ForticomAPI.showPayment(resourseCount + ' ' + gemsTextForCount(resourseCount), '', item, price, null, null, 'кристаллы', 'true');
				
				gameApplication.fullScreen = false;
			}
			catch (error:Error)
			{
				if (External.available)
				{
					External.call('console.log', '[integration.odnoklassniki.OKSocialService][ShowPayment] error');
					External.call('console.log', error);
				}
			}
		}
		
		public function gemsTextForCount(value:int):String
		{
			return localizationManager.language == "ru" ? getEnding(value, 'Кристаллов', 'Кристалл', 'Кристалла') : localize.localize(Texts.GEMS);
		}
		
		public function getEnding(number:uint, end0:String, end1:String, end2:String):String {
			
			if(number == 0)
			{
				return end0;
			}else{
				
				var num100:Number = number % 100;
				var num10:Number = number % 10;
				
				if (num100 >= 5 && num100 <= 20){
					return end0;
				} else if (num10 == 0) {
					return end0;
				} else if (num10 == 1) {
					return end1;
				} else if (num10 >= 2 && num10 <= 4) {
					return end2;
				} else if (num10 >= 5 && num10 <= 9) {
					return end0;
				} else {
					return end2;
				}
			}
		}
		
		public function getDeals():void
		{
		
		}
		
		public function showDeals():void
		{
			//UIPopupDeals.instance.Show();
		}
		
		public function get dealsCount():int
		{
			return 1;
		}
		
		private function onGetBalance(e:Object):void
		{
			//balance = e.response;
			//SafeInvoke.TryInvoke(onBalanceChanged.Invoke);
		}
		
		private function onGetAppUsers(e:Event):void
		{
			var xmlResponce:XML = XML(loader.data);
			if (xmlResponce == null)
			{
				return;
			}
			
			var xmlFriends:XMLList = xmlResponce.uid;
			if (xmlFriends == null)
			{
				if (External.available)
				{
					External.call('console.log', '[integration.vk.OKSocialService][onGetAppUsers] error: xmlFriends == null');
					External.call('console.log', e);
				}
				return;
			}
			
			/*friendsId = {};
			this.friends = new Vector.<SocialFriend>();
			
			var current:SocialFriend;
			for each (var item:String in xmlFriends)
			{
				current = new SocialFriend(item);
				this.friends.push(current);
				this.friendsId[item] = current;
			}*/
			//SafeInvoke.TryInvoke(onGetAppUsersChanged.Invoke);
		}
		
		private function onGetAppUsersPhoto(e:Object):void
		{
			var xml:XML = new XML(loader.data);
			var list:XMLList = xml.user;
			if (list == null)
			{
				External.call('console.log', 'onGetAppUsersPhoto list is null');
				return;
			}
			
			//var current:SocialFriend;
			for each (var o:XML in list)
			{
				if (o.uid == application.parameters.viewer_id)
				{
					userManager.socialName = o.first_name;
				}
				//if (current)
				//{
				//	current.first_name = o.first_name;
				//	current.last_name = o.last_name;
				//	current.photoUrl = o.pic_2;
				//}
				//else
				//{
				//	Debug.Bug("[integration.mailru.OKSocialServise][onGetAppUsersPhoto]");
				//}
			}
			
			External.call('console.log', "---------------------------");
			
			//SafeInvoke.TryInvoke(onGetAppUsersPhotoChanged.Invoke);
		}
		
		private function onBalanceChange(e:*):void
		{
			//balance = int(e);
			//SafeInvoke.TryInvoke(onBalanceChanged.Invoke);
		}
		
		public function openGroupPage():void
		{
			try
			{
				var targetURL:URLRequest = new URLRequest("http://www.odnoklassniki.ru/group/52008926183599");
				navigateToURL(targetURL, "_blank");
			}
			catch (error:Error)
			{
				if (External.available)
				{
					External.call('console.log', '[OKSocialService][openGroupPage] error');
					External.call('console.log', error);
				}
			}
		}
		
		public function checkIsGroupMember():void
		{
			External.call("console.log", 'OKSocialService.CheckIsGroupMember');
			
			//QuestRecords.GroupMember = true;
		
			/*
			var params:Object = getParams;
			var _URL:String = params.api_server;
			var requestData:Object = SignUtil.signRequest({ method: 'group.getUserGroupsByIds', uids: Application.Parameters.viewer_id, group_id: '52008926183599'}, false, "JSON");

			External.Call("console.log", requestData);

			request = new URLRequest( checkURL(_URL ? _URL+'fb.do' : '/fb.do?') );
			request.data = requestData;
			request.method = URLRequestMethod.GET;

			loader = new URLLoader();
			loader.addEventListener(flash.events.Event.COMPLETE, onCheckComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onRequestFailure);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityViolation);
			loader.load( request );
			*/
		}
		
		private static function checkURL(value:String):String
		{
			if (value.search(/\?/) > 0)
			{
				if (value.search(/&$/) < 0)
				{
					value += "&";
				}
			}
			else
			{
				value += "?";
			}
			return value;
		}
		
		private function onCheckComplete(e:Event = null):void
		{
			/*External.call("console.log", "[integration.odnoklassniki.OKSocialService][onCheckComplete] " + e);
			if (e)
			{
				QuestRecords.GroupMember = true;
			}
			else
			{
				QuestRecords.GroupMember = false;
			}*/
		}
		
		private function onRequestFailure(e:IOErrorEvent):void
		{
			//Debug.Bug("[integration.odnoklassniki.OKSocialService][onRequestFailure] " + e.text);
			External.call("console.log", "[integration.odnoklassniki.OKSocialService][onRequestFailure] " + e.text);
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void
		{
			//Debug.Bug("[integration.odnoklassniki.OKSocialService][httpStatusHandler] " + event.status);
			External.call("console.log", "[integration.odnoklassniki.OKSocialService][httpStatusHandler] " + event.status);
		}
		
		private function onSecurityViolation(e:SecurityErrorEvent):void
		{
			//Debug.Bug("[integration.odnoklassniki.OKSocialService][onSecurityViolation] " + e.text);
			External.call("console.log", "[integration.odnoklassniki.OKSocialService][onSecurityViolation] " + e.text);
		}
		
		public function shareWithFriends():void
		{
			if (External.available)
			{
				try
				{
					External.call("console.log", 'ShareWithFriends');
					var messages:Array = ['Сразись со мной в "Пираты: королевские бои"', 'Управляй своей армией сумасшедшими пиратами', 'Никто меня еще не победил в этой игре', 'Кто посмеет бросить вызов чемпиону?'];
					var message:String = messages[int(Math.random() * messages.length)];
					var att:Object = {"caption": message, "media": [{"href": "link", "src": "https://pp.vk.me/c315425/v315425992/b020/6EX-lKVI2kA.jpg", "type": "image"}]};
					var act:Object = [{"text": "перейти к игре", "href": "http://www.odnoklassniki.ru/game/1246901504"}];
					_req = {method: "stream.publish", attachment: JSON.stringify(att), action_links: JSON.stringify(act), message: message};
					_req = SignUtil.signRequest(_req, true, 'JSON');
					ForticomAPI.showConfirmation("stream.publish", message, _req["sig"]);
				}
				catch (error:Error)
				{
					if (External.available)
					{
						External.call('console.log', '[OKSocialService][shareWithFriends] error');
						External.call('console.log', error);
					}
				}
			}
		}
		
		private function getUrlVars(data:Object):URLVariables
		{
			var urlVars:URLVariables = new URLVariables();
			if (data == null)
			{
				return urlVars;
			}
			
			for (var s:String in data)
			{
				urlVars[s] = data[s];
			}
			
			return urlVars;
		}
		
		public function eventActive():void
		{
			//Activity.OnActive.Invoke();
		}
		
		public function eventDeActive():void
		{
			//Activity.OnDeactive.Invoke();
		}
		
		private function get getParams():Object
		{
			var params:Object = new Object();
			var propertiesArray:Array = unescape(application.parameters.getparams).split('&');
			for (var i:uint = 0; i < propertiesArray.length; i++)
			{
				var objectProperty:Array = propertiesArray[i].split('=');
				var propertyName:String = objectProperty[0];
				var propertyValue:String = objectProperty[1];
				params[propertyName] = propertyValue;
			}
			return params;
		}
		
	}

}