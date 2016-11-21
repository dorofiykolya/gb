package game.managers.locations.logics 
{
	import common.composite.Component;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
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
		[Inject]
		public var buildingsLocagic:LocationBuildingLogic;
		[Inject]
		public var stage:Stage;
		
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
				_temp.length = 0;
				buildingsLocagic.getComponents(LocationBuilding, true, _temp);
				var hasHover:Boolean = false;
				for each (var building:LocationBuilding in _temp) 
				{
					var hover:Boolean = building.hitTest(touch.globalX, touch.globalY);
					building.setHover(hover);
					if (hover)
					{
						hasHover = true;
					}
				}
				Mouse.cursor = hasHover? MouseCursor.BUTTON : MouseCursor.AUTO;
			}
		}
		
	}

}