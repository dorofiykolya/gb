package game.managers.battles.components.units
{
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitDefenseComponent extends BattleComponent
	{
		private var _defense:int;
		private var _mannaDefense:int;
		
		public function UnitDefenseComponent()
		{
			_defense = 1.0;
		}
		
		public function setPercent(defense:int, mannaDefense:int):void
		{
			_mannaDefense = mannaDefense;
			_defense = defense;
		}
		
		override public function get needRemove():Boolean 
		{
			return false;
		}
		
		public function calculateDefense(defense:Number):Number
		{
			return defense + (defense * (_defense / 100.0));
		}
		
		public function calculateMagicDefense(defense:Number):Number
		{
			return defense + (defense * (_mannaDefense / 100.0));
		}
	
	}

}