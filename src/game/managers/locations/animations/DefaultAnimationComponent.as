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
	import starling.filters.ColorMatrixFilter;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DefaultAnimationComponent extends LocationAnimationComponent
	{
		private static var filter:ColorMatrixFilter;
		
		[Inject]
		public var layerProvider:LocationLayerProvider;
		[Inject]
		public var layerFactory:LayerFactory;
		[Inject]
		public var layerTextureFactory:LocationTextureLayerFactoryLogic;
		[Inject]
		public var juggler:IJuggler;
		
		private var _layers:Vector.<LayerViewer>;
		private var _state:String;
		private var _timeScale:Number;
		
		public function DefaultAnimationComponent()
		{
		
		}
		
		override public function setHover(value:Boolean):void
		{
			if (_layers)
			{
				for each (var layer:LayerViewer in _layers)
				{
					if (layer.layerName == LocationLayerName.OBJECTS)
					{
						if (value)
						{
							layer.filter = filter || (filter = new ColorMatrixFilter().adjustContrast(2));
						}
						else
						{
							layer.filter = null;
						}
					}
				}
			}
		}
		
		override public function setState(newState:String, startOver:Boolean = false, timeScale:Number = 1):void
		{
			state = newState;
			updateState(startOver);
		}
		
		override public function get layers():Vector.<LayerViewer>
		{
			return _layers;
		}
		
		public override function get state():String
		{
			return _state;
		}
		
		public function set state(value:String):void
		{
			_state = value;
		}
		
		public override function get timeScale():Number
		{
			return _timeScale;
		}
		
		public override function set timeScale(value:Number):void
		{
			_timeScale = value;
		}
		
		protected function updateState(startOver:Boolean):void
		{
			for each (var item:LayerViewer in _layers)
			{
				item.setState(state, startOver);
				item.timeScale = timeScale;
			}
		}
		
		override protected function onAttach():void
		{
			super.onAttach();
			
			_timeScale = 1;
			
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
		
		private function detachFromView():void
		{
			if (_layers != null)
			{
				for each (var item:LayerViewer in _layers)
				{
					item.cutFromParent();
					//layerProvider.getLayer(item.layerName).cut(item);
					item.removeEventListener(starling.events.Event.COMPLETE, onStateComplete);
					juggler.remove(item);
				}
				layerFactory.toPool(source, _layers);
				_layers = null;
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
		
		override protected function onDispose():void 
		{
			super.onDispose();
			locationObject.removeEventListener(LocationObjectEvent.MOVE, onMove);
			detachFromView();
		}
		
		override protected function onDetach():void
		{
			locationObject.removeEventListener(LocationObjectEvent.MOVE, onMove);
			detachFromView();
			super.onDetach();
		}
	
	}

}