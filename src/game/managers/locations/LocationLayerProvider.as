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
			
			createLayer(LocationLayerName.BACKGROUND);
			createLayer(LocationLayerName.BOTTOM);
			createLayer(LocationLayerName.SHADOW).filter = new ShadowFilter();
			createLayer(LocationLayerName.OBJECTS);
			createLayer(LocationLayerName.AIR);
			createLayer(LocationLayerName.UI);
		}
		
		public function get root():Sprite
		{
			return _root;
		}
		
		public function getLayer(name:String):Sprite
		{
			return _map[name];
		}
		
		private function createLayer(name:String):Sprite
		{
			var layer:Sprite = new Sprite();
			_map[name] = layer;
			layer.name = name;
			root.insert(layer);
			return layer;
		}
	
	}

}