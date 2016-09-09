package game.managers.battles.engine
{
	import game.utils.Math2;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUtils
	{
		
		public function BattleUtils()
		{
		
		}
		
		public static function floor(value:Number):Number
		{
			return Math2.floor(value, 5);
		}
		
		public static function round(value:Number):Number
		{
			return Math2.round(value, 5);
		}
	
	}

}