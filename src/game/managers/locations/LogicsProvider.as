package game.managers.locations
{
	import game.managers.locations.logics.LocationBackgroundLogic;
	import game.managers.locations.logics.LocationBattleLogic;
	import game.managers.locations.logics.LocationBattlePlayerLogic;
	import game.managers.locations.logics.LocationBuildingLogic;
	import game.managers.locations.logics.LocationBulletLogic;
	import game.managers.locations.logics.LocationCommandLogics;
	import game.managers.locations.logics.LocationConverterLogic;
	import game.managers.locations.logics.LocationObjectsLogic;
	import game.managers.locations.logics.LocationSortObjectsLogic;
	import game.managers.locations.logics.LocationTextureLayerFactoryLogic;
	import game.managers.locations.logics.LocationTimeLogic;
	import game.managers.locations.logics.LocationTouchLogic;
	import game.managers.locations.logics.LocationUnitLogic;
	
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
			add(LocationBuildingLogic);
			add(LocationUnitLogic);
			add(LocationObjectsLogic);
			add(LocationConverterLogic);
			add(LocationTextureLayerFactoryLogic);
			add(LocationBulletLogic);
			add(LocationBattlePlayerLogic);
			add(LocationSortObjectsLogic);
			add(LocationTouchLogic);
			add(LocationBackgroundLogic);
		}
	
	}

}