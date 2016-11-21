package game.managers.locations.logics
{
	import feathers.display.TiledImage;
	import game.managers.locations.LocationLayerName;
	import game.managers.locations.LocationLayerProvider;
	import game.modules.assets.ITextureProvider;
	import starling.display.Stage;
	import starling.events.ResizeEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBackgroundLogic extends LocationLogic
	{
		[Inject]
		public var layerProvider:LocationLayerProvider;
		[Inject]
		public var textureProvider:ITextureProvider;
		[Inject]
		public var stage:Stage;
		
		private var _tile:TiledImage;
		
		public function LocationBackgroundLogic()
		{
		
		}
		
		override protected function onDispose():void
		{
			_tile.cutFromParent();
			super.onDispose();
		}
		
		override public function initialize():void
		{
			super.initialize();
			if (_tile == null)
			{
				_tile = new TiledImage(textureProvider.getTexture("location/nord_bg"));
			}
			layerProvider.getLayer(LocationLayerName.BACKGROUND).insert(_tile);
			stage.addEventListener(ResizeEvent.RESIZE, onStageResize);
			onStageResize();
		}
		
		private function onStageResize(e:ResizeEvent = null):void
		{
			_tile.width = stage.stageWidth;
			_tile.height = stage.stageHeight;
		}
	
	}

}