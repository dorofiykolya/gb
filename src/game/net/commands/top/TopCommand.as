package game.net.commands.top
{
	import game.managers.top.Top;
	import game.managers.top.TopManager;
	import game.modules.net.NetCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TopCommand extends NetCommand
	{
		[Inject]
		public var topManager:TopManager;
		
		public function TopCommand(... flags)
		{
			super(Top, flags);
		}
		
		override public function execute(data:Object = null):void
		{
			var top:Top = Top(data);
			topManager.update(top);
		}
	
	}
}