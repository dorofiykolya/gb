package game.managers.integration.fb 
{
	import common.context.IContext;
	import common.system.application.Application;
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
	public class FBSocialService implements ISocialService, IConfigurable
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
		
		private var _item:String;
		protected var lastWallPostTime:int;
		
		//action type
		public static const CUSTOM_ACTION_TYPE_COMPLETE:String = "complete";
		public static const CUSTOM_ACTION_TYPE_OPEN:String = "open";
		public static const CUSTOM_ACTION_TYPE_UPGRADE:String = "upgrade";
		
		//object type
		public static const CUSTOM_OBJECT_TYPE_CAMPAIGN:String = "campaign";
		public static const CUSTOM_OBJECT_TYPE_TROOP:String = "troop";
		public static const CUSTOM_OBJECT_TYPE_TOWN_HALL:String = "town_hall";
		
		public function get id():int 
		{
			return SocialType.FACEBOOK;
		}
		
		public function get prefix():String 
		{
			return "fb";
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void 
		{
			
		}
		
		public function initilize():void 
		{
			//PURCHASE
			External.call("eval", "" +
				"function buy(item, language) " +
				"{ " +
				"var obj = {" +
				"method: 'pay'," +
				"action: 'purchaseitem'," +
				"product: 'http://pirates.restr.net/'+item+'.html', " +
				"}; " +
				"FB.ui(obj, onPurchaseCallback);" +
				"}" +
				"function onPurchaseCallback(response) " +
				"{ " +
				"document.getElementById('flashcontent').onPurchaseCallback(response)"+
				"}"
			);
			External.addCallBack('onPurchaseCallback', onPurchaseCallback);
			
			
			//SHARE POSN ON WALL
			External.call("eval", "" +
				"function sharePost() " +
				"{ " +
				"FB.ui(" +
				"{" +
				"method: 'feed'," +
				"name: 'Battle of Zombie'," +
				"link: 'https://apps.facebook.com/battle_of_zombies/'," +
				"picture: 'http://cdn01.restr.net/icon.jpg'," +
				"description: 'Play with me in game Battle of Zombie'" +
				"},	" +
				"onSharePostCallback);" +
				"}" +
				"function onSharePostCallback(response) " +
				"{ " +
				"document.getElementById('flashcontent').onSharePostCallback(response)"+
				"}"
			);
			External.addCallBack('onSharePostCallback', onSharePostCallback);
			
			
			//GET LIST OF FRIENDS
			External.call("eval", "" +
				"function friendList() " +
				"{ " +
				"FB.api('me/friends?fields=installed,name', onFriendListCallback);" +
				"}" +
				"function onFriendListCallback(response) " +
				"{ " +
				"document.getElementById('flashcontent').onGetAppUsers(response)"+
				"}"
			);
			External.addCallBack('onGetAppUsers', onGetAppUsers);
			
			//GET LIST OF FRIENDS PHOTO
			External.call("eval", "" +
				"function friendListPhoto() " +
				"{ " +
				"FB.api('me/friends?fields=installed,first_name,last_name', onFriendListPhotoCallback);" +
				"}" +
				"function onFriendListPhotoCallback(response) " +
				"{ " +
				"document.getElementById('flashcontent').onGetAppUsersPhoto(response)"+
				"}"
			);
			
			//GET USER DATA
			External.call("eval", "" +
				"function getUserData() " +
				"{ " +
				"FB.api('me?fields=id,first_name, last_name', onGetUserDataCallback);" +
				"}" +
				"function onGetUserDataCallback(response) " +
				"{ " +
				"console.log('response');" +
				
				"document.getElementById('flashcontent').onGetUserData(response)"+
				"}"
			);
			
			
			/**
			 * fix bug in Firefox
			 */
			//tabVisible
			External.call("eval", "" +
				"function tabVisible() {"+
				"var myObj = document.getElementById('flashcontent');"+
				"myObj.eventActive();"+
				"}" );
			
			//tabHide
			External.call("eval", "" +
				"function tabHide() {"+
				"var myObj = document.getElementById('flashcontent');"+
				"myObj.eventDeActive();"+
				"}");
			External.call("eval", "" +
				"var val = navigator.userAgent.toLowerCase();"+
				"if(val.indexOf('firefox') > -1)"+
				"{"+
				"window.onfocus = tabVisible;"+
				"window.onblur = tabHide;"+
				"}");
			
//			//Post achievements
			/*External.call('eval', '' +
				'function postAchievement(id, level) ' +
				'{ ' +
					'console.log("Send achievements");'+
					'var obj = new Object();' +
					'var key = "achievement";' +
					'obj[key] = "'+GameConstants.FACEBOOK_CANVAS_URL+'/'+GameConstants.FACEBOOK_APP_NAME+'/'+'achievement-id-"+id+"-level-"+level+".html";'+
					'FB.api("/me/achievements", "post", obj, function (responceAchievements) { console.log(responceAchievements);});'+
				'}'
			);*/
			
//			External.call('eval', '' +
//				'function postAchievement(id, level) ' +
//				'{ ' +
//					'console.log("Console log");'+
//					'var obj = new Object();' +
//					'var key = "achievement";' +
//					'obj[key] = "http://cdn01.restr.net/zombie-test/achievement-id-2-level-3.html";'+
//					'FB.api("/me/achievements", "post", obj, function (responceAchievements) { console.log(responceAchievements);});'+
//				'}'
//			);
			
			//Post custom story
			External.call("eval", "" +
				"function postCustomStory(actionTypeWithHost, objectType, fileURL) " +
				"{ " +
					"console.log('actionTypeWithHost = '+actionTypeWithHost);" +
					"var obj = new Object();" +
					"var key = ''+objectType;" +
					"obj[key] = fileURL;"+
					"FB.api(''+actionTypeWithHost, 'post', obj, function (responceFacebook) { console.log(responceFacebook);});" +
				"}"
			);
			
			External.addCallBack('onGetAppUsersPhoto', onGetAppUsersPhoto);
			External.addCallBack('onGetUserData', onGetUserData);
			
			External.addCallBack('eventActive', eventActive);
			External.addCallBack('eventDeActive', eventDeActive);
			
			//onInitializeSuccess.Invoke();
		}
		
		private function onPurchaseCallback(response:Object = null):void
		{
			if(response == null && response.status != "complete" && _item == null)
			{
				trace("onPurchaseCallback Error");
				return;
			}
			
			//ServerRequest.sendFBPurchaseVerification( String(_item), response.amount, response.currency, response.payment_id, response.quantity, response.signed_request, response.status);
			
			_item = null;
		}
		
		private function onSharePostCallback(response:Object = null):void
		{
			if (response && response.post_id) {
				
			} else {
				
			}
		}
		
		private function onShareWithFriends(data:Object = null):void
		{
			//QuestRecords.Shared = true;
		}
		
		private function onFriendListCallback(response:Object = null):void		
		{
			
		}
		
		private function onAppInstalled(result:Object = null):void
		{
			//showSettings();
		}
		
		public function get available():Boolean
		{
			return true;
		}
		
		public function wallPost(message:String):void 
		{
			/*if (External.available)
			{
				if(getTimer() - lastWallPostTime < GameConstants.DELAY_WALL_POST)
				{
					return;
				}
				
				lastWallPostTime = getTimer();
				
				var result:String = JSON.stringify(
					   {method: "feed",
						name: "Battle of Zombie",
						link: "https://apps.facebook.com/battle_of_zombies/",
						picture: "http://cdn01.restr.net/icon.jpg",
						description: message } 
						);
				
				External.call('eval', 
					"FB.ui(" + result + ",	function(data){});"
				);
					
					
			}*/
		}
		
		public function getDeals():void 
		{
			//			if (External.available)
			//			{
			//				External.call('VK.api("leads.getActive",{},onDealsResult)');
			//			}
		}

		public function getCurrencyPrefix(currency:int):String
		{
			var currencyPrefix:String;
			var s:String = String(currency);
			var v:uint = parseInt(s.charAt(s.length - 1));
			if (v == 1)
			{
				currencyPrefix = " " + localize.localize(Texts.USD);
			}
			else if (v > 1 && v < 5)
			{
				currencyPrefix = " " + localize.localize(Texts.USD);
			}
			else
			{
				currencyPrefix = " " + localize.localize(Texts.USD);
			}
			
			return currencyPrefix;
		}
		
		public function getUserData():void
		{
			if (External.available)
			{
				External.call("getUserData");
			}
		}
		
		public function getAppUsers():void
		{
			if (External.available)
			{
				getUserData();
				External.call("friendList");
			}
		}
			
		public function getAppUsersPhoto():void
		{
			if (External.available)
			{
				External.call("friendListPhoto");
			}
		}
			
		public function getBalance():void
		{
			//			if (External.available)
			//			{
			//				External.call('getBalance');
			//			}
		}
			
		public function showPayment(price:int, resourseCount:int, item:String):void
		{
			if (item == null)
			{
				if (External.available)
				{
					External.call('console.log', '[integration.fb.FBSocialService][showPayment] error: item == null');
				}
				return;
			}
			
			if (External.available)
			{
				_item = item;
				gameApplication.fullScreen = false;
				External.call("buy", item, localizationManager.language);
			}
		}
		
		private function onGetBalance(e:Object):void
		{
			//			this.balance = e.response;
			//			SafeInvoke.TryInvoke(onBalanceChanged.Invoke);
		}
		//		
		private function onGetAppUsers(response:Object):void
		{
			var list:Array = response.data as Array;
			
			if (list == null)
			{
				External.call('console.log', '[integration.fb.FBSocialService][onGetAppUsers] error: list == null');
				return;
			}
			
			//friendsId = { };
			//this.friends = new Vector.<SocialFriend>();
			
			//var current:SocialFriend;
			for (var i:int = 0; i < list.length; i++) 
			{
				if(!list[i].installed)
				{
					continue;
				}
				
				//current = new SocialFriend(list[i].id);
				//this.friends.push(current);
                //this.friendsId[list[i].id] = current;
			}
			
			//SafeInvoke.TryInvoke(onGetAppUsersChanged.Invoke);
		}
		
		public function onGetUserData(response:Object):void
		{
			if(response == null)
			{
				return;	
			}
			
			if(response.first_name != null)
			{
				userManager.socialName = response.first_name;
			}
		}
		
		private function onGetAppUsersPhoto(response:Object):void
		{
			var list:Array = response.data as Array;
			if (list == null)
			{
				External.call('console.log', '[integration.fb.FBSocialService][onGetAppUsersPhoto] error: list == null');
				return;
			}
			
			for (var i:int = 0; i < list.length; i++) 
			{
				if(!list[i].installed)
				{
					continue;
				}
				
				if(list[i].id == application.parameters.viewer_id)
				{
					userManager.socialName = list[i].first_name;
				}
				//if (current)
				//{
				//	current.first_name = list[i].first_name;
				//	current.last_name = list[i].last_name;
				//	current.photoUrl = "https://graph.facebook.com/"+list[i].id+"/picture?height=81&width=81";
				//} 
				//else
				//{
				//	Debug.Bug("[integration.facebook.FBSocialService][onGetAppUsersPhoto]");
				//}
			}
			
			//SafeInvoke.TryInvoke(onGetAppUsersPhotoChanged.Invoke);
		}
		//		
		private function onBalanceChange(e:*):void
		{
			//			this.balance = int(e);
			//			SafeInvoke.TryInvoke(onBalanceChanged.Invoke);
		}
			
		public function shareWithFriends():void
		{
			if (External.available)
			{
				
				External.call("sharePost");
				//				var messages:Array = ['Сразись со мной в "Битва зомби"','Управляй своей армией сумасшедших зомби','Никто меня еще не победил в этой игре','Кто посмеет бросить вызов чемпиону?'];
				//				var message:String = messages[int(Math.random()*messages.length)];
				//				var attachments:String = 'photo-54213443_305369241, http://vk.com/zombiebattle';
				//				
				//				External.call('eval', 'VK.api("wall.post", {owner_id:' + Application.Parameters.viewer_id + ', message:"' + message + '", attachments:"' + attachments + '"}, function(data){},onShareCallback);function onShareCallback(result){document.getElementById("flashcontent").onShareWithFriends(result)}');
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
		
		public function postAchievement(id:int, level:int):void
		{
			if (External.available)
			{
				External.call("postAchievement", String(id), String(level));
			}
		}
		public function postCustomStory(actionType:String, objectType:String, fileName:String):void
		{
			//var actionTypeWithHost:String = "me/"+GameConstants.FACEBOOK_APP_NAME+":"+actionType;
			//var fileURL:String = GameConstants.FACEBOOK_CANVAS_URL+"/"+GameConstants.FACEBOOK_APP_NAME+"/"+fileName;		   
			//External.call("postCustomStory", actionTypeWithHost, objectType, fileURL);
		}
		
	}

}