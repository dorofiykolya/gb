package game.managers.battles.output
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DamageApplyEvent extends OutputEvent
	{
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public var targetId:int;
		public var units:int;
		public var damageId:int;
		
		public function DamageApplyEvent()
		{
		
		}
	
	}

}