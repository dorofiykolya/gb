package game.managers.battles.players
{
	import common.composite.Component;
	import game.managers.battles.modifiers.ModifierType;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PlayerModifier extends Component
	{
		
		public function PlayerModifier()
		{
		
		}
		
		public function calculate(type:ModifierType, value:Number, id:int = 0):Number
		{
			return value;
		}
	
	}

}