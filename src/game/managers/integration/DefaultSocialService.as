package game.managers.integration
{
	import game.managers.integration.ISocialService;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DefaultSocialService implements ISocialService
	{
		
		public function DefaultSocialService()
		{
		
		}
		
		/* INTERFACE integration.ISocialService */
		
		public function initilize():void 
		{
			trace("[DefaultSocialService][initilize]");
		}
		
		public function getUserData():void 
		{
			trace("[DefaultSocialService][getUserData]");
		}
		
		public function showPayment(price:int, resourseCount:int, item:String):void
		{
		
		}
		
		public function getCurrencyPrefix(currency:int):String
		{
			return "";
		}
		
		public function get id():int 
		{
			return -1;
		}
		
		public function get prefix():String 
		{
			return "null";
		}
	
	}

}