package game.managers.locations.supports
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IDirection
	{
		function getDirectionPointToPoint(from:Point, to:Point, current:int, threshold:Number = NaN):int;
		function getDegByDirection(direction:int):Number;
		function calculateDirection(gradus:Number, direction:int, threshold:Number):int;
		function getMin(direction:int):Number;
		function getMax(direction:int):Number;
		function getDirection(gradus:Number):int;
	}

}