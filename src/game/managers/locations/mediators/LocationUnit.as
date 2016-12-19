package game.managers.locations.mediators
{
	import game.managers.battles.output.UnitCreateEvent;
	import game.managers.locations.components.LocationUnitAnimationComponent;
	import game.managers.locations.components.LocationUnitCountComponent;
	import game.managers.locations.logics.LocationBattlePlayerLogic;
	import game.records.PlayerColor;
	import game.records.Race;
	import game.records.units.UnitLevelRecord;
	import game.records.units.UnitRecord;
	import game.records.units.UnitRecordMap;
	import game.utils.Point3;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnit extends LocationObject
	{
		[Inject]
		public var unitRecordMap:UnitRecordMap;
		[Inject]
		public var playerLogic:LocationBattlePlayerLogic;
		
		private var _race:int;
		private var _playerIndex:int;
		
		public function LocationUnit()
		{
		
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			addComponent(LocationUnitAnimationComponent);
			addComponent(LocationUnitCountComponent);
		}
		
		public function setContent(data:UnitCreateEvent):void
		{
			setPosition(Point3.week(data.x, data.y));
			
			_race = playerLogic.getRace(data.ownerId);
			_playerIndex = playerLogic.getIndex(data.ownerId);
			var unit:UnitRecord = unitRecordMap.getBy(data.unitId, _race);
			var unitLevel:UnitLevelRecord = unit.levels[data.level];
			animation.setup(Race.getRaceName(_race) + "_" + unitLevel.view);
			animation.directionTo(data.toObjectId);
			
			setUnits(data.units);
		}
		
		public function setUnits(units:int):void
		{
			LocationUnitCountComponent(getComponent(LocationUnitCountComponent)).setUnits(units, PlayerColor.getColor(_playerIndex));
		}
		
		public function get animation():LocationUnitAnimationComponent
		{
			return getComponent(LocationUnitAnimationComponent) as LocationUnitAnimationComponent;
		}
	
	}

}