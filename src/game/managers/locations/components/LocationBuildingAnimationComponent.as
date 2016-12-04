package game.managers.locations.components
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBuildingAnimationComponent extends LocationObjectAnimationComponent
	{
		
		public function LocationBuildingAnimationComponent()
		{
		
		}
		
		public function setHover(value:Boolean):void
		{
			if (component)
			{
				component.setHover(value);
			}
		}
	
	}

}