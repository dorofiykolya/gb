package game.commands
{
	import game.modules.preloaders.PreloaderManager;
	import game.modules.resources.ResourceManager;
	import game.view.ViewContext;
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
		}
	}
}