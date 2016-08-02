package game.managers.purchase.ios
{
	import com.freshplanet.ane.AirInAppPurchase.InAppPurchase;
	import com.freshplanet.ane.AirInAppPurchase.InAppPurchaseEvent;
	import common.events.EventDispatcher;
	import common.system.utils.Base64;
	import flash.utils.ByteArray;
	import game.configurations.Configuration;
	import game.managers.purchase.IPurchase;
	import game.managers.purchase.PurchaseEvent;
	import game.managers.purchase.PurchasesTrackedManager;
	import game.managers.users.UserEvent;
	import game.managers.users.UserManager;
	import game.modules.logs.ILogger;
	import game.net.ServerRequest;
	import game.records.gems.GemRecord;
	import game.records.gems.GemRecordMap;
	import integration.SocialType;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class IOSPurchase extends EventDispatcher implements IPurchase
	{
		private var _ipa:InAppPurchase;
		
		private var _restored:Boolean;
		private var _failed:Boolean;
		private var _isAvailablePurchase:Boolean;
		private var _itemsArray:Array;
		private var _loadedProducts:Object;
		private var _transactions:Object;
		
		private var _userManager:UserManager;
		private var _gemsMap:GemRecordMap;
		private var _logger:ILogger;
		private var _configuration:Configuration;
		private var _tracker:PurchasesTrackedManager;
		private var _request:ServerRequest;
		
		public function IOSPurchase(logger:ILogger, configuration:Configuration, tracker:PurchasesTrackedManager, request:ServerRequest, userManager:UserManager, gemsMap:GemRecordMap)
		{
			_gemsMap = gemsMap;
			_userManager = userManager;
			_request = request;
			_tracker = tracker;
			_configuration = configuration;
			_logger = logger;
			
			_restored = false;
			_failed = false;
			_isAvailablePurchase = false;
			_itemsArray = [];
			_loadedProducts = {};
			_transactions = {};
			
			_userManager.addEventListener(UserEvent.INITIALIZE, onInitializeUserHandler);
			
			_ipa = InAppPurchase.getInstance();
			
			_ipa.init("", false);
			_ipa.addEventListener(InAppPurchaseEvent.PRODUCT_INFO_ERROR, onProductError);
			_ipa.addEventListener(InAppPurchaseEvent.PRODUCT_INFO_RECEIVED, onProductReseived);
			_ipa.addEventListener(InAppPurchaseEvent.PURCHASE_DISABLED, onPurchaseDisabled);
			_ipa.addEventListener(InAppPurchaseEvent.PURCHASE_ENABLED, onPurchaseEnabled);
			_ipa.addEventListener(InAppPurchaseEvent.PURCHASE_ERROR, onPurchaseError);
			_ipa.addEventListener(InAppPurchaseEvent.PURCHASE_SUCCESSFULL, onPurchaseSuccessFull);
		}
		
		private function getPurchaseSku(productId:int):String
		{
			return "buy_item_" + productId;
		}
		
		private function onInitializeUserHandler(e:UserEvent):void
		{
			_itemsArray = [];
			for each (var record:GemRecord in _gemsMap.getByPlatformId(SocialType.IOS))
			{
				_itemsArray.push(getPurchaseSku(record.productId));
			}
			_logger.note("[game.managers.purchase.ios.IOSPurchase][onInitializeUserHandler]");
			restore();
		}
		
		public function restore():void
		{
			_ipa.getProductsInfo(_itemsArray, null);
		}
		
		/* INTERFACE game.managers.purchase.IPurchase */
		
		public function purchase(id:int):void
		{
			var product:String = getPurchaseSku(id);
			if (_isAvailablePurchase && checkHasProduct(product))
			{
				_ipa.makePurchase(product);
			}
		}
		
		public function getPrice(productId:int):String
		{
			var obj:Object = _loadedProducts[getPurchaseSku(productId)];
			if (obj)
			{
				return obj.price;
			}
			return null;
		}
		
		public function getName(productId:int):String
		{
			var obj:Object = _loadedProducts[getPurchaseSku(productId)];
			if (obj)
			{
				return obj.title;
			}
			return null;
		}
		
		/* INTERFACE game.managers.purchase.IPurchase */
		
		public function adjustPurchase(orderId:String, purchaseStatus:int):void
		{
			var purchase:String = _transactions[orderId];
			if (purchase)
			{
				_tracker.getNotTrackedPurchases();
				_ipa.removePurchaseFromQueue(purchase, "");
			}
		}
		
		public function get restored():Boolean
		{
			return _restored;
		}
		
		public function get failed():Boolean
		{
			return _failed;
		}
		
		protected function onPurchaseSuccessFull(event:InAppPurchaseEvent):void
		{
			//if (isShowPopup)
			//{
			//UIPopupWaitPurchase.hide();
			//isShowPopup = false;
			//}
			
			_logger.note("[game.managers.purchase.ios.IOSPurchase][onPurchaseSuccessFull]");
			
			var purchase:Object = JSON.parse(event.data);
			if (purchase == null)
			{
				_logger.error("[game.managers.purchase.ios.IOSPurchase][onPurchaseSuccessFull] can't parse json");
			}
			else
			{
				var receipt:String = purchase["receipt"];
				var buyItemId:String = purchase["productId"];
				var transactionId:String = purchase["transactionId"];
				_transactions[transactionId] = buyItemId;
				
				if (receipt == null || buyItemId == null)
				{
					_logger.error("[game.managers.purchase.ios.IOSPurchase][onPurchaseSuccessFull] INVALID DATA.");
				}
				else
				{
					var sandboxMode:Boolean = isSandboxMode(receipt);
					var encodeReceipt:String = Base64.encodeString(String(receipt));
					
					_request.applePurchaseVerification(buyItemId, sandboxMode, encodeReceipt);
				}
			}
		}
		
		protected function onPurchaseError(event:Object):void
		{
			//if (isShowPopup)
			//{
			//UIPopupWaitPurchase.hide();
			//isShowPopup = false;
			//}
			
			_logger.error("[game.managers.purchase.ios.IOSPurchase][onPurchaseError]");
		}
		
		protected function onPurchaseEnabled(event:Object):void
		{
			_logger.note("[game.managers.purchase.ios.IOSPurchase][onPurchaseEnabled]");
		}
		
		protected function onPurchaseDisabled(event:Object):void
		{
			_logger.error("[game.managers.purchase.ios.IOSPurchase][onPurchaseDisabled]");
		}
		
		protected function onProductReseived(event:InAppPurchaseEvent):void
		{
			_isAvailablePurchase = true;
			_loadedProducts = JSON.parse(event.data);
			_restored = true;
			_logger.error("[game.managers.purchase.ios.IOSPurchase][onProductReseived]");
			dispatchEventAs(PurchaseEvent, PurchaseEvent.RESTORED);
		}
		
		protected function onProductError(event:Object):void
		{
			_failed = true;
			_logger.error("[game.managers.purchase.ios.IOSPurchase][onProductError]");
			dispatchEventAs(PurchaseEvent, PurchaseEvent.FAILED);
		}
		
		private function checkHasProduct(id:String):Boolean
		{
			return _loadedProducts[id] != null;
		}
		
		private static function isSandboxMode(receipt:String):Boolean
		{
			return receipt.indexOf("Sandbox") >= 0;
		}
	
	}

}