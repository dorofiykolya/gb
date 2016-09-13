package game.managers.battles.engine
{
	import flash.geom.Point;
	import game.managers.battles.actors.BattleObject;
	import game.utils.Math2;
	import game.utils.Point3;
	
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
		
		public function copyFrom(transform:BattleTransform):void
		{
			_x = transform._x;
			_y = transform._y;
			_z = transform._z;
		}
		
		public function positionDistance(transform:BattleTransform):Number
		{
			var fromX:Number = _x;
			var fromY:Number = _y;
			
			var toX:Number = transform.x;
			var toY:Number = transform.y;
			
			var distance:Number = Math2.distance(fromX, fromY, toX, toY);
			return distance;
		}
		
		public function positionDistanceTo(x:Number, y:Number):Number
		{
			var fromX:Number = _x;
			var fromY:Number = _y;
			
			var toX:Number = x;
			var toY:Number = y;
			
			var distance:Number = Math2.distance(fromX, fromY, toX, toY);
			return distance;
		}
		
		public function distance(transform:BattleTransform):Number
		{
			var fromX:Number = _x;
			var fromY:Number = _y;
			var fromZ:Number = _z;
			
			var toX:Number = transform.x;
			var toY:Number = transform.y;
			var toZ:Number = transform.z;
			
			var distance:Number = Math2.distance3(fromX, fromY, fromZ, toX, toY, toZ);
			return distance;
		}
		
		public function distanceTo(x:Number, y:Number, z:Number):Number
		{
			var fromX:Number = _x;
			var fromY:Number = _y;
			var fromZ:Number = _z;
			
			var toX:Number = x;
			var toY:Number = y;
			var toZ:Number = z;
			
			var distance:Number = Math2.distance3(fromX, fromY, fromZ, toX, toY, toZ);
			return distance;
		}
		
		public function setPosition(x:Number, y:Number):void
		{
			_x = x;
			_y = y;
		}
		
		public function setFromPoint3(position:Point3):void
		{
			_x = position.x;
			_y = position.y;
			_z = position.z;
		}
		
		public function setFromPoint(position:Point):void
		{
			_x = position.x;
			_y = position.y;
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