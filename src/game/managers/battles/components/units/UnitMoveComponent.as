package game.managers.battles.components.units
{
	import common.composite.Component;
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.components.units.IMoveModifier;
	import game.managers.battles.engine.BattleComponent;
	import game.managers.battles.engine.BattleTransform;
	import game.managers.battles.modifiers.ModifierType;
	import game.managers.battles.players.BattlePlayer;
	import game.utils.Math2;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitMoveComponent extends BattleComponent
	{
		private var _temp:Vector.<Component> = new Vector.<Component>();
		
		private var _moveTo:BattleTransform;
		
		public function UnitMoveComponent()
		{
		
		}
		
		override public function get needRemove():Boolean 
		{
			return false;
		}
		
		public function get distancePerTick():Number
		{
			var currentDistancePerTick:Number = BattleUnit(target).info.speed;
			
			_temp.length = 0;
			getComponents(IMoveModifier, false, _temp);
			for each (var item:IMoveModifier in _temp)
			{
				currentDistancePerTick *= item.moveModifierPercent;
			}
			var player:BattlePlayer = engine.players.getPlayer(target.ownerId);
			
			if (player != null)
			{
				currentDistancePerTick = player.modifier.calculate(ModifierType.UNITS_SPEED, currentDistancePerTick, BattleUnit(target).unitId);
			}
			
			return currentDistancePerTick;
		}
		
		public function get targetBuilding():BattleTransform
		{
			return _moveTo;
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
			if (totalDistance == 0)
			{
				return false;
			}
			if (distance > totalDistance)
			{
				distance = totalDistance;
			}
			var ratio:Number = distance / totalDistance;
			
			var newX:Number = Math2.interpolate(fromX, toX, ratio);
			var newY:Number = Math2.interpolate(fromY, toY, ratio);
			
			target.transform.setPosition(newX, newY);
			
			return newX != fromX || newY != fromY;
		}
	
	}

}