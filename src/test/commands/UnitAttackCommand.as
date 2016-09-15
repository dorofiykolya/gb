package test.commands 
{
	import game.managers.battles.engine.OutputEvent;
	import test.TestCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitAttackCommand extends TestCommand 
	{
		public var from:int;
		public var to:int;
		public var count:int;
		public var unitLevel:int;
		public var unitId:int;
		
		public function UnitAttackCommand() 
		{
			super(UnitAttackCommand);
		}
		
	}

}