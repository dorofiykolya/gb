package game.managers.battles.actors.damages
{
	import common.composite.Component;
	import game.managers.battles.actors.BattleObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleDamage extends BattleObject
	{
		
		public function BattleDamage()
		{
		
		}
		
		public function update(tick:int, deltaTick:int):void
		{
		
		}
		
		public function applyDamage(result:Vector.<ApplyDamageResult> = null):Vector.<ApplyDamageResult>
		{
			return result;
		}
		
		public function get needApplyDamage():Boolean
		{
			return false;
		}
		
		public function get needRemove():Boolean
		{
			return true;
		}
	
	}

}