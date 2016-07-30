package game.managers.integration
{
	import flash.external.ExternalInterface;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	
	public class External
	{
		public static function get available():Boolean
		{
			return ExternalInterface.available;
		}
		
		public static function addCallBack(functionName:String, closure:Function):void
		{
			if (available)
			{
				ExternalInterface.addCallback(functionName, closure);
			}
		}
		
		public static function call(functionName:String, ... rest):*
		{
			if (available)
			{
				rest.unshift(functionName);
				return ExternalInterface.call.apply(null, rest);
			}
			return undefined;
		}
	}
}