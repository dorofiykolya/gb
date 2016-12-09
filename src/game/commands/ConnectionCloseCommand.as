package game.commands
{
	import game.managers.locations.LocationManager;
	import game.managers.screens.ScreenId;
	import game.managers.screens.ScreenManager;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ConnectionCloseCommand implements ICommand
	{
		[Inject]
		public var screenManager:ScreenManager;
		[Inject]
		public var locationModel:LocationManager;
		
		public function ConnectionCloseCommand()
		{
		
		}
		
		/* INTERFACE mvc.commands.ICommand */
		
		public function execute():void
		{
			if (locationModel.loaded)
			{
				locationModel.dispose();
			}
			//screenManager.showScreen(ScreenId.MAIN);
		}
	
	}

}