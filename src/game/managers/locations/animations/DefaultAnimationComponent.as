package game.managers.locations.animations
{
	import flash.events.Event;
	import game.managers.locations.IJuggler;
	import game.managers.locations.LocationLayerName;
	import game.managers.locations.LocationLayerProvider;
	import game.managers.locations.events.LocationObjectEvent;
	import game.managers.locations.logics.LocationTextureLayerFactoryLogic;
	import game.managers.locations.mediators.LocationObject;
	import game.modules.animations.AnimationComponent;
	import game.modules.animations.LayerFactory;
	import game.modules.animations.LayerViewer;
	import starling.display.Quad;
	import starling.events.Event;
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DefaultAnimationComponent extends LocationAnimationComponent
	{
		[Inject]
		public var layerProvider:LocationLayerProvider;
		[Inject]
		public var layerFactory:LayerFactory;
		[Inject]
		public var layerTextureFactory:LocationTextureLayerFactoryLogic;
		[Inject]
		public var juggler:IJuggler;
		
		private var _layers:Vector.<LayerViewer>;
		
		public function DefaultAnimationComponent()
		{
		
		}
		
		override public function get layers():Vector.<LayerViewer>
		{
			return _layers;
		}
		
		override protected function onAttach():void
		{
			super.onAttach();
			
			_layers = layerFactory.getLayers(source);
			if (_layers == null)
			{
				var layer:LayerViewer = layerTextureFactory.getLayer(source);
				if (layer != null)
				{
					_layers = new <LayerViewer>[layer];
				}
			}
			attachToView();
			
			locationObject.addEventListener(LocationObjectEvent.MOVE, onMove);
		}
		
		private function attachToView():void
		{
			if (_layers != null)
			{
				for each (var item:LayerViewer in _layers) 
				{
					layerProvider.getLayer(item.layerName).insert(item);
					item.addEventListener(starling.events.Event.COMPLETE, onStateComplete);
					juggler.add(item);
					
					item.x = locationObject.x;
					item.y = locationObject.y;
					item.z = locationObject.z;
				}
			}
		}
		
		private function onStateComplete(e:Object = null):void 
		{
			dispatchEventWith(common.events.Event.COMPLETE);
		}
		
		private function onMove(e:LocationObjectEvent):void
		{
			for each (var item:LayerViewer in _layers)
			{
				item.x = e.object.x;
				item.y = e.object.y;
				item.z = e.object.z;
			}
		}
		
		override protected function onDetach():void
		{
			locationObject.removeEventListener(LocationObjectEvent.MOVE, onMove);
			
			super.onDetach();
		}
	
	}

}