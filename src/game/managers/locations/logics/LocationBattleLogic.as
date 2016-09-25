package game.managers.locations.logics 
{
	import common.composite.Component;
	import game.managers.battles.engine.BattleEngine;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBattleLogic extends LocationLogic 
	{
		private var _engine:BattleEngine;
		
		public function LocationBattleLogic() 
		{
			
		}
		
		override public function initialize():void 
		{
			_engine = new BattleEngine(location.data.configuration);
			
		}
		
	}

}