package game.managers.locations.components
{
	import game.managers.locations.IJuggler;
	import game.managers.locations.LocationLayerName;
	import game.managers.locations.LocationLayerProvider;
	import game.modules.assets.ITextureProvider;
	import starling.animation.IAnimatable;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBuildingSelectionComponent extends LocationObjectComponent implements IAnimatable
	{
		[Inject]
		public var textureProvider:ITextureProvider;
		[Inject]
		public var layerProvider:LocationLayerProvider;
		[Inject]
		public var juggler:IJuggler;
		
		private var _container:Sprite;
		private var _image:Image;
		
		public function LocationBuildingSelectionComponent()
		{
			_container = new Sprite();
		}
		
		public function advanceTime(time:Number):void
		{
			_image.rotation += time;
		}
		
		public function setColor(color:uint):void
		{
			_image.color = color;
		}
		
		override protected function onAttach():void
		{
			super.onAttach();
			
			juggler.add(this);
			
			if (_image == null)
			{
				_image = new Image(textureProvider.getTexture("target_cicles/circle_normal"));
				_image.alignPivot();
				_image.scale = 2;
				_container.insert(_image);
				_container.scaleY = 0.6;
			}
			
			layerProvider.getLayer(LocationLayerName.BOTTOM).insert(_container);
			
			_container.x = locationObject.x;
			_container.y = locationObject.y;
		}
		
		override protected function onDetach():void
		{
			juggler.remove(this);
			_container.cutFromParent();
			
			super.onDetach();
		}
	
	}

}