package game.managers.locations.mediators
{
	import common.composite.Component;
	import common.composite.Entity;
	import common.injection.IInjector;
	import common.system.Assert;
	import common.system.ClassType;
	import game.managers.locations.Location;
	import game.managers.locations.components.LocationObjectComponent;
	import game.managers.locations.events.LocationObjectEvent;
	import game.utils.Point3;
	
	[Event(name = "change", type = "game.managers.locations.events.LocationObjectEvent")]
	[Event(name = "move", type = "game.managers.locations.events.LocationObjectEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationObject extends Entity
	{
		private var _objectId:int;
		private var _ownerId:int;
		private var _position:Point3;
		private var _injector:IInjector;
		private var _location:Location;
		
		public function LocationObject()
		{
			_position = new Point3();
		}
		
		public function get x():Number
		{
			return _position.x;
		}
		
		public function get y():Number
		{
			return _position.y;
		}
		
		public function get z():Number
		{
			return _position.z;
		}
		
		public function get objectId():int
		{
			return _objectId;
		}
		
		public function get ownerId():int
		{
			return _ownerId;
		}
		
		public function get location():Location
		{
			return _location;
		}
		
		public function initialize():void
		{
			
		}
		
		public function setOwnerId(value:int):void
		{
			_ownerId = value;
		}
		
		public function setObjectId(value:int):void
		{
			_objectId = value;
		}
		
		public function setPosition(point:Point3):void
		{
			if (!_position.equals(point))
			{
				_position.copyFrom(point);
				dispatchOnMove();
			}
		}
		
		override public function addComponent(component:Object):Component 
		{
			Assert.subclassOf(ClassType.getAsClass(component), LocationObjectComponent);
			
			var result:LocationObjectComponent = super.addComponent(component) as LocationObjectComponent;
			_injector.inject(result);
			result.initialize();
			
			return result;
		}
		
		internal function initializeObject(injector:IInjector, location:Location):void
		{
			_injector = injector;
			_location = location;
			initialize();
		}
		
		protected function dispatchOnMove():void
		{
			dispatchEventAs(LocationObjectEvent, LocationObjectEvent.MOVE, false, this);
		}
		
		protected function dispatchOnChange():void
		{
			dispatchEventAs(LocationObjectEvent, LocationObjectEvent.CHANGE, false, this);
		}
	
	}

}