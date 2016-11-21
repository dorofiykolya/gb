package game.records
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Race
	{
		public static const RACE_0:int = 0;
		public static const RACE_1:int = 1;
		public static const RACE_2:int = 2;
		
		public function Race()
		{
		
		}
		
		public static function getRaceName(race:int):String
		{
			switch (race)
			{
				case RACE_0: 
					return "vikings";
				default: 
					return "vikings";
			}
			return "vikings";
		}
	
	}

}