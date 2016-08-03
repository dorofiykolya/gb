package game.net.commands.purchase
{
	import game.managers.purchase.IPurchase;
	import game.modules.net.NetCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PurchasesProcessedCommand extends NetCommand
	{
		[Inject]
		public var purchase:IPurchase;
		
		public function PurchasesProcessedCommand(... flags)
		{
			super(PurchasesProcessed, flags);
		}
		
		override public function execute(data:Object = null):void
		{
			var purchasesProcessed:PurchasesProcessed = PurchasesProcessed(data);
			if (purchase)
			{
				for each (var item:Purchase in purchasesProcessed.purchases)
				{
					purchase.adjustPurchase(item.orderId, item.purchaseStatus);
				}
			}
		}
	
	}

}