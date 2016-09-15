package
{
	//import game.GBContext;
	import flash.events.Event;
	import game.GameApplication;
	import game.managers.battles.Battle;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Main extends GameApplication
	{
		
		//private var _context:GBContext;
		private var _battle:Battle = new Battle();
		
		public function Main()
		{
			//_context = new GBContext(this);
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void 
		{
			_battle.nextTick();
			while (!_battle.out.isEmpty)
			{
				trace(_battle.out.dequeue().toString());
			}
		}
	
	}

}