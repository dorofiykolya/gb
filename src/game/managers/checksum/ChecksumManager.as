package game.managers.checksum
{
	import common.system.utils.ObjectUtils;
	import game.managers.purchase.PurchasesTrackedManager;
	import game.managers.users.UserManager;
	import game.modules.storage.StorageManager;
	import game.net.ServerRequest;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ChecksumManager
	{
		private static const STORAGE_KEY:String = "checksums";
		
		[Inject]
		public var storage:StorageManager;
		[Inject]
		public var request:ServerRequest;
		[Inject]
		public var userInfo:UserManager;
		[Inject]
		public var purchaseTracker:PurchasesTrackedManager;
		
		private var _checksum:CheckSums;
		
		public function ChecksumManager()
		{
		
		}
		
		public function update(sum:CheckSums):void
		{
			check(sum);
			_checksum = sum;
			save();
			request.localizationInfo();
			request.baseInfo();
			userInfo.initializeUser();
			purchaseTracker.getNotTrackedPurchases();
		}
		
		public function load():void
		{
			var data:Object = storage.map(STORAGE_KEY).value;
			if (data != null)
			{
				_checksum = CheckSums(ObjectUtils.toType(data, CheckSums));
			}
		}
		
		private function check(sum:CheckSums):void
		{
			
		}
		
		private function save():void
		{
			var data:Object = ObjectUtils.toObject(_checksum);
			storage.map(STORAGE_KEY).value = data;
		}
	
	}

}