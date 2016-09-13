package game.managers.battles.components.units 
{
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitAttackComponent extends BattleComponent 
	{
		private var _attack:int;
		
		public function UnitAttackComponent()
		{
			_attack = 1.0;
		}
		
		public function setPercent(attack:int):void
		{
			_attack = attack;
		}
		
		override public function get needRemove():Boolean 
		{
			return false;
		}
		
		public function calculateAttack(attack:Number):Number
		{
			return attack + (attack * (_attack / 100.0));
		}
	}

}