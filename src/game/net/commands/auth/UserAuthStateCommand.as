package game.net.commands.auth
{
	import game.managers.auth.AuthManager;
	import game.managers.updates.ApplicationUpdateManager;
	import game.modules.alert.AlertManager;
	import game.modules.applications.ApplicationManager;
	import game.modules.net.ISocketConnection;
	import game.modules.net.NetCommand;
	import game.modules.versions.VersionManager;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UserAuthStateCommand extends NetCommand
	{
		[Inject]
		public var auth:AuthManager;
		[Inject]
		public var versionManager:VersionManager;
		[Inject]
		public var alertManager:AlertManager;
		[Inject]
		public var applicationManager:ApplicationUpdateManager;
		[Inject]
		public var connection:ISocketConnection;
		
		public function UserAuthStateCommand(... flags)
		{
			super(UserAuthState, flags);
		}
		
		override public function execute(data:Object = null):void
		{
			var state:UserAuthState = UserAuthState(data);
			auth.setAuthStatus(state.state);
			
			if (!versionManager.verify(state.minVersion))
			{
				connection.close();
				applicationManager.openUpdate();
			}
		}
	
	}

}