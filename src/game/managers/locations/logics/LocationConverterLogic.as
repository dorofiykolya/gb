package game.managers.locations.logics
{
	import flash.geom.Point;
	import game.utils.Point3;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationConverterLogic extends LocationLogic
	{
		
		public function LocationConverterLogic()
		{
			super();
		}
		
		public function toLogic(game:Point, result:Point = null):Point
		{
			if (result == null) result = new Point();
			result.copyFrom(game);
			return result;
		}
		
		public function toGame(logic:Point, result:Point = null):Point
		{
			if (result == null) result = new Point();
			result.copyFrom(logic);
			return result;
		}
		
		public function toLogic3(game:Point3, result:Point3 = null):Point3
		{
			if (result == null) result = new Point3();
			result.copyFrom(game);
			return result;
		}
		
		public function toGame3(logic:Point3, result:Point3 = null):Point3
		{
			if (result == null) result = new Point3();
			result.copyFrom(logic);
			return result;
		}
	
	}

}