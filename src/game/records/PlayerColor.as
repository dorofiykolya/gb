package game.records
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PlayerColor
	{
		
		public function PlayerColor()
		{
		
		}
		
		public static function getColorName(index:int):String
		{
			switch (index)
			{
				case 1: 
					return "green";
				case 2: 
					return "red";
				case 3: 
					return "blue";
				case 4: 
					return "violet";
			}
			return "npc";
		}
		
		public static function getColor(index:int):uint
		{
			switch (index)
			{
				case 1: 
					return 0x10B40C;
				case 2: 
					return 0xEA0000;
				case 3: 
					return 0x1593C8;
				case 4: 
					return 0x9C22BB;
			}
			return 0xDDDDDD;
		}
	
	}

}