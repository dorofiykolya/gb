package game.managers.locations.logics
{
	import game.managers.locations.IJuggler;
	import game.managers.locations.LocationLayerName;
	import game.managers.locations.LocationLayerProvider;
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationSortLayerLogic extends LocationLogic implements IAnimatable
	{
		[Inject]
		public var juggler:IJuggler;
		[Inject]
		public var battleLogic:LocationBattleLogic;
		[Inject]
		public var layerProvider:LocationLayerProvider;
		
		private var _objectLayer:Sprite;
		
		public function LocationSortLayerLogic()
		{
		
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			_objectLayer = layerProvider.getLayer(LocationLayerName.OBJECTS);
			juggler.add(this);
		}
		
		override protected function onDispose():void
		{
			juggler.remove(this);
			_objectLayer = null;
			
			super.onDispose();
		}
		
		/* INTERFACE starling.animation.IAnimatable */
		
		public function advanceTime(time:Number):void
		{
			if (!battleLogic.isRewind)
			{
				_objectLayer.sortChildren(sort);
			}
		}
		
		private function sort(left:Object, right:Object):int
		{
			if (left.y > right.y) return 1;
			return -1;
		}
	
	}

}