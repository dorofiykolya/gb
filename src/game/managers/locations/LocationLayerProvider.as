package game.managers.locations
{
	import starling.display.Sprite;
	import starling.display.SpriteBox;
	import starling.filters.ShadowFilter;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationLayerProvider
	{
		private var _map:Object;
		private var _root:SpriteBox;
		
		public function LocationLayerProvider()
		{
			_map = {};
			_root = new SpriteBox();
			_root.touchable = false;
			_root.visible = false;
			
			createLayer(LocationLayerName.BACKGROUND);
			createLayer(LocationLayerName.BOTTOM, 	70, 70);
			createLayer(LocationLayerName.SHADOW, 	70, 70).filter = new ShadowFilter();
			createLayer(LocationLayerName.OBJECTS, 	70, 70);
			createLayer(LocationLayerName.AIR, 		70, 70);
			createLayer(LocationLayerName.UI, 		70, 70);
		}
		
		public function get root():Sprite
		{
			return _root;
		}
		
		public function getLayer(name:String):Sprite
		{
			return _map[name];
		}
		
		private function createLayer(name:String, x:Number = 0, y:Number = 0):Sprite
		{
			var layer:Sprite = new Sprite();
			_map[name] = layer;
			layer.name = name;
			layer.x = x;
			layer.y = y;
			root.insert(layer);
			return layer;
		}
	
	}

}