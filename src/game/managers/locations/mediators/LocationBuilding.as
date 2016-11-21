package game.managers.locations.mediators 
{
	import game.managers.battles.output.BuildingCreateEvent;
	import game.managers.locations.components.LocationBuildingAnimationComponent;
	import game.managers.locations.components.LocationBuildingSelectionComponent;
	import game.managers.locations.components.LocationUnitCountComponent;
	import game.managers.locations.logics.LocationBattlePlayerLogic;
	import game.records.PlayerColor;
	import game.records.Race;
	import game.records.buildings.BuildingLevelRecord;
	import game.records.buildings.BuildingRecord;
	import game.records.buildings.BuildingsRecordMap;
	import game.utils.Math2;
	import game.utils.Point3;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBuilding extends LocationObject 
	{
		[Inject]
		public var buildingRecordMap:BuildingsRecordMap;
		[Inject]
		public var playerLogic:LocationBattlePlayerLogic;
		
		private var _race:int;
		private var _playerIndex:int;
		
		public function LocationBuilding() 
		{
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			addComponent(LocationBuildingAnimationComponent);
			addComponent(LocationUnitCountComponent);
		}
		
		public function setContent(data:BuildingCreateEvent):void
		{
			setPosition(Point3.week(data.x, data.y));
			
			_race = playerLogic.getRace(data.ownerId);
			_playerIndex = playerLogic.getIndex(data.ownerId);
			var building:BuildingRecord = buildingRecordMap.getByBuildingId(data.buildingId, _race);
			var buildingLevel :BuildingLevelRecord = building.levels[data.level];
			
			animation.setup(Race.getRaceName(_race) + "_" + PlayerColor.getColorName(_playerIndex) + "_" + buildingLevel.view);
			
			setUnits(data.units);
		}
		
		public function setUnits(units:int):void 
		{
			LocationUnitCountComponent(getComponent(LocationUnitCountComponent)).setUnits(units, PlayerColor.getColor(_playerIndex));
		}
		
		public function hitTest(x:Number, y:Number):Boolean
		{
			return Math2.distance(x, y, this.x, this.y) <= 50.0;
		}
		
		public function setHover(value:Boolean):void 
		{
			animation.setHover(value);
			if (value && getComponent(LocationBuildingSelectionComponent) == null)
			{
				LocationBuildingSelectionComponent(addComponent(LocationBuildingSelectionComponent)).setColor(PlayerColor.getColor(_playerIndex));
			}
			else if(!value)
			{
				removeComponents(LocationBuildingSelectionComponent);
			}
		}
		
		public function get animation():LocationBuildingAnimationComponent
		{
			return getComponent(LocationBuildingAnimationComponent) as LocationBuildingAnimationComponent;
		}
		
	}

}