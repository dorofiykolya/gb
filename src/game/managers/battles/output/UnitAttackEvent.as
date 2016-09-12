package game.managers.battles.output 
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitAttackEvent extends OutputEvent 
	{
		public var from:int;
		public var to:int;
		public var count:int;
		public var unitLevel:int;
		public var unitId:int;
		
		public function UnitAttackEvent() 
		{
			super();
		}
		
	}

}