package game.managers.battles.engine
{
	import common.system.utils.ObjectUtils;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class OutputEvent
	{
		public var tick:int;
		
		public function OutputEvent()
		{
		
		}
		
		public function toString():String
		{
			return ObjectUtils.toString(this);
		}
	
	}

}