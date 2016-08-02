package game.managers.purchase
{
	import game.managers.auth.AuthManager;
	import game.managers.integration.SocialType;
	import game.net.ServerRequest;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PurchasesTrackedManager
	{
		private var _request:ServerRequest;
		private var _inWait:Boolean;
		private var _hasRequest:Boolean;
		private var _auth:AuthManager;
		
		public function PurchasesTrackedManager(request:ServerRequest, auth:AuthManager)
		{
			_auth = auth;
			_request = request;
		}
		
		public function getNotTrackedPurchases():void
		{
			if (_inWait)
			{
				_hasRequest = true;
			}
			else
			{
				CONFIG::ANDROID
				{
					_request.getNotTrackedPurchases(SocialType.ANDROID);
				}
				CONFIG::IOS
				{
					_request.getNotTrackedPurchases(SocialType.IOS);
				}
				_inWait = true;
			}
		}
		
		public function updateNotTrackedPurchases(list:Vector.<PurchaseProduct>):void
		{
			if (_auth.authorized)
			{
				var result:Vector.<int> = new Vector.<int>();
				for each (var item:PurchaseProduct in list)
				{
					if (item)
					{
						if (result.indexOf(item.objectId) == -1)
						{
							result[result.length] = item.objectId;
						}
					}
				}
				if (result.length > 0)
				{
					_request.purchasesTracked(result);
				}
				_inWait = false;
				if (_hasRequest)
				{
					CONFIG::ANDROID
					{
						_request.getNotTrackedPurchases(SocialType.ANDROID);
					}
					CONFIG::IOS
					{
						_request.getNotTrackedPurchases(SocialType.IOS);
					}
					_hasRequest = false;
				}
			}
		}
	
	}

}