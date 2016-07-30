package game.view
{
	import game.modules.windows.WindowId;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GameWindowId extends game.modules.windows.WindowId
	{
		static public const CONNECTION_LOST:GameWindowId = new GameWindowId("connectionLost");
		
		public function GameWindowId(value:Object)
		{
			super(value);
		}
	
	}

}