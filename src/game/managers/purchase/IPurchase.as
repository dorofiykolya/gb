package game.managers.purchase
{
	import common.events.IEventListener;
	
	[Event(name = "restored", type = "game.managers.purchase.PurchaseEvent")]
	[Event(name = "failed", type = "game.managers.purchase.PurchaseEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IPurchase extends IEventListener
	{
		function purchase(id:int):void;
		function getPrice(id:int):String;
		function getName(id:int):String;
		function adjustPurchase(orderId:String, purchaseStatus:int):void;
		function get restored():Boolean;
		function get failed():Boolean;
	}

}