package game.managers.battles.actors
{
	import game.managers.battles.engine.BattleObject;
	import game.managers.battles.records.BattleBuildingRecord;
	import game.records.buildings.BuildingType;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleBuilding extends BattleObject
	{
		private var _units:int;
		
		public function BattleBuilding()
		{
			super();
		}
		
		public function get ownerId():int
		{
			return 0;
		}
		
		public function get units():int
		{
			return _units;
		}
		
		public function initialize(record:BattleBuildingRecord):void
		{
		
		}
	
	}

}