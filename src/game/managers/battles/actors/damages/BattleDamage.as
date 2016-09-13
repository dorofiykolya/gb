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
		private var _tick:int;
		private var _deltaTick:int;
		
		public function BattleDamage()
		{
		
		}
		
		public function get tick():int
		{
			return _tick;
		}
		
		public function update(tick:int, deltaTick:int):void
		{
			_tick = tick;
			_deltaTick = deltaTick;
		}
		
		public function applyDamage(tick:int, result:Vector.<ApplyDamageResult> = null):Vector.<ApplyDamageResult>
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
		
		public function get deltaTick():int 
		{
			return _deltaTick;
		}
	
	}

}