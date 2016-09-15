package test.commands
{
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.BuildingAttackEvent;
	import test.TestCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingAttackCommand extends TestCommand
	{
		public var objectId:int;
		public var targetId:int;
		
		public function BuildingAttackCommand()
		{
			super(BuildingAttackEvent);
		}
	
	}

}