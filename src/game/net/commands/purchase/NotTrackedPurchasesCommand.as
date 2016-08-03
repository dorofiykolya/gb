package game.net.commands.purchase
{
	import common.system.Environment;
	import game.managers.purchase.PurchasesTrackedManager;
	import game.modules.net.NetCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NotTrackedPurchasesCommand extends NetCommand
	{
		[Inject]
		public var purchaseTracker:PurchasesTrackedManager;
		
		public function NotTrackedPurchasesCommand(... flags)
		{
			super(NotTrackedPurchases, flags);
		}
		
		override public function execute(data:Object = null):void
		{
			if (Environment.isMobile)
			{
				var purchases:NotTrackedPurchases = NotTrackedPurchases(data);
				purchaseTracker.updateNotTrackedPurchases(purchases.purchases);
			}
		}
	
	}

}