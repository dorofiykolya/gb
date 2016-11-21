package game.commands
{
	import common.events.IDispatcher;
	import game.managers.locations.LocationData;
	import game.managers.locations.LocationManager;
	import game.mvc.view.ViewContext;
	import game.modules.preloaders.PreloaderManager;
	import game.modules.resources.ResourceManager;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AssetLoadCommand implements ICommand
	{
		[Inject]
		public var context:ViewContext;
		[Inject]
		public var preloader:PreloaderManager;
		[Inject]
		public var resourceManager:ResourceManager;
		[Inject]
		public var eventDispatcher:IDispatcher;
		
		public function AssetLoadCommand()
		{
		
		}
		
		/* INTERFACE com.okapp.mvc.commands.ICommand */
		
		public function execute():void
		{
			//----------------------------------
			//	initialize ViewContext
			//----------------------------------
			
			context.initialize();
			preloader.close();
			
			eventDispatcher.dispatchEventWith("START_BATTLE");
		}
	}
}