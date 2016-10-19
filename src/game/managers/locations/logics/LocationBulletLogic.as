package game.managers.locations.logics
{
	import game.managers.battles.output.BulletCreateEvent;
	import game.managers.locations.mediators.LocationBullet;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBulletLogic extends LocationLogic
	{
		[Inject]
		public var factory:LocationObjectsLogic;
		
		public function LocationBulletLogic()
		{
		
		}
		
		public function add(data:BulletCreateEvent):void
		{
			var bullet:LocationBullet = factory.instantiate(LocationBullet, data.objectId) as LocationBullet;
			bullet.setContent(data);
		}
		
		public function remove(objectId:int):void
		{
			factory.getByObjectId(objectId).dispose();
		}
		
		public function getByObjectId(objectId:int):LocationBullet
		{
			return factory.getByObjectId(objectId) as LocationBullet;
		}
	
	}

}