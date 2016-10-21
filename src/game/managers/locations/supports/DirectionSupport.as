package game.managers.locations.supports
{
	import flash.geom.Point;
	import game.utils.Math2;
	
	public class DirectionSupport
	{
		private static const PICOEF:Number = 180 / Math.PI - 90;
		private static const OFFSET:int = -45;
		private static const THRESHOLD:Number = 15.0;
		
		private static var coef:Number;
		private static var point1:Point;
		private static var point2:Point;
		private static var result:Number;
		private static var gradus:Number;
		
		public static function getDirectionPointToPoint(from:Point, to:Point, directionCount:int, current:int, threshold:Number = NaN):int
		{
			var gradus:Number = Math2.degreesPoint(from, to);
			var result:int;
			switch (directionCount)
			{
				case 16: 
					result = calculateDirection16(gradus, current, (isNaN(threshold) ? THRESHOLD : threshold));
					break;
				default: 
					var COEF:Number = 360.0 / directionCount / 2.0 / 360.0 * directionCount;
					var COEF_HALF:Number = COEF / 2.0;
					result = gradus / 360.0 * directionCount - COEF_HALF;
					if (result - int(result) >= COEF)
					{
						result = int(result) + 1;
					}
					break;
			}
			
			return result;
		}
		
		public static function getDegByDirection(direction:int):Number
		{
			return getDegByDirection16(direction);
		}
		
		public static function calculateDirection16(gradus:Number, direction:int, threshold:Number):int
		{
			var newDirection:int = getDirection16(gradus);
			
			var min:Number = getMin16(direction);
			var max:Number = getMax16(direction);
			if ((min - gradus) >= threshold || (gradus - max) >= threshold)
			{
				return newDirection;
			}
			return direction;
		}
		
		public static function getMin16(direction:int):Number
		{
			switch (direction)
			{
				case 16: 
				case 0: 
					return 258.75;
				case 1: 
					return 236.25;
				case 2: 
					return 213.75;
				case 3: 
					return 191.25;
				case 4: 
					return 168.75;
				case 5: 
					return 146.25;
				case 6: 
					return 123.75;
				case 7: 
					return 101.25;
				case 8: 
					return 78.75;
				case 9: 
					return 56.25;
				case 10: 
					return 33.75;
				case 11: 
					return 11.25;
				case 12: 
					return 348.75;
				case 13: 
					return 326.25;
				case 14: 
					return 303.75;
				case 15: 
					return 281.25;
			}
			return NaN;
		}
		
		public static function getMax16(direction:int):Number
		{
			switch (direction)
			{
				case 16: 
				case 0: 
					return 281.25;
				case 1: 
					return 258.75;
				case 2: 
					return 236.25;
				case 3: 
					return 213.75;
				case 4: 
					return 191.25;
				case 5: 
					return 168.75;
				case 6: 
					return 146.25;
				case 7: 
					return 123.75;
				case 8: 
					return 101.25;
				case 9: 
					return 78.75;
				case 10: 
					return 56.25;
				case 11: 
					return 33.75;
				case 12: 
					return 11.25;
				case 13: 
					return 348.75;
				case 14: 
					return 326.25;
				case 15: 
					return 303.75;
			}
			return NaN;
		}
		
		public static function getDegByDirection16(direction:int):Number
		{
			switch (direction)
			{
				case 0: 
					return 270;
				case 16: 
					return 270;
				case 1: 
					return 247.5;
				case 2: 
					return 225;
				case 3: 
					return 202.5;
				case 4: 
					return 180;
				case 5: 
					return 157.5;
				case 6: 
					return 135;
				case 7: 
					return 112.5;
				case 8: 
					return 90;
				case 9: 
					return 67.5;
				case 10: 
					return 45;
				case 11: 
					return 22.5;
				case 12: 
					return 0;
				case 13: 
					return 360 - 22.5;
				case 14: 
					return 360 - 45;
				case 15: 
					return 360 - 67.5;
			}
			return 0;
		}
		
		public static function getDirection16(gradus:Number):int
		{
			gradus = Math2.fixDegrees(gradus);
			if (348.75 >= gradus && gradus > 326.25)
				return 13;
			if (326.25 >= gradus && gradus > 303.75)
				return 14;
			if (303.75 >= gradus && gradus > 281.25)
				return 15;
			if (281.25 >= gradus && gradus > 258.75)
				return 0;
			if (258.75 >= gradus && gradus > 236.25)
				return 1;
			if (236.25 >= gradus && gradus > 213.75)
				return 2;
			if (213.75 >= gradus && gradus > 191.25)
				return 3;
			if (191.25 >= gradus && gradus > 168.75)
				return 4;
			if (168.75 >= gradus && gradus > 146.25)
				return 5;
			if (146.25 >= gradus && gradus > 123.75)
				return 6;
			if (123.75 >= gradus && gradus > 101.25)
				return 7;
			if (101.25 >= gradus && gradus > 78.75)
				return 8;
			if (78.75 >= gradus && gradus > 56.25)
				return 9;
			if (56.25 >= gradus && gradus > 33.75)
				return 10;
			if (33.75 >= gradus && gradus > 11.25)
				return 11;
			if (11.25 >= gradus || gradus > 348.75)
				return 12;
			throw new Error();
		}
	}
}
