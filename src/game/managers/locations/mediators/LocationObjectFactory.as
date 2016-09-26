package game.managers.locations.mediators
{
	import common.composite.Component;
	import common.composite.Component;
	import common.injection.IInjector;
	import game.locations.animations.AnimationFactory;
	import game.locations.mediators.LocationObject;
	import game.locations.support.LocationComponentDataProvider;
	import game.locations.support.LocationConverter;
	import game.locations.layers.LocationLayerProvider;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationObjectFactory
	{
		private var _injector:IInjector;
		private var _injectorProvider:LocationComponentDataProvider;
		private var _converter:LocationConverter;
		private var _layerProvider:LocationLayerProvider;
		private var _animationFactory:AnimationFactory;
		
		public function LocationObjectFactory(injector:IInjector, injectorProvider:LocationComponentDataProvider, converter:LocationConverter, layerProvider:LocationLayerProvider, animationFactory:AnimationFactory)
		{
			_animationFactory = animationFactory;
			_layerProvider = layerProvider;
			_converter = converter;
			_injectorProvider = injectorProvider;
			_injector = injector;
		}
		
		public function instantiate(type:Class):LocationObject
		{
			var locationObject:LocationObject = LocationObject(Component.instantiate(type));
			// inject
			_injector.inject(locationObject);
			// invoke initialize
			locationObject.initializeObject(_injectorProvider, _converter, _layerProvider, _animationFactory);
			locationObject.initialize();
			return locationObject;
		}
	}
}