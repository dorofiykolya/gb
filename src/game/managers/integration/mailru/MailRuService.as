package game.managers.integration.mailru 
{
	import com.mailru.MailruCall;
	import com.mailru.MailruCallEvent;
	import common.context.IContext;
	import common.system.application.Application;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
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
	 * @author ...
	 */
	public class MailRuService implements ISocialService, IConfigurable
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
		
		public function get id():int 
		{
			return SocialType.MAILRU;
		}
		
		public function get prefix():String 
		{
			return "mr";
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void 
		{
			
		}
		
		public function initilize():void 
		{
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
			
			External.addCallBack("flashInviteStatus", onInviteStaus);
			External.addCallBack("paymentDialogStatus", onShowHideDialog);
			External.addCallBack("incomingPayment", onIncomingPayment);
			External.addCallBack('onGetBalance', onGetBalance);
			External.addCallBack('onGetAppUsers', onGetAppUsers);
			External.addCallBack('onGetAppUsersPhoto', onGetAppUsersPhoto);
			External.addCallBack('eventActive', eventActive);
			External.addCallBack('eventDeActive', eventDeActive);
			External.call('eval', "function flashInviteFriend(){mailru.app.friends.invite();}mailru.events.listen(mailru.app.events.friendsInvitation, function (event){document.getElementById('flashcontent').flashInviteStatus(event);});function flashGetAppUsers(){ mailru.events.listen('mailru.common.friends.getAppUsers', onGetAppUsers); mailru.common.friends.getAppUsers(onGetAppUsers); }; function onGetAppUsers(result){document.getElementById('flashcontent').onGetAppUsers(result)};function flashSetSize(width,height){mailru.app.utils.setHeight(height+6+36);document.getElementById('flashcontent').style.height=height+'px';} function flashInviteFriend(){mailru.app.friends.invite();}mailru.events.listen(mailru.app.events.paymentDialogStatus, function (event){document.getElementById('flashcontent').paymentDialogStatus(event);});mailru.events.listen(mailru.app.events.incomingPayment, function (event){document.getElementById('flashcontent').incomingPayment(event);}); function pay(objectId, price, product){mailru.app.payments.showDialog({service_id:objectId,service_name:product,mailiki_price:price});}function getBalance(){mailru.common.users.getBalance(onGetBalance);}function onGetBalance(data){document.getElementById('flashcontent').onGetBalance(data.balance);}function getPhoto(list){mailru.common.users.getInfo(onGetAppUsersPhoto,list);}function onGetAppUsersPhoto(result){document.getElementById('flashcontent').onGetAppUsersPhoto(result)}");
			MailruCall.addEventListener(Event.COMPLETE, function():void {
				External.call('console.log', 'MailRuReady');
				//onInitializeSuccess.Invoke();
			});
			MailruCall.init("flashcontent", "39b2651c3cad191e3e703056322f75f9");
		}
		
		public function getUserData():void 
		{
			getAppUsersPhoto();
		}
		
		private function onInviteStaus(e:Object):void
		{
			External.call("console.log", 'MailRuService.onInviteStaus');
			External.call("console.log", e);
		}
		
		public function wallPost( message:String ):void
		{
			External.call("console.log", 'MailRuService.WallPost');
			External.call('eval', 'mailru.common.stream.post({title:"Битва Зомби", text: "' + message + '", img_url: "http://content.foto.mail.ru/mail/warowow/_myapps/s-30.jpg", action_links: [{"text":"перейти к игре","href": "link"}]})');
		}
		
		//public function get balancePrefix():String 
		//{
		//	return getCurrencyPrefix( balance );
		//}
		
		public function getCurrencyPrefix(currency:int):String
		{
			var currencyPrefix:String;
			var s:String = String(currency);
			var v:uint = parseInt(s.charAt(s.length-1));
			if (v == 1)
			{
				currencyPrefix = " мэйлик";
			}
			else if (v > 1 && v < 5)
			{
				currencyPrefix = " мэйлика";
			}
			else
			{
				currencyPrefix = " мэйликов";
			}
			
			return currencyPrefix;
		}
		
		public function get photoSizePrefix():String
		{
			return "pic";
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
				External.call('getPhoto', idList.join(','));
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
			if (External.available) 
			{
				External.call("pay", item, price, resourseCount + ' ' + gemsTextForCount( resourseCount ));
				gameApplication.fullScreen = false;
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
		
		private function onGetBalance(e:Object):void 
		{
			//this.balance = int(e);
			//SafeInvoke.TryInvoke(onBalanceChanged.Invoke);
		}
		
		private function onGetAppUsers(e:Object):void 
		{
			var list:Array = e as Array;
			if (list == null)
			{
				External.call('console.log', '[integration.mailru.MailRuService][onGetAppUsers] list == null');
				return;
			}
			
			//friendsId = { };
			//this.friends = new Vector.<SocialFriend>();
			
			//var current:SocialFriend;
			for (var i:int = 0; i < list.length; i++) 
			{
				//current = new SocialFriend(list[i]);
				//this.friends.push(current);
				//this.friendsId[list[i]] = current;
			}
			//SafeInvoke.TryInvoke(onGetAppUsersChanged.Invoke);
		}
		
		private function onGetAppUsersPhoto(e:Object):void 
		{
			//if (friends == null)
			//{
			//	return;
			//}
			
			var list:Array = e as Array;
			if (list == null)
			{
				External.call('console.log', '[integration.mailru.MailRuService][onGetAppUsersPhoto] list == null');
				return;
			}
			//var current:SocialFriend;
			for (var i:int = 0; i < list.length; i++) 
			{
				//current = GetFriendById(list[i].uid);
				if( list[i].uid == application.parameters.viewer_id )
				{
					userManager.socialName = list[i].first_name;
				}
				//if (current)
				//{
				//	current.first_name = list[i].first_name;
				//	current.last_name = list[i].last_name;
				//	current.photoUrl = list[i].pic;
				//} 
				//else
				//{
				//	Debug.Bug("[integration.mailru.MailRuService][onGetAppUsersPhoto]");
				//}
			}
			
			// SafeInvoke.TryInvoke(onGetAppUsersPhotoChanged.Invoke);
		}
		
		private function onBalanceChange(e:*):void
		{
			//this.balance = int(e);
			//SafeInvoke.TryInvoke(onBalanceChanged.Invoke);
			
			//ServerRequest.send( { balance: { count:int(e) }} );
		}
		
		private function onMailRuReady(e:Event):void 
		{
			External.call('console.log', 'MailRuReady');
			//MailruCall.exec('mailru.common.friends.getAppUsers', onGetAppUsersPhoto);
		}
		
		private function onShowHideDialog(...p):void
		{
			External.call('console.log', 'ShowHideDialog');
			External.call('console.log', p);
		}
		
		private function onIncomingPayment(...p):void
		{
			External.call('console.log', 'onIncomingPayment');
			External.call('console.log', p);
		}
		
		public function openGroupPage():void
		{
			var targetURL:URLRequest = new URLRequest("http://my.mail.ru/community/zombiewar/");
			navigateToURL(targetURL, "_blank");
		}
		
		public function checkIsGroupMember():void
		{
			//QuestRecords.GroupMember = true;
		}
		
		public function ShareWithFriends():void
		{
			if (External.available)
			{
				var messages:Array = ['Сразись со мной в "Битва зомби"','Управляй своей армией сумасшедших зомби','Никто меня еще не победил в этой игре','Кто посмеет бросить вызов чемпиону?'];
				var message:String = messages[int(Math.random()*messages.length)];
				MailruCall.addEventListener( MailruCallEvent.STREAM_PUBLISH, eventLog );
				External.call('eval', 'mailru.common.stream.post({title:"Битва Зомби", text: "' + message + '", img_url: "http://content.foto.mail.ru/mail/warowow/_myapps/s-30.jpg", action_links: [{"text":"перейти к игре","href": "link"}]})');
			}
		}
		
		private function eventLog ( e:MailruCallEvent ):void
		{
			if (External.available)
			{
				//External.call('console.log', 'MailRu EVENT: ' + e.type + ': ' + System.Type.Type.Inspect(e.data));
				External.call('console.log', 'status: ' + e.data.status);
				if(e.data.status == "publishSuccess")
				{
					//QuestRecords.Shared = true;
				}
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