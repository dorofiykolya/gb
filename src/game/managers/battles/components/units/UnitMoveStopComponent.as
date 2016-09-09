package game.managers.battles.components.units 
{
	import game.managers.battles.components.units.IMoveModifier;
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitMoveStopComponent extends BattleComponent implements IMoveModifier
	{
		
		public function UnitMoveStopComponent() 
		{
			
		}
		
		public function get moveModifierPercent():Number 
		{
			return 0;
		}
		
	}

}