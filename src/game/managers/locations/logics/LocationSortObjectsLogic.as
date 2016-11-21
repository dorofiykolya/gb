package game.managers.locations.logics
{
	import flash.utils.getTimer;
	import game.managers.locations.IJuggler;
	import game.managers.locations.LocationLayerName;
	import game.managers.locations.LocationLayerProvider;
	import starling.animation.IAnimatable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationSortObjectsLogic extends LocationLogic implements IAnimatable
	{
		[Inject]
		public var layer:LocationLayerProvider;
		[Inject]
		public var juggler:IJuggler;
		
		private var _startTime:int;
		
		public function LocationSortObjectsLogic()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			juggler.add(this);
			
			_startTime = getTimer();
		}
		
		override protected function onDispose():void
		{
			juggler.remove(this);
			super.onDispose();
		}
		
		public function advanceTime(time:Number):void
		{
			var now:int = getTimer();
			var diff:int = now - _startTime;
			if (diff >= 1000 / 10)
			{
				_startTime = now;
				layer.getLayer(LocationLayerName.OBJECTS).sortChildren(sortChildren);
			}
		}
		
		private function sortChildren(left:Object, right:Object):int
		{
			if (left.y > right.y) return 1;
			if (left.y < right.y) return -1;
			return 0;
		}
	
	}

}