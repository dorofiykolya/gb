package game.managers.locations
{
	import common.composite.Component;
	import common.composite.Entity;
	import common.context.Context;
	import common.context.IContext;
	import common.injection.Injector;
	import common.system.Assert;
	import common.system.ClassType;
	import game.managers.locations.logics.LocationBattleLogic;
	import game.managers.locations.logics.LocationLogic;
	import game.managers.locations.logics.LocationTimeLogic;
	import game.modules.animations.AnimationFactory;
	import game.modules.animations.AnimationProvider;
	import game.mvc.view.ILayers;
	import game.view.LayerIndex;
	import starling.animation.Juggler;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Location extends Entity
	{
		[Inject]
		public var context:Context;
		[Inject]
		public var juggler:Juggler;
		[Inject]
		public var  layer:ILayers;
		
		private var _injector:Injector;
		private var _data:LocationData;
		private var _provider:LogicsProvider;
		private var _logics:Vector.<LocationLogic>;
		private var _layerProvider:LocationLayerProvider;
		
		public function Location()
		{
			_provider = new LogicsProvider();
			_logics = new Vector.<LocationLogic>();
			_layerProvider = new LocationLayerProvider();
		}
		
		public function get id():int
		{
			return _data.id;
		}
		
		public function load(data:LocationData):void
		{
			_injector = _injector || new Injector(context.injector);
			
			_data = data;
			
			addLogics();
			
			injectLogics();
			initializeLogic();
			
			loadedLogics();
			
			layer.getLayer(LayerIndex.SCREEN).add(_layerProvider.root);
		}
		
		public function get data():LocationData
		{
			return _data;
		}
		
		override protected function onDispose():void 
		{
			_logics.length = 0;
			_injector.dispose();
			
			layer.getLayer(LayerIndex.SCREEN).remove(_layerProvider.root);
		}
		
		private function initializeDatas():void
		{
			_injector.map(LocationLayerProvider).toValue(_layerProvider);
		}
		
		private function addLogics():void
		{
			for each (var item:ProviderData in _provider.components)
			{
				var component:Component = addComponent(item.componentType);
				Assert.instanceOf(component, LocationLogic);
				if (item.componentApi)
				{
					_injector.map(item.componentApi).toValue(component);
				}
				_injector.map(item.componentType).toValue(component);
				_logics.push(component);
			}
		}
		
		private function injectLogics():void
		{
			for each (var item:LocationLogic in _logics)
			{
				_injector.inject(item);
			}
		}
		
		private function initializeLogic():void
		{
			for each (var item:LocationLogic in _logics)
			{
				item.initialize();
			}
		}
		
		private function loadedLogics():void
		{
			for each (var item:LocationLogic in _logics)
			{
				item.loaded();
			}
		}
	
	}

}