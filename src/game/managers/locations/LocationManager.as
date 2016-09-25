package game.managers.locations
{
	import common.composite.Component;
	import common.context.IContext;
	import common.events.EventDispatcher;
	import common.events.IEventDispatcher;
	import game.managers.locations.events.LocationEvent;
	
	[Event(name = "loaded", type = "game.managers.locations.events.LocationEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationManager extends EventDispatcher
	{
		private var _context:IContext;
		private var _location:Location;
		private var _eventDispatcher:IEventDispatcher;
		
		public function LocationManager(context:IContext, eventDispatcher:IEventDispatcher)
		{
			_eventDispatcher = eventDispatcher;
			_context = context;
		}
		
		public function loaded():Boolean
		{
			return _location != null;
		}
		
		public function get location():Location
		{
			return _location;
		}
		
		public function load(data:LocationData):void
		{
			dispose();
			_location = Component.instantiate(Location) as Location;
			_context.injector.inject(_location);
			_location.load(data);
			_location.dispatchEventAs(LocationEvent, LocationEvent.LOADED, false, _location);
			dispatchEventAs(LocationEvent, LocationEvent.LOADED, false, _location);
			_eventDispatcher.dispatchEventAs(LocationEvent, LocationEvent.LOADED, false, _location);
		}
		
		public function dispose():void
		{
			if (_location != null)
			{
				_location.dispose();
				_location = null;
			}
		}
	
	}

}