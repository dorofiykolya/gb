package game.managers.purchase
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PurchaseEvent extends Event
	{
		public static const RESTORED:String = "restored";
		public static const FAILED:String = "failed";
		
		public function PurchaseEvent(type:Object, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	
	}

}