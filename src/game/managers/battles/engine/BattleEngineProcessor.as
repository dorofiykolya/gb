package game.managers.battles.engine
{
	import common.system.ClassType;
	import flash.utils.Dictionary;
	import game.managers.battles.engine.BattleAction;
	import game.managers.battles.engine.BattleCommandsProvider;
	import game.managers.battles.engine.BattleConfiguration;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleEngineCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleEngineProcessor
	{
		private var _configuration:BattleConfiguration;
		private var _commandMap:Dictionary;
		
		public function BattleEngineProcessor(configuration:BattleConfiguration, commandsProvider:BattleCommandsProvider)
		{
			_configuration = configuration;
			_commandMap = new Dictionary();
			
			for each (var item:BattleEngineCommand in commandsProvider.commands)
			{
				map(item.actionType, item);
			}
		}
		
		public function map(type:Class, command:BattleEngineCommand):void
		{
			_commandMap[type] = command;
		}
		
		public function execute(action:BattleAction, context:BattleContext):void
		{
			var type:Class = ClassType.getAsClass(action);
			var command:BattleEngineCommand = _commandMap[type];
			if (command)
			{
				command.execute(action, context);
			}
		}
	
	}

}