package game.managers.battles.output
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitCreateEvent extends OutputEvent
	{
		public var objectId:int;
		public var unitId:int;
		public var level:int;
		public var ownerId:int;
		public var x:Number;
		public var y:Number;
		public var units:int;
		
		public function UnitCreateEvent()
		{
		
		}
	
	}

}