package game.managers.battles.output 
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingChangeUnitEvent extends OutputEvent 
	{
		public var objectId:int;
		public var units:int;
		
		public function BuildingChangeUnitEvent() 
		{
			
		}
		
	}

}