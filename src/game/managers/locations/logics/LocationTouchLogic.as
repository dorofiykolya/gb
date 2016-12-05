package game.managers.locations.logics
{
	import common.composite.Component;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import game.managers.battles.actions.BattleUnitAttackAction;
	import game.managers.locations.LocationLayerName;
	import game.managers.locations.LocationLayerProvider;
	import game.managers.locations.mediators.LocationBuilding;
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationTouchLogic extends LocationLogic
	{
		private static const TEMP_POINT:Point = new Point();
		
		[Inject]
		public var battleLogic:LocationBattleLogic;
		[Inject]
		public var buildingsLocagic:LocationBuildingLogic;
		[Inject]
		public var stage:Stage;
		[Inject]
		public var layerProvider:LocationLayerProvider;
		
		private var _temp:Vector.<Component>;
		
		private var _fromBuildings:Vector.<LocationBuilding>;
		
		public function LocationTouchLogic()
		{
			_temp = new Vector.<Component>();
			_fromBuildings = new Vector.<LocationBuilding>();
		}
		
		override public function initialize():void
		{
			super.initialize();
			clearOver();
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touchBegan:Touch = e.getTouch(stage, TouchPhase.BEGAN);
			if (touchBegan)
			{
				touchBegan.getLocation(layerProvider.getLayer(LocationLayerName.OBJECTS), TEMP_POINT);
				_temp.length = 0;
				buildingsLocagic.getComponents(LocationBuilding, true, _temp);
				for each (var building:LocationBuilding in _temp)
				{
					if (building.hitTest(TEMP_POINT.x, TEMP_POINT.y))
					{
						_fromBuildings.push(building);
						break;
					}
				}
			}
			var touchMove:Touch = e.getTouch(stage, TouchPhase.MOVED);
			if (touchMove && _fromBuildings.length != 0)
			{
				touchMove.getLocation(layerProvider.getLayer(LocationLayerName.OBJECTS), TEMP_POINT);
				_temp.length = 0;
				buildingsLocagic.getComponents(LocationBuilding, true, _temp);
				for each (var building:LocationBuilding in _temp)
				{
					if (building.hitTest(TEMP_POINT.x, TEMP_POINT.y))
					{
						if (_fromBuildings.indexOf(building) == -1 && _fromBuildings[0].ownerId == building.ownerId)
						{
							_fromBuildings.push(building);
						}
						break;
					}
				}
			}
			var touchEnd:Touch = e.getTouch(stage, TouchPhase.ENDED);
			if (touchEnd)
			{
				touchEnd.getLocation(layerProvider.getLayer(LocationLayerName.OBJECTS), TEMP_POINT);
				_temp.length = 0;
				buildingsLocagic.getComponents(LocationBuilding, true, _temp);
				var target:LocationBuilding;
				for each (var building:LocationBuilding in _temp)
				{
					if (building.hitTest(TEMP_POINT.x, TEMP_POINT.y))
					{
						target = building;
						break;
					}
				}
				if (target)
				{
					for each (var building:LocationBuilding in _fromBuildings)
					{
						if (target != building)
						{
							var action:BattleUnitAttackAction = new BattleUnitAttackAction();
							action.fromObjectId = building.objectId;
							action.toObjectId = target.objectId;
							action.tick = battleLogic.engine.tick + 1;
							battleLogic.engine.actions.enqueue(action);
						}
					}
				}
				clearOver();
			}
			
			setOver();
			
			
			onTouchHover(e);
		}
		
		private function setOver():void
		{
			for each (var building:LocationBuilding in _fromBuildings) 
			{
				building.setHover(true);
			}
		}
		
		private function clearOver():void
		{
			for each (var building:LocationBuilding in _fromBuildings) 
			{
				building.setHover(false);
			}
			_fromBuildings.length = 0;
		}
		
		private function onTouchHover(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.HOVER);
			if (touch && _fromBuildings.length == 0)
			{
				touch.getLocation(layerProvider.getLayer(LocationLayerName.OBJECTS), TEMP_POINT);
				_temp.length = 0;
				buildingsLocagic.getComponents(LocationBuilding, true, _temp);
				var hasHover:Boolean = false;
				for each (var building:LocationBuilding in _temp)
				{
					var hover:Boolean = building.hitTest(TEMP_POINT.x, TEMP_POINT.y);
					building.setHover(hover);
					if (hover)
					{
						hasHover = true;
					}
				}
				Mouse.cursor = hasHover ? MouseCursor.BUTTON : MouseCursor.AUTO;
			}
		}
	
	}

}