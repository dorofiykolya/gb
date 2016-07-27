package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import game.GBContext;
	import game.mvc.GameContext;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GameInitialization 
	{
		
		public function GameInitialization(root:GameApplication) 
		{
			if (root.stage)
			{
				createContext(root.stage);
			}
			else
			{
				root.addEventListener(Event.ADDED_TO_STAGE, toStage);
			}
		}
		
		private function toStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, toStage);
			createContext(Sprite(e.currentTarget).stage);
		}
		
		private function createContext(stage:Stage):void
		{
			new GBContext(stage);
		}
		
	}

}