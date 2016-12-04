package
{
	import game.GBContext;
	import flash.events.Event;
	import game.GameApplication;
	import game.managers.battles.engine.OutputEvent;
	import test.TestBattleView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Main extends GameApplication
	{
		
		private var _context:GBContext;
		//private var _battle:Battle = new Battle();
		//private var _testBattle:TestBattleView = new TestBattleView();
		//private var _tick:int;
		
		public function Main()
		{
			_context = new GBContext(this);
			//addChild(_testBattle);
			//addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		//private function onFrame(e:Event):void
		//{
			//_tick++;
			////if (_tick % 2 == 0)
			//{
				//_battle.nextTick();
				//while (!_battle.out.isEmpty)
				//{
					//var evt:OutputEvent = _battle.out.dequeue();
					//trace(evt.toString());
					//_testBattle.command.execute(_testBattle, evt);
					//_battle.out.factory.release(evt);
				//}
			//}
		//}
	
	}

}