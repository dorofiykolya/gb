package game.managers.battles.output
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitMoveEvent extends OutputEvent
	{
		public var objectId:int;
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function UnitMoveEvent()
		{
		
		}
	
	}

}