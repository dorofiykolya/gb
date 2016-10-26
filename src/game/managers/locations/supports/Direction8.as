package game.managers.locations.supports
{
	import flash.geom.Point;
	import game.utils.Math2;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Direction8 implements IDirection
	{
		private static const THRESHOLD:Number = 15.0;
		
		private static const DELIM:Number = 360.0 / (8 * 2);
		
		public function Direction8()
		{
		
		}
		
		/* INTERFACE game.managers.locations.supports.IDirection */
		
		public function getDirectionPointToPoint(from:Point, to:Point, current:int, threshold:Number = NaN):int
		{
			var gradus:Number = Math2.degreesPoint(from, to);
			var result:int = calculateDirection(gradus, current, (isNaN(threshold) ? THRESHOLD : threshold));
			return result;
		}
		
		public function calculateDirection(gradus:Number, direction:int, threshold:Number):int
		{
			var newDirection:int = getDirection(gradus);
			
			var min:Number = getMin(direction);
			var max:Number = getMax(direction);
			if ((min - gradus) >= threshold || (gradus - max) >= threshold)
			{
				return newDirection;
			}
			return direction;
		}
		
		public function getMin(direction:int):Number
		{
			return Math2.fixDegrees(getDegByDirection(direction) - DELIM);
		}
		
		public function getMax(direction:int):Number
		{
			return Math2.fixDegrees(getDegByDirection(direction) + DELIM);
		}
		
		public function getDegByDirection(direction:int):Number
		{
			switch (direction)
			{
				case 0: 
				case 8: 
					return 270;
				case 1: 
					return 225;
				case 2: 
					return 180;
				case 3: 
					return 135;
				case 4: 
					return 90;
				case 5: 
					return 45;
				case 6: 
					return 0;
				case 7: 
					return 315;
			}
			return 0;
		}
		
		public function getDirection(gradus:Number):int
		{
			gradus = Math2.fixDegrees(gradus);
			
			if (gradus < DELIM || gradus >= 360 - DELIM) return 6; // 0c
			if (gradus >= DELIM && gradus < 90 - DELIM) return 5; // 45c
			if (gradus >= 90 - DELIM && gradus < 90 + DELIM) return 4; //90c
			if (gradus >= 90 + DELIM && gradus < 180 - DELIM) return 3; // 135c
			if (gradus >= 180 - DELIM && gradus < 180 + DELIM) return 2; // 180c
			if (gradus >= 180 + DELIM && gradus < 270 - DELIM) return 1; // 225c
			if (gradus >= 270 - DELIM && gradus < 270 + DELIM) return 0; // 270c
			if (gradus >= 270 + DELIM && gradus < 360 - DELIM) return 7; // 315c
			
			throw new Error();
		}
	
	}

}