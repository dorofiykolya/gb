package game
{
	import common.context.IContext;
	import flash.display.Stage;
	import game.mvc.ContextConfiguration;
	import game.mvc.GameContext;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GBContext extends GameContext
	{
		
		public function GBContext(stage:Stage)
		{
			super(stage, Root, getConfiguration());
		}
		
		private function getConfiguration():ContextConfiguration
		{
			var result:ContextConfiguration = new ContextConfiguration();
			return result;
		}
	}

}