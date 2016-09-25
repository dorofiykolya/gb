package game.managers.locations.mediators
{
	import common.composite.Entity;
	import game.managers.locations.Location;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationObject extends Entity
	{
		private var _objectId:int;
		private var _ownerId:int;
		
		public function LocationObject()
		{
			super();
		}
		
		public function get location():Location
		{
			return root as Location;
		}
		
		public function get objectId():int
		{
			return _objectId;
		}
		
		public function get ownerId():int
		{
			return _ownerId;
		}
		
		public function setOwnerId(value:int):void
		{
			_ownerId = value;
		}
	
	}

}