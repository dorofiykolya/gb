package game.managers.battles.output 
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitAttachedEvent extends OutputEvent 
	{
		public var buildingObjectId:int;
		public var unitObjectId:int;
		public var buildingUnits:int;
		
		public function UnitAttachedEvent() 
		{
			
		}
		
	}

}