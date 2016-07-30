package game.managers.integration.vk
{
	import common.context.IContext;
	import common.system.application.Application;
	import common.system.utils.formatString;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import game.GameApplication;
	import game.managers.localizations.ILocalizeProvider;
	import game.managers.users.UserManager;
	import game.Texts;
	import integration.External;
	import integration.ISocialService;
	import integration.SocialType;
	import mvc.configurations.IConfigurable;
	
	/**
	 * @author Evgeniy on 4/26/2016.
	 */
	public class VKSocialService implements ISocialService, IConfigurable
	{
		[Inject]
		public var localize:ILocalizeProvider;
		
		[Inject]
		public var application:Application;
		
		[Inject]
		public var userManager:UserManager;
		
		[Inject]
		public var gameApplication:GameApplication;
			
		public function get id():int
		{
			return SocialType.VKONTAKTE;
		}
		
		public function get prefix():String
		{
			return "vk";
		}
		
		public function config(context:IContext):void
		{
			
		}
		
		public function initilize():void
		{
			External.call('eval', "function pay(item){ VK.callMethod('showOrderBox', {type:'item',item:item}) }");
			External.call('eval', 'function onAppInstalled(result){document.getElementById("flashcontent").onAppInstalled(result)} VK.addCallback("onApplicationAdded", onAppInstalled);');
			External.call("eval", 'function onDealsResult(result){ document.getElementById("flashcontent").onDealsResult(result)}');
			External.call("eval", 'function onGetAppUsers(result){ document.getElementById("flashcontent").onGetAppUsers(result) } function flashGetAppUsers(){ console.log("flashGetAppUsers !!!"); VK.api("friends.getAppUsers", {}, onGetAppUsers)} VK.addCallback("onGetAppUsers",onGetAppUsers);');
			External.call("eval", 'function onGetAppUsersPhoto(result){document.getElementById("flashcontent").onGetAppUsersPhoto(result)}');
			External.call("eval", 'function getBalance(){ VK.api("getUserBalance", {}, onGetBalance); } function onBalanceChanged(result){ document.getElementById("flashcontent").onBalanceChanged(result)} function onGetBalance(result){document.getElementById("flashcontent").onGetBalance(result)} VK.addCallback("onBalanceChanged",onBalanceChanged);');
			External.call("eval", 'function flashGetUserSettings(){ VK.api("getUserSettings",{},function(data){if(data.response&256){onSettingsChanged(data);}else{VK.callMethod("showSettingsBox", 263);}}) } function onSettingsChanged(result){document.getElementById("flashcontent").onSettingsChanged(result)} VK.addCallback("onSettingsChanged",onSettingsChanged);');
			External.call("eval", 'function flashCheckIsMember(){ VK.api("groups.isMember",{ gid:"54213443", uid:' + application.parameters.viewer_id + ', extended:2 }, onCheckIsMember) } function onCheckIsMember(result){ document.getElementById("flashcontent").onCheckIsMember(result) }');
			External.call("eval", 'function flashInviteFriend(){VK.callMethod("showInviteBox")}');
			External.call("eval", 'function flashSetSize(width,height){ VK.callMethod("resizeWindow",width,height + 6 + 36); document.getElementById("flashcontent").style.width=width+"px";document.getElementById("flashcontent").style.height=height+"px"; }');
			External.call("eval", 'VK.addCallback("onWindowFocus",function(){ document.getElementById("flashcontent").style.visibility="visible" }); VK.addCallback("onWindowBlur", function(){ document.getElementById("flashcontent").style.visibility="hidden"; });');
			
			/**
			 * fix bug in Firefox
			 */
			//tabVisible
			External.call("eval", "" + "function tabVisible() {" + "var myObj = document.getElementById('flashcontent');" + "myObj.eventActive();" + "}");
			
			//tabHide
			External.call("eval", "" + "function tabHide() {" + "var myObj = document.getElementById('flashcontent');" + "myObj.eventDeActive();" + "}");
			External.call("eval", "" + "var val = navigator.userAgent.toLowerCase();" + "if(val.indexOf('firefox') > -1)" + "{" + "window.onfocus = tabVisible;" + "window.onblur = tabHide;" + "}");
			
			External.addCallBack('onSettingsChanged', onSettingsChanged);
			External.addCallBack('onCheckIsMember', onCheckIsMember);
			External.addCallBack('onGetBalance', onGetBalance);
			External.addCallBack('onDealsResult', onDealsResult);
			External.addCallBack('onBalanceChanged', onBalanceChange);
			External.addCallBack('onGetAppUsers', onGetAppUsers);
			External.addCallBack('onGetAppUsersPhoto', onGetAppUsersPhoto);
			External.addCallBack('onAppInstalled', onAppInstalled);
			External.addCallBack('onShareWithFriends', onShareWithFriends);
		
			External.addCallBack('eventActive', eventActive);
			External.addCallBack('eventDeActive', eventDeActive);
			
			//onInitializeSuccess.Invoke();
		}
		
		public function getUserData():void 
		{
			getAppUsersPhoto();
		}
		
		private function onShareWithFriends(data:Object = null):void
		{
			//QuestRecords.Shared = true;
		}
		
		private function onSettingsChanged(data:Object = null):void
		{
			if(data.hasOwnProperty('response'))
			{
				//QuestRecords.InMenu = ( data.response&256 );
			}
			else
			{
				//QuestRecords.InMenu = ( int(data)&256 );
			}
		}
		
		private function onCheckIsMember(data:Object = null):void
		{
			if(data.hasOwnProperty( 'response' ))
			{
				//QuestRecords.GroupMember = ( int(data.response.member) == 1 );
			}
		}
		
		private function onAppInstalled(result:Object = null):void
		{
			//ShowSettings();
		}
		
		public function wallPost(message:String):void 
		{
			if (External.available)
			{
				var attachments:String = 'photo-54213443_305369241, http://vk.com/app5359605_14242421';
				External.call('eval', 'VK.api("wall.post", {owner_id:' + application.parameters.viewer_id + ', message:"' + message + '", attachments:"' + attachments + '"}, function(data){}, function(data){});');
			}
		}
		
		public function GetDeals():void 
	    {
		    if (External.available)
			{
				External.call('VK.api("leads.getActive",{},onDealsResult)');
			}
	    }
		
		private function onDealsResult(result:Object):void 
		{
			var dealsCount:int = 0;
			if (result == null)
			{
				//Debug.Bug("[integration.vk.VKSocialService][onDealsResult]");
				return;
			}
			if (result is String)
			{
				//Debug.Bug("[integration.vk.VKSocialService][onDealsResult] " + result);
			}
			else
			{
				var list:Array = result.response as Array;
				if (list && list.length > 0)
				{
					dealsCount = list.length;
					//onDealsChanged.Invoke();
					//onDealsChanged.Invoke();
				}
				if (result.error)
				{
					//Debug.Bug(result.error);
					//onDealsChanged.Invoke();
				}
			}
		}
		
		public function showDeals():void 
		{
			if (External.available)
			{
				External.call('VK.callMethod("showOrderBox",{type:"offers",currency:1})');
			}
		}
		
		public function getCurrencyPrefix(currency:int):String
		{
			var currencyPrefix:String;
			var s:String = String(currency);
			var v:uint = parseInt(s.charAt(s.length - 1));
			if (v == 1)
			{
				currencyPrefix = " " + localize.localize(Texts.VOTE1);
			}
			else if (v > 1 && v < 5)
			{
				currencyPrefix = " " + localize.localize(Texts.VOTE);
			}
			else
			{
				currencyPrefix = " " + localize.localize(Texts.VOTES);
			}
			
			return currencyPrefix;
		}
		
		public function get photoSizePrefix():String
		{
			return "photo_medium";
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
			if (External.available)
			{
				External.call('flashInviteFriend');
			}
		}
		
		public function getAppUsers():void
		{
			if (External.available)
			{
				External.call('flashGetAppUsers');
			}
		}
		
		public function getAppUsersPhoto():void
		{
			var idList:Vector.<String> = new Vector.<String>();
			idList.push( application.parameters.viewer_id );
			if (External.available)
			{
				External.call( formatString('VK.api("users.get", {uids:"{0}", fields:"{1}"}, onGetAppUsersPhoto)', idList.join(","), "photo_100") );
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
			External.call("pay", item);
			gameApplication.fullScreen = false;
		}
		
		public function showDiscount(type:String, value:Number = 1):void
		{
			if (External.available)
			{
				External.call("VK.callMethod('showOrderBox', {type:'offers',currency:1})");
				gameApplication.fullScreen = false;
			}
		}
		
		private function onGetBalance(e:Object):void
		{
			if (External.available)
			{
				External.call('console.log', 'onGetBalance ' + e);
			}
		}
		
		private function onGetAppUsers(e:Object):void
		{
			var list:Array = e.response as Array;
			if (list == null)
			{
				if (External.available)
				{
					External.call('console.log', '[integration.vk.VKSocialService][onGetAppUsers] list == null');
				}
				return;
			}
			
			//friendsId = { };
			//this.friends = new Vector.<SocialFriend>();
			//var current:SocialFriend;
			for (var i:int = 0; i < list.length; i++) 
			{
				if (External.available)
				{
					External.call('console.log', 'list[i] ' + list[i]);
				}
				//current = new SocialFriend(list[i]);
				//if (current)
				//{
				//	this.friends.push(current);
				//	this.friendsId[list[i]] = current;
				//}
				//SafeInvoke.TryInvoke(onGetAppUsersChanged.Invoke);
			}
		}
		
		private function onGetAppUsersPhoto(e:Object):void
		{
			if (External.available)
			{
				External.call('console.log', 'VKSocialService.onGetAppUsersPhoto');
				External.call('console.log', e);
			}
			var list:Array = e.response as Array;
			if (list == null)
			{
				if (External.available)
				{
					External.call('console.log', '[integration.vk.VKSocialService][onGetAppUsersPhoto] list == null');
				}
				return;
			}
			
			//var current:SocialFriend;
			for (var i:int = 0; i < list.length; i++) 
			{
				//current = GetFriendById(list[i].uid);
				if(list[i].uid == application.parameters.viewer_id)
				{
					userManager.socialName = list[i].first_name;
				}
				//if (current)
				//{
				//	current.first_name = list[i].first_name;
				//	current.last_name = list[i].last_name;
				//	current.photoUrl = list[i].photo_100;
				//} 
				//else
				//{
				//	Debug.Bug("[integration.vk.VKSocialService][onGetAppUsersPhoto]");
				//}
			}
			
			//SafeInvoke.TryInvoke(onGetAppUsersPhotoChanged.Invoke);
		}
		
		private function onBalanceChange(e:Object):void
		{
			if (External.available)
			{
				External.call('console.log', 'onBalanceChange ' + e);
			}
			
			//this.balance = int(e);
			//SafeInvoke.TryInvoke(onBalanceChanged.Invoke);
		}
		
		public function openGroupPage():void
		{
			var targetURL:URLRequest = new URLRequest("http://vk.com/club54213443");
			navigateToURL(targetURL, "_blank");
		}
		
		public function checkIsGroupMember():void
		{
			if (External.available)
			{
				External.call('flashCheckIsMember');
			}
		}
		
		public static function CheckIsInMenu():void
		{
			if (External.available)
			{
				External.call('flashGetUserSettings');
			}
		}
		
		public function shareWithFriends():void
		{
			if (External.available)
			{
				var messages:Array = ['Сразись со мной в "Карта Пирата"','Управляй своей армией сумасшедших пиратов','Никто меня еще не победил в этой игре','Кто посмеет бросить вызов чемпиону?'];
				var message:String = messages[int(Math.random()*messages.length)];
				var attachments:String = 'photo-54213443_305369241, http://vk.com/app5359605_14242421';
				External.call('eval', 'VK.api("wall.post", {owner_id:' + application.parameters.viewer_id + ', message:"' + message + '", attachments:"' + attachments + '"}, function(data){},onShareCallback);function onShareCallback(result){document.getElementById("flashcontent").onShareWithFriends(result)}');
			}
		}
		
		public function eventActive():void
		{
			//Activity.OnActive.Invoke();
		}
		
		public function eventDeActive():void
		{
			//Activity.OnDeactive.Invoke();
		}
	}
}
