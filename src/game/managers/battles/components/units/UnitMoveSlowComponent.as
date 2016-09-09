package game.managers.battles.components.units 
{
	import game.managers.battles.components.units.IMoveModifier;
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitMoveSlowComponent extends BattleComponent implements IMoveModifier
	{
		
		public function UnitMoveSlowComponent() 
		{
			
		}
		
		
		public function get moveModifierPercent():Number 
		{
			return 0.5;
		}
		
	}

}