package test.commands
{
	import game.managers.battles.engine.OutputEvent;
	import test.TestCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DamageApplyCommand extends TestCommand
	{
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public var targetId:int;
		public var hp:int;
		public var damageId:int;
		public var ownerId:int;
		
		public function DamageApplyCommand()
		{
			super(DamageApplyCommand);
		}
	
	}

}