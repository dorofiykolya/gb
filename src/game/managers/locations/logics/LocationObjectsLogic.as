package game.managers.locations.logics
{
	import common.composite.Component;
	import common.injection.IInjector;
	import common.system.Assert;
	import game.managers.locations.mediators.LocationObject;
	import game.managers.locations.mediators.LocationObjectFactory;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationObjectsLogic extends LocationLogic
	{
		[Inject]
		public var injector:IInjector;
		
		private var _objectId:int;
		private var _map:Vector.<LocationObject>;
		private var _factory:LocationObjectFactory;
		
		public function LocationObjectsLogic()
		{
			_map = new Vector.<LocationObject>();
			_factory = new LocationObjectFactory();
		}
		
		override public function initialize():void
		{
			super.initialize();
			_objectId = 0;
			_map.length = 0;
		}
		
		public function getByObjectId(objectId:int):LocationObject
		{
			return _map[objectId];
		}
		
		public function instantiate(type:Class, objectId:int):LocationObject
		{
			var result:LocationObject = _factory.instantiate(type);
			result.setObjectId(objectId);
			
			if (_map.length <= objectId)
			{
				_map.length = objectId + 1;
			}
			_map[objectId] = result;
			
			injector.inject(result);
			_factory.initializeObject(result, injector, location);
			
			return result;
		}
	
	}

}