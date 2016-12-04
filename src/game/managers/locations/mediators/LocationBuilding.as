package game.managers.locations.mediators
{
	import common.composite.Component;
	import common.composite.VectorComponentPool;
	import game.managers.battles.output.BuildingCreateEvent;
	import game.managers.locations.components.ILocationChangeOwner;
	import game.managers.locations.components.LocationBuildingAnimationComponent;
	import game.managers.locations.components.LocationBuildingSelectionComponent;
	import game.managers.locations.components.LocationUnitCountComponent;
	import game.managers.locations.events.LocationObjectEvent;
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
		private var _buildingLevel:BuildingLevelRecord;
		private var _buildingId:int;
		private var _level:int;
		
		public function LocationBuilding()
		{
		
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			initializeComponents();
		}
		
		private function initializeComponents():void
		{
			addEventListener(LocationObjectEvent.OWNER, onOwnerChange);
			addComponent(LocationBuildingAnimationComponent);
			addComponent(LocationUnitCountComponent);
		}
		
		private function initializeData():void
		{
			_race = playerLogic.getRace(ownerId);
			_playerIndex = playerLogic.getIndex(ownerId);
			var building:BuildingRecord = buildingRecordMap.getByBuildingId(_buildingId, _race);
			_buildingLevel = building.levels[_level];
			
			setupAnimation();
		}
		
		private function onOwnerChange(e:LocationObjectEvent):void
		{
			initializeData();
		}
		
		public function setContent(data:BuildingCreateEvent):void
		{
			setPosition(Point3.week(data.x, data.y));
			_buildingId = data.buildingId;
			setOwnerId(data.ownerId);
			setUnits(data.units);
		}
		
		public function setupAnimation():void
		{
			animation.setup(Race.getRaceName(_race) + "_" + PlayerColor.getColorName(_playerIndex) + "_" + _buildingLevel.view);
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
			else if (!value)
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