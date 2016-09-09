package game.managers.battles.components.buildings
{
	import game.managers.battles.actors.BattleUnit;
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingAttackDefenseComponent extends BattleComponent
	{
		private var _remainingTicksToNextAttack:int;
		
		public function BuildingAttackDefenseComponent()
		{
		
		}
		
		public function get ticksBetweenAttack():int
		{
			return 100;
		}
		
		public function attack(target:BattleUnit):void
		{
			_remainingTicksToNextAttack = ticksBetweenAttack;
			
			engine.actions
		}
		
		public function get range():Number
		{
			return 500;
		}
		
		public function get canAttack():Boolean
		{
			return _remainingTicksToNextAttack <= 0;
		}
		
		public function get remainingTicksToNextAttack():Number
		{
			return _remainingTicksToNextAttack;
		}
		
		override public function get needRemove():Boolean
		{
			return false;
		}
		
		override public function update(tick:int, deltaTick:int):void
		{
			super.update(tick, deltaTick);
			_remainingTicksToNextAttack = Math.max(0, _remainingTicksToNextAttack - deltaTick);
		}
	
	}

}