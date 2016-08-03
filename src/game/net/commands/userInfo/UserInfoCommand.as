package game.net.commands.userInfo
{
	import common.events.IDispatcher;
	import game.managers.users.UserEvent;
	import game.managers.users.UserInfo;
	import game.managers.users.UserManager;
	import game.modules.net.NetCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UserInfoCommand extends NetCommand
	{
		[Inject]
		public var userManager:UserManager;
		[Inject]
		public var dispatcher:IDispatcher;
		
		public function UserInfoCommand(... flags)
		{
			super(UserInfo, flags);
		}
		
		override public function execute(data:Object = null):void
		{
			var info:UserInfo = UserInfo(data);
			userManager.updateInfo(info);
			
			dispatcher.dispatchEventAs(UserEvent, UserEvent.INITIALIZE);
		}
	
	}

}