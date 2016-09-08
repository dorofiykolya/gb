package game.managers.battles.output
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitsChangeEvent extends OutputEvent
	{
		public var ownerId:int;
		public var objectId:int;
		public var units:int;
		
		public function UnitsChangeEvent()
		{
		
		}
	
	}

}