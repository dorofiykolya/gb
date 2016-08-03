package game.net.commands.auth
{
	import game.managers.auth.AuthManager;
	import game.managers.auth.UserAuthInfo;
	import game.modules.net.NetCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UserAuthInfoCommand extends NetCommand
	{
		[Inject]
		public var auth:AuthManager;
		
		public function UserAuthInfoCommand(... flags)
		{
			super(UserAuthInfo, flags);
		}
		
		override public function execute(data:Object = null):void
		{
			var userAuth:UserAuthInfo = UserAuthInfo(data);
			auth.setAuthInfo(userAuth);
		}
	
	}

}