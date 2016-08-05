package game
{
	import game.modules.states.State;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GameState extends State
	{
		public static const INITIALIZATION:GameState = new GameState("initialization");
		
		public function GameState(name:String, parent:State = null)
		{
			super(name, parent);
		}
	
	}

}