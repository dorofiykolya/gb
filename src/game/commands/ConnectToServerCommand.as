package game.commands
{
	import common.system.Environment;
	import common.system.application.Application;
	import game.configurations.Configuration;
	import game.managers.auth.AuthManager;
	import game.managers.debug.DebugManager;
	import game.modules.net.ISocketConnection;
	import game.modules.net.events.NetEvent;
	import game.modules.preloaders.PreloaderManager;
	import game.modules.resources.ResourceManager;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ConnectToServerCommand implements ICommand
	{
		[Inject]
		public var configuration:Configuration;
		[Inject]
		public var connection:ISocketConnection;
		[Inject]
		public var auth:AuthManager;
		[Inject]
		public var application:Application;
		[Inject]
		public var debugManager:DebugManager;
		[Inject]
		public var preloader:PreloaderManager;
		[Inject]
		public var resourceManager:ResourceManager;
		
		public function ConnectToServerCommand()
		{
		
		}
		
		/* INTERFACE mvc.commands.ICommand */
		
		public function execute():void
		{
			connection.addEventListener(NetEvent.CONNECT, onConnect);
			
			if (debugManager.needOpenDebugWindow)
			{
				debugManager.openStartWindow();
				configuration.isBrowser = false;
				configuration.isDeveloper = true;
			}
			else if (!Environment.isMobile || configuration.isMobileEmulation)
			{
				configuration.isBrowser = Environment.isActiveX || Environment.isPlugIn;
				connectToServer();
			}
			else
			{
				connectToServer();
			}
		}
		
		private function connectToServer():void
		{
			preloader.show();
			if (configuration.isBrowser)
			{
				configuration.host = String(application.parameters.host);
				configuration.port = parseInt(application.parameters.port);
			}
			connection.connect(configuration.host, configuration.port);
		}
		
		private function onConnect(e:NetEvent):void
		{
			if (resourceManager.isComplete)
			{
				preloader.close();
			}
			auth.auth();
		}
	
	}

}