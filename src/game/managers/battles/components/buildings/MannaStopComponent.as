package game.managers.battles.components.buildings
{
	import game.managers.battles.components.buildings.IMannaModifier;
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MannaStopComponent extends BattleComponent implements IMannaModifier
	{
		
		public function MannaStopComponent()
		{
			super();
		}
		
		
		/* INTERFACE game.managers.battles.components.IMannaModifier */
		
		public function mannaModifierPercent():Number 
		{
			return 0;
		}
	
	}

}