package game.managers.locations.logics 
{
	import common.composite.Component;
	import game.managers.locations.Location;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationLogic extends Component 
	{
		
		public function LocationLogic() 
		{
			super();
			
		}
		
		public function get location():Location
		{
			return root as Location;
		}
		
		public function loaded():void 
		{
			
		}
		
		
		public function initialize():void 
		{
			
		}
		
	}

}