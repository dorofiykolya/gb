package game.commands
{
	import common.events.IDispatcher;
	import game.managers.debug.DebugManager;
	import game.modules.net.ISocketConnection;
	import game.modules.preloaders.PreloaderManager;
	import game.modules.resources.ResourceManager;
	import game.mvc.events.ViewContextEvent;
	import game.mvc.view.ViewContext;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ResourceLoadCommand implements ICommand
	{
		[Inject]
		public var context:ViewContext;
		[Inject]
		public var preloader:PreloaderManager;
		[Inject]
		public var resourceManager:ResourceManager;
		[Inject]
		public var debugManager:DebugManager;
		[Inject]
		public var connection:ISocketConnection;
		[Inject]
		public var dispatcher:IDispatcher;
		
		public function ResourceLoadCommand()
		{
		
		}
		
		/* INTERFACE com.okapp.mvc.commands.ICommand */
		
		public function execute():void
		{
			//----------------------------------
			//	initialize ViewContext
			//----------------------------------
			
			context.initialize();
			dispatcher.dispatchEventAs(ViewContextEvent, ViewContextEvent.INITIALIZED);
			
			if (debugManager.needOpenDebugWindow || connection.connected || resourceManager.isComplete)
			{
				preloader.close();
			}
		}
	
	}

}