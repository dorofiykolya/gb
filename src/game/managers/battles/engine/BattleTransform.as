package game.managers.battles.engine
{
	import game.managers.battles.engine.BattleObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleTransform
	{
		private var _battleObject:BattleObject;
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		
		public function BattleTransform(battleObject:BattleObject)
		{
			_battleObject = battleObject;
		}
		
		public function get target():BattleObject
		{
			return _battleObject;
		}
		
		public function setFrom(transform:BattleTransform):void
		{
			_x = transform._x;
			_y = transform._y;
			_z = transform._z;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		public function get z():Number
		{
			return _z;
		}
		
		public function set z(value:Number):void
		{
			_z = value;
		}
	
	}

}