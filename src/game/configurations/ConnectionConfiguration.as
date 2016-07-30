package game.configurations
{
	import common.context.IContext;
	import common.events.IDispatcher;
	import game.Configuration;
	import game.modules.logs.ILogger;
	import game.modules.net.ISocketConnection;
	import game.modules.net.events.NetEvent;
	import game.modules.net.events.NetIOErrorEvent;
	import game.modules.net.events.NetSecurityErrorEvent;
	import game.modules.windows.WindowsManager;
	import game.mvc.events.ViewContextEvent;
	import game.net.ServerRequest;
	import game.view.GameViewContext;
	import game.view.GameWindowId;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ConnectionConfiguration implements IConfigurable
	{
		[Inject]
		public var configuration:Configuration;
		[Inject]
		public var connection:ISocketConnection;
		[Inject]
		public var request:ServerRequest;
		[Inject]
		public var windowsManager:WindowsManager;
		[Inject]
		public var dispatcher:IDispatcher;
		[Inject]
		public var logger:ILogger;
		[Inject]
		public var viewContext:GameViewContext;
		
		public function ConnectionConfiguration()
		{
		
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void
		{
			CONFIG::PRODUCTION
			{
				configuration.host = configuration.productionHost;
				configuration.port = configuration.productionPort;
			}
			
			connection.addEventListener(NetEvent.CLOSE, onClosed);
			connection.addEventListener(NetIOErrorEvent.IO_ERROR, onIOError);
			connection.addEventListener(NetSecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onSecurityError(e:NetSecurityErrorEvent):void 
		{
			if (viewContext.initialized)
			{
				windowsManager.open(GameWindowId.CONNECTION_LOST);
			}
			else
			{
				viewContext.addEventListener(ViewContextEvent.INITIALIZED, function(e:Object = null):void
				{
					windowsManager.open(GameWindowId.CONNECTION_LOST);
				});
			}
			dispatcher.dispatchEventAs(NetEvent, NetEvent.CLOSE);
		}
		
		private function onIOError(e:NetIOErrorEvent):void 
		{
			if (viewContext.initialized)
			{
				windowsManager.open(GameWindowId.CONNECTION_LOST);
			}
			else
			{
				viewContext.addEventListener(ViewContextEvent.INITIALIZED, function(e:Object = null):void
				{
					windowsManager.open(GameWindowId.CONNECTION_LOST);
				});
			}
			dispatcher.dispatchEventAs(NetEvent, NetEvent.CLOSE);
		}
		
		private function onClosed(e:NetEvent):void 
		{
			if (viewContext.initialized)
			{
				windowsManager.open(GameWindowId.CONNECTION_LOST);
			}
			else
			{
				viewContext.addEventListener(ViewContextEvent.INITIALIZED, function(e:Object = null):void
				{
					windowsManager.open(GameWindowId.CONNECTION_LOST);
				});
			}
			
			dispatcher.dispatchEventAs(NetEvent, NetEvent.CLOSE);
		}
	}
}