package game.managers.battles.components.buildings
{
	import game.managers.battles.components.buildings.IMannaModifier;
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MannaSlowComponent extends BattleComponent implements IMannaModifier
	{
		
		public function MannaSlowComponent()
		{
			super();
		}
		
		public function mannaModifierPercent():Number
		{
			return 0.9;
		}
	
	}

}