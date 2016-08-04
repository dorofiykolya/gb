package game.commands
{
	import game.modules.utils.FpsUtil;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationLoadedCommand implements ICommand
	{
		[Inject]
		public var fpsUtil:FpsUtil;
		
		public function LocationLoadedCommand()
		{
		
		}
		
		/* INTERFACE mvc.commands.ICommand */
		
		public function execute():void
		{
			fpsUtil.start();
		}
	
	}

}