package game.net.commands.initialization
{
	import game.modules.net.NetCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class InitializationCommand extends NetCommand
	{
		
		public function InitializationCommand(... flags)
		{
			super(Initialization, flags);
		}
	
	}

}