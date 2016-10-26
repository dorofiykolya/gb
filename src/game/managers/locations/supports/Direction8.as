package game.managers.locations.supports
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Direction8 implements IDirection
	{
		
		public function Direction8()
		{
		
		}
		
		/* INTERFACE game.managers.locations.supports.IDirection */
		
		public function getDirectionPointToPoint(from:Point, to:Point, current:int, threshold:Number = NaN):int
		{
			return 0;
		}
		
		public function calculateDirection(gradus:Number, direction:int, threshold:Number):int
		{
			return 0;
		}
		
		public function getMin(direction:int):Number
		{
			return 0;
		}
		
		public function getMax(direction:int):Number
		{
			return 0;
		}
		
		public function getDegByDirection(direction:int):Number
		{
			return 0;
		}
		
		public function getDirection(gradus:Number):int
		{
			return 0;
		}
	
	}

}