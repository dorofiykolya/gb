package game.managers.locations.components
{
	import common.composite.Component;
	import game.managers.locations.mediators.LocationObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationObjectComponent extends Component
	{
		
		public function LocationObjectComponent()
		{
		
		}
		
		public function get locationObject():LocationObject
		{
			return entity as LocationObject;
		}
	
	}

}