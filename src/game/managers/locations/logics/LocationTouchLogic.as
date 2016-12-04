package game.managers.locations.logics
{
	import common.composite.Component;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
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
		public var buildingsLocagic:LocationBuildingLogic;
		[Inject]
		public var stage:Stage;
		[Inject]
		public var layerProvider:LocationLayerProvider;
		
		private var _temp:Vector.<Component>;
		
		public function LocationTouchLogic()
		{
			_temp = new Vector.<Component>();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.HOVER);
			if (touch)
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