package game.managers.locations.supports
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import game.utils.Math2;
	
	public class DirectionSupport
	{
		private static const map:Dictionary = getMap();
		
		private static function getMap():Dictionary
		{
			var dictionary:Dictionary = new Dictionary();
			
			dictionary[16] = new Direction16();
			dictionary[8] = new Direction8();
			
			return dictionary;
		}
		
		private static function getIDirection(directions:int):IDirection
		{
			return map[directions] as IDirection;
		}
		
		public static function getDirectionPointToPoint(from:Point, to:Point, directionCount:int, current:int, threshold:Number = NaN):int
		{
			return getIDirection(directionCount).getDirectionPointToPoint(from, to, current, threshold);
		}
		
		public static function getDegByDirection(directionCount:int, direction:int):Number
		{
			return getIDirection(directionCount).getDegByDirection(direction);
		}
		
		public static function calculateDirection(directionCount:int, gradus:Number, direction:int, threshold:Number):int
		{
			return getIDirection(directionCount).calculateDirection(gradus, direction, threshold);
		}
		
		public static function getMin(directionCount:int, direction:int):Number
		{
			 return getIDirection(directionCount).getMax(direction);
		}
		
		public static function getMax(directionCount:int, direction:int):Number
		{
			return getIDirection(directionCount).getMax(direction);
		}
		
		public static function getDirection(directionCount:int, gradus:Number):int
		{
			return getIDirection(directionCount).getDirection(gradus);
		}
	}
}
