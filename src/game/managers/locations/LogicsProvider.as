package game.managers.locations 
{
	import game.managers.locations.logics.LocationBattleLogic;
	import game.managers.locations.logics.LocationCommandLogics;
	import game.managers.locations.logics.LocationTimeLogic;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LogicsProvider extends ComponentProvider
	{
		
		public function LogicsProvider() 
		{
			add(LocationTimeLogic, IJuggler);
			add(LocationBattleLogic);
			add(LocationCommandLogics);
		}
		
	}

}