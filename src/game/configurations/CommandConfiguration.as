package game.configurations
{
	import common.context.IContext;
	import common.events.IDispatcher;
	import game.commands.AuthSuccessCommand;
	import game.commands.ConnectToServerCommand;
	import game.commands.ConnectionCloseCommand;
	import game.commands.FightStartCommand;
	import game.commands.InitializeCommand;
	import game.commands.LocationLoadedCommand;
	import game.commands.ResourceLoadCommand;
	import game.commands.ResourceStartLoadCommand;
	import game.commands.ScreenChangeCommand;
	import game.mvc.events.ViewContextEvent;
	//import game.locations.events.LocationEvent;
	//import game.locations.events.LocationModelEvent;
	import game.managers.auth.AuthEvent;
	import game.managers.screens.ScreenEvent;
	import game.managers.users.UserEvent;
	import game.modules.assets.AssetEvent;
	import game.modules.net.events.NetEvent;
	import game.modules.resources.ResourceEvent;
	//import game.view.events.ViewContextEvent;
	import mvc.commands.IEventCommandMap;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class CommandConfiguration implements IConfigurable
	{
		[Inject]
		public var dispatcher:IDispatcher;
		[Inject]
		public var command:IEventCommandMap;
		
		public function CommandConfiguration()
		{
		
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void
		{
			//command.map(AssetEvent.LOADED, AssetEvent).add(AssetLoadCommand, true);
			command.map(ResourceEvent.COMPLETE, ResourceEvent).add(ResourceLoadCommand, true);
			
			command.map(AssetEvent.LOADED, AssetEvent).add(ResourceStartLoadCommand, true);
			command.map(AssetEvent.LOADED, AssetEvent).add(ConnectToServerCommand, true);
			
			command.map(AuthEvent.SUCCESS, AuthEvent).add(AuthSuccessCommand);
			
			command.map(UserEvent.INITIALIZE, UserEvent).add(InitializeCommand);
			
			//command.map(LocationEvent.LOADED, LocationEvent).add(FightStartCommand);
			
			command.map(ScreenEvent.CHANGE, ScreenEvent).add(ScreenChangeCommand);
			
			command.map(NetEvent.CLOSE, NetEvent).add(ConnectionCloseCommand);
			
			//command.map(LocationModelEvent.COMPLETE, LocationModelEvent).add(LocationLoadedCommand);
		}
	}
}