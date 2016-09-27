package game.managers.locations.mediators 
{
	import common.composite.Component;
	import common.injection.IInjector;
	import common.system.Assert;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationObjectFactory 
	{
		
		public function LocationObjectFactory() 
		{
			
		}
		
		public function instantiate(type:Class):LocationObject
		{
			Assert.subclassOf(type, LocationObject);
			return Component.instantiate(type);
		}
		
		public function initializeObject(obj:LocationObject, injector:IInjector):void
		{
			obj.initializeObject(injector);
		}
		
	}

}