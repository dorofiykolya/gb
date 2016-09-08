package game.managers.battles.providers
{
	import game.managers.battles.commands.BattleStartCommand;
	import game.managers.battles.engine.BattleCommandsProvider;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleCommands extends BattleCommandsProvider
	{
		
		public function BattleCommands()
		{
			add(new BattleStartCommand());
		}
	
	}

}