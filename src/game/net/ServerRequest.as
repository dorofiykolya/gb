package game.net
{
	import common.system.utils.ObjectUtils;
	import flash.utils.getTimer;
	import game.modules.net.IConnectionSend;
	import game.net.requests.InitializeUserInfoRequest;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ServerRequest
	{
		private var _sender:IConnectionSend;
		
		public function ServerRequest(sender:IConnectionSend)
		{
			_sender = sender;
		}
		
		public function get time():int
		{
			return getTimer();
		}
		
		public function send(value:Object):void
		{
			_sender.send(value);
		}
		
		public function sessionVerification(sessionId:String):void
		{
			send({sessionVerification: {sessionId: sessionId}});
		}
		
		public function authByDevelopers(developerId:String):void
		{
			send({authByDevelopers: {userKey: developerId}});
		}
		
		public function authByAndroid(deviceId:String):void
		{
			send({authByAndroid: {deviceId: deviceId}});
		}
		
		public function authByIOS(deviceId:String):void
		{
			send({authByIOS: {deviceId: deviceId}});
		}
		
		public function versionHashes():void
		{
			send({versionHashes: {}});
		}
		
		public function clientTime():void
		{
			send({clientTime: {time: time}});
		}
		
		public function deviceInfo():void
		{
			send({deviceInfo: {}});
		}
		
		public function initializeUserInfo(value:InitializeUserInfoRequest):void
		{
			value.initializeUserInfo.time = time;
			send(value);
		}
		
		public function userAuth(userKey:int, authTS:int, authKey:String, isBrowser:Boolean):void
		{
			send({userAuth: {userKey: userKey, authTS: authTS, authKey: authKey, isBrowser: isBrowser}});
		}
		
		public function baseInfo():void
		{
			send({baseInfo: {}});
		}
		
		public function startTrainingFight():void
		{
			send({startTrainingFight: {}});
		}
		
		public function localizationInfo():void
		{
			send({localizationInfo: {}});
		}
		
		public function reboot():void
		{
			send({reboot: {}});
		}
		
		public function purchasesTracked(objectIds:Vector.<int>):void
		{
			send({purchasesTracked: {objectIds: ObjectUtils.toObject(objectIds)}});
		}
		
		public function getNotTrackedPurchases(paymentType:int):void
		{
			send({getNotTrackedPurchases: {paymentType: paymentType}});
		}
		
		public function androidPurchase(receipt:String, signature:String, referral:String = null):void
		{
			send({androidPurchase: {receipt: receipt, signature: signature, referral: referral}});
		}
		
		public function applePurchaseVerification(objectId:String, test:Boolean, receipt:String):void
		{
			send({applePurchaseVerification: {object_id: objectId, test: test, receipt: receipt}});
		}
		
		public function settings(language:String, sounds:Boolean, music:Boolean):void
		{
			send({settings: {language: language, sounds: sounds, music: music}});
		}
	
	}

}