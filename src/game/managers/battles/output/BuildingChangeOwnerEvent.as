package game.managers.battles.output
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingChangeOwnerEvent extends OutputEvent
	{
		public var objectId:int;
		public var ownerId:int;
		public var units:int;
		
		public function BuildingChangeOwnerEvent()
		{
			super();
		
		}
	
	}

}