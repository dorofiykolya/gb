package game.managers.battles.components.bullets
{
	import common.composite.Component;
	import game.managers.battles.engine.BattleComponent;
	import game.managers.battles.engine.BattleTransform;
	import game.utils.Math2;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BulletMoveComponent extends BattleComponent
	{
		private var _temp:Vector.<Component> = new Vector.<Component>();
		
		private var _moveTo:BattleTransform;
		
		public function BulletMoveComponent()
		{
			super();
		
		}
		
		override public function get needRemove():Boolean 
		{
			return false;
		}
		
		public function get distancePerTick():Number
		{
			var currentDistancePerTick:Number = 5;
			
			return currentDistancePerTick;
		}
		
		public function get moveCompleted():Boolean
		{
			return target.transform.positionDistance(_moveTo) <= 0;
		}
		
		public function moveTo(transform:BattleTransform):void
		{
			_moveTo = transform;
		}
		
		public function updatePosition(deltaTick:int):Boolean
		{
			var distance:Number = distancePerTick * deltaTick;
			
			var fromX:Number = target.transform.x;
			var fromY:Number = target.transform.y;
			
			var toX:Number = _moveTo.x;
			var toY:Number = _moveTo.y;
			
			var totalDistance:Number = Math2.distance(fromX, fromY, toX, toY);
			if (distance > totalDistance)
			{
				distance = totalDistance;
			}
			var ratio:Number = totalDistance == 0? 1 : distance / totalDistance;
			
			var newX:Number = Math2.interpolate(fromX, toX, ratio);
			var newY:Number = Math2.interpolate(fromY, toY, ratio);
			
			target.transform.setPosition(newX, newY);
			
			return newX != fromX || newY != fromY;
		}
	
	}

}