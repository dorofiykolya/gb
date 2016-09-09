package game.managers.battles.output
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingAttackEvent extends OutputEvent
	{
		public var objectId:int;
		public var targetId:int;
		
		public function BuildingAttackEvent()
		{
		
		}
	
	}

}