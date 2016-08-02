package game.managers.purchase.android
{
	import com.pozirk.payment.android.InAppPurchase;
	import com.pozirk.payment.android.InAppPurchaseDetails;
	import com.pozirk.payment.android.InAppPurchaseEvent;
	import com.pozirk.payment.android.InAppSkuDetails;
	import common.events.EventDispatcher;
	import common.system.Delegate;
	import common.system.text.StringUtil;
	import common.system.utils.ObjectUtils;
	import game.configurations.Configuration;
	import game.managers.purchase.IPurchase;
	import game.managers.purchase.PurchaseEvent;
	import game.managers.purchase.PurchaseStatus;
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
	public class AndroidPurchase extends EventDispatcher implements IPurchase
	{
		/**
		 * max product items by restore to Google Play
		 */
		private static const MAX_ITEM:int = 10;
		
		private var _iap:InAppPurchase;
		private var _logger:ILogger;
		private var _products:Object;
		private var _lastOrderedList:Vector.<InAppPurchaseDetails>;
		private var _configuration:Configuration;
		private var _tracker:PurchasesTrackedManager;
		private var _request:ServerRequest;
		
		/**
		 * if length items > 20, google play throw error
		 */
		private var _itemsQueue/*of int*/:Array;
		private var _itemsArray:Array;
		private var _userManager:UserManager;
		private var _gemsMap:GemRecordMap;
		private var _restored:Boolean;
		private var _failed:Boolean;
		
		public function AndroidPurchase(logger:ILogger, configuration:Configuration, tracker:PurchasesTrackedManager, request:ServerRequest, userManager:UserManager, gemsMap:GemRecordMap)
		{
			_gemsMap = gemsMap;
			_userManager = userManager;
			_request = request;
			_tracker = tracker;
			_configuration = configuration;
			_logger = logger;
			_products = {};
			_itemsQueue = [];
			_itemsArray = [];
			_lastOrderedList = new Vector.<InAppPurchaseDetails>();
			_restored = false;
			_failed = false;
			
			_userManager.addEventListener(UserEvent.INITIALIZE, onInitializeUserHandler);
			
			try
			{
				_iap = new InAppPurchase();
				_iap.addEventListener(InAppPurchaseEvent.INIT_SUCCESS, setup_successHandler);
				_iap.addEventListener(InAppPurchaseEvent.INIT_ERROR, setup_failureHandler);
				
				_iap.init(_configuration.ANDROID_GOOGLE_PLAY_INAPP_BILLING_KEY);
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][AndroidPurchase]", e);
			}
		}
		
		private function onInitializeUserHandler(e:UserEvent):void
		{
			_itemsArray = [];
			_products = {};
			for each (var record:GemRecord in _gemsMap.getByPlatformId(SocialType.ANDROID))
			{
				_itemsArray.push(getPurchaseSku(record.productId));
			}
			_logger.note("[game.managers.purchase.android.AndroidPurchase][onInitializeUserHandler]");
			restore();
		}
		
		private function getPurchaseSku(productId:int):String
		{
			return "buy_item_" + productId;
		}
		
		/* INTERFACE game.managers.purchase.IPurchase */
		
		public function purchase(id:int):void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][purchase] try purchase id:" + id);
				
				_iap.addEventListener(InAppPurchaseEvent.PURCHASE_SUCCESS, purchase_successHandler);
				_iap.addEventListener(InAppPurchaseEvent.PURCHASE_ALREADY_OWNED, purchase_successHandler);
				_iap.addEventListener(InAppPurchaseEvent.PURCHASE_ERROR, purchase_failedHandler);
				_iap.purchase(getPurchaseSku(id), InAppPurchaseDetails.TYPE_INAPP);
				
				_logger.note("[game.managers.purchase.android.AndroidPurchase][purchase] purchase requested id:" + id);
				
				_configuration.ignoreExit = true;
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][purchase]", e);
			}
		}
		
		public function getPrice(id:int):String
		{
			var product:InAppSkuDetails = getProduct(id);
			if (product)
			{
				return product._price;
			}
			return null;
		}
		
		public function getName(id:int):String
		{
			var product:InAppSkuDetails = getProduct(id);
			if (product)
			{
				return product._title;
			}
			return null;
		}
		
		public function getProduct(id:int):InAppSkuDetails
		{
			var name:String = getPurchaseSku(id);
			return _products[name] as InAppSkuDetails;
		}
		
		public function restore():void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][restore]");
				
				_lastOrderedList.length = 0;
				restorePurchases();
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][restore]", e);
			}
		}
		
		public function adjustPurchase(orderId:String, purchaseStatus:int):void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][adjustPurchase], orderId:" + orderId + ", purchaseStatus:" + purchaseStatus);
				
				if (purchaseStatus == PurchaseStatus.SUCCESS || purchaseStatus == PurchaseStatus.PROCESSED)
				{
					var current:InAppPurchaseDetails;
					var index:int = 0;
					var len:int = _lastOrderedList.length;
					var productId:int;
					var buyItem:GemRecord
					var found:Boolean;
					for (var i:int = 0; i < len; i++)
					{
						current = _lastOrderedList[i];
						if (current)
						{
							if (orderId == current._orderId)
							{
								try
								{
									_iap.addEventListener(InAppPurchaseEvent.CONSUME_SUCCESS, consumePurchase_successHandler);
									_iap.addEventListener(InAppPurchaseEvent.CONSUME_ERROR, consumePurchase_failedHandler);
									_iap.consume(current._sku);
								}
								catch (error:Error)
								{
									_logger.error("[game.managers.purchase.android.AndroidPurchase][adjustPurchase] _iap.consume(current._sku);", error);
									continue;
								}
								
								_lastOrderedList[i] = null;
								if (found)
								{
									_logger.error("[game.managers.purchase.android.AndroidPurchase][adjustPurchase] already exist orderId:" + orderId);
								}
								else
								{
									_tracker.getNotTrackedPurchases();
								}
								
								found = true;
							}
							else
							{
								if (index != i)
								{
									_lastOrderedList[index] = current;
									_lastOrderedList[i] = null;
								}
								index++;
							}
						}
					}
					if (index != i)
					{
						len = _lastOrderedList.length;
						while (i < len)
						{
							_lastOrderedList[index++] = _lastOrderedList[i++];
						}
						
						_lastOrderedList.length = index;
					}
				}
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][adjustPurchase]", e);
			}
		}
		
		private function consumePurchase_successHandler(event:InAppPurchaseEvent):void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][consumePurchase_successHandler]" + event.data);
				
				_iap.removeEventListener(InAppPurchaseEvent.CONSUME_SUCCESS, consumePurchase_successHandler);
				_iap.removeEventListener(InAppPurchaseEvent.CONSUME_ERROR, consumePurchase_failedHandler);
				
				restorePurchases();
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][consumePurchase_successHandler] " + event.data, e);
			}
		}
		
		private function consumePurchase_failedHandler(event:InAppPurchaseEvent):void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][consumePurchase_failedHandler]" + event.data);
				
				_iap.removeEventListener(InAppPurchaseEvent.CONSUME_SUCCESS, consumePurchase_successHandler);
				_iap.removeEventListener(InAppPurchaseEvent.CONSUME_ERROR, consumePurchase_failedHandler);
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][consumePurchase_failedHandler] " + event.data, e);
			}
		}
		
		private function products_loadedHandler(event:InAppPurchaseEvent):void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][products_loadedHandler]" + event.data);
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][products_loadedHandler] " + event.data, e);
			}
		}
		
		private function products_failedHandler(event:InAppPurchaseEvent):void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][products_failedHandler]" + event.data);
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][products_failedHandler] " + event.data, e);
			}
		}
		
		private function setup_successHandler(event:InAppPurchaseEvent):void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][setup_successHandler]" + event.data);
				
				_iap.removeEventListener(InAppPurchaseEvent.INIT_SUCCESS, setup_successHandler);
				_iap.removeEventListener(InAppPurchaseEvent.INIT_ERROR, setup_failureHandler);
				
				restorePurchases();
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][setup_successHandler] " + event.data, e);
			}
		}
		
		private function setup_failureHandler(event:InAppPurchaseEvent):void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][setup_failureHandler]" + event.data);
				
				_iap.removeEventListener(InAppPurchaseEvent.INIT_SUCCESS, setup_successHandler);
				_iap.removeEventListener(InAppPurchaseEvent.INIT_ERROR, setup_failureHandler);
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][setup_failureHandler] " + event.data, e);
			}
		}
		
		private function purchase_successHandler(event:InAppPurchaseEvent):void
		{
			try
			{
				_iap.removeEventListener(InAppPurchaseEvent.PURCHASE_SUCCESS, purchase_successHandler);
				_iap.removeEventListener(InAppPurchaseEvent.PURCHASE_ALREADY_OWNED, purchase_successHandler);
				_iap.removeEventListener(InAppPurchaseEvent.PURCHASE_ERROR, purchase_failedHandler);
				
				_logger.note("[game.managers.purchase.android.AndroidPurchase][purchase_successHandler]" + event.data);
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][purchase_successHandler] " + event.data, e);
			}
		}
		
		private function purchase_failedHandler(event:InAppPurchaseEvent):void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][purchase_failedHandler] " + event.data);
				
				_iap.removeEventListener(InAppPurchaseEvent.PURCHASE_SUCCESS, purchase_successHandler);
				_iap.removeEventListener(InAppPurchaseEvent.PURCHASE_ALREADY_OWNED, purchase_successHandler);
				_iap.removeEventListener(InAppPurchaseEvent.PURCHASE_ERROR, purchase_failedHandler);
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][purchase_failedHandler] " + event.data, e);
			}
		}
		
		/**
		 * use for restore products
		 * @param productLoadListener
		 * @param productFailedListener
		 */
		private function restorePurchases():void
		{
			_logger.note("[game.managers.purchase.android.AndroidPurchase][restorePurchases]")
			
			if (_itemsQueue && _itemsQueue.length != 0)
			{
				return;
			}
			
			_restored = false;
			_failed = false;
			
			_iap.addEventListener(InAppPurchaseEvent.RESTORE_SUCCESS, productQueueLoadHandler);
			_iap.addEventListener(InAppPurchaseEvent.RESTORE_ERROR, productQueueFailedHandler);
			
			_itemsQueue = _itemsArray.slice();
			
			if (_itemsArray.length <= MAX_ITEM)
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][restorePurchases] items:" + _itemsArray);
				_iap.restore(_itemsArray);
			}
			else
			{
				var items:Array = _itemsQueue.slice(0, Math.min(_itemsQueue.length, MAX_ITEM));
				
				_logger.note("[game.managers.purchase.android.AndroidPurchase][restorePurchases] items:" + items);
				
				_iap.restore(items);
			}
		}
		
		private function setSkuDetails(items:Array):void
		{
			try
			{
				_logger.note("[game.managers.purchase.android.AndroidPurchase][setSkuDetails]");
				
				var current:String;
				var len:int = items.length;
				for (var i:int = 0; i < len; i++)
				{
					current = items[i];
					_products[current] = _iap.getSkuDetails(current);
					var product:InAppPurchaseDetails = _iap.getPurchaseDetails(current);
					_logger.note(StringUtil.format("[game.managers.purchase.android.AndroidPurchase][setSkuDetails] items:{0} product:{1}", current, ObjectUtils.toString(product)));
					if (product && product._signature && product._json)
					{
						_lastOrderedList[_lastOrderedList.length] = product;
						_request.androidPurchase(product._json, product._signature);
					}
				}
			}
			catch (e:Error)
			{
				_logger.error("[game.managers.purchase.android.AndroidPurchase][setSkuDetails]", e);
			}
		}
		
		private function productQueueLoadHandler(event:InAppPurchaseEvent):void
		{
			_logger.note("[game.managers.purchase.android.AndroidPurchase][productQueueLoadHandler]" + event.data);
			
			var itemsLoaded:Array = _itemsQueue.slice(0, Math.min(_itemsQueue.length, MAX_ITEM));
			setSkuDetails(itemsLoaded);
			
			_itemsQueue.splice(0, Math.min(_itemsQueue.length, MAX_ITEM));
			
			if (_itemsQueue.length == 0)
			{
				_iap.removeEventListener(InAppPurchaseEvent.RESTORE_SUCCESS, productQueueLoadHandler);
				_iap.removeEventListener(InAppPurchaseEvent.RESTORE_ERROR, productQueueFailedHandler);
				
				_restored = true;
				
				_logger.note("[game.managers.purchase.android.AndroidPurchase][productQueueLoadHandler] restored");
				
				dispatchEventAs(PurchaseEvent, PurchaseEvent.RESTORED);
			}
			else
			{
				var items:Array = _itemsQueue.slice(0, Math.min(_itemsQueue.length, MAX_ITEM));
				
				_logger.note("[game.managers.purchase.android.AndroidPurchase][productQueueLoadHandler] restore:" + items);
				
				_iap.restore(items);
			}
		}
		
		private function productQueueFailedHandler(event:InAppPurchaseEvent):void
		{
			_logger.note("[game.managers.purchase.android.AndroidPurchase][productQueueFailedHandler]" + event.data);
			
			_iap.removeEventListener(InAppPurchaseEvent.RESTORE_SUCCESS, productQueueLoadHandler);
			_iap.removeEventListener(InAppPurchaseEvent.RESTORE_ERROR, productQueueFailedHandler);
			
			_itemsQueue.length = 0;
			
			_failed = true;
			
			dispatchEventAs(PurchaseEvent, PurchaseEvent.FAILED);
		}
		
		public function get restored():Boolean 
		{
			return _restored;
		}
		
		public function get failed():Boolean 
		{
			return _failed;
		}
	
	}

}