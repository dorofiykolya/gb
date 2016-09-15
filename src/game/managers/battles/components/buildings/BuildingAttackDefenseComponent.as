package game.managers.battles.components.buildings
{
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.actors.bullets.BattleBullet;
	import game.managers.battles.actors.bullets.BattleBulletBuilding;
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.components.bullets.BulletMoveComponent;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleComponent;
	import game.managers.battles.modifiers.ModifierType;
	import game.managers.battles.output.BulletCreateEvent;
	import game.records.buildings.BuildingRecord;
	
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
		
		public function get ticksBetweenAttack():Number
		{
			var buildng:BattleBuilding = BattleBuilding(target);
			var result:Number = engine.players.getPlayer(target.ownerId).modifier.calculate(ModifierType.BUILDING_ATTACK_RANGE, buildng.infoLevel.attackSpeed, buildng.info.id);
			return result;
		}
		
		public function attack(targetUnit:BattleUnit):void
		{
			_remainingTicksToNextAttack = ticksBetweenAttack;
			
			var bullet:BattleBulletBuilding = engine.context.actors.factory.bulletFactory.instantiate(BattleBulletBuilding) as BattleBulletBuilding;
			bullet.target = targetUnit;
			bullet.setInfoFrom(BattleBuilding(target));
			bullet.setOwnerId(this.target.ownerId);
			engine.context.actors.group(ActorsGroup.BULLET).addComponent(bullet);
			
			var evt:BulletCreateEvent = engine.output.enqueueByFactory(BulletCreateEvent) as BulletCreateEvent;
			evt.tick = engine.tick;
			evt.fromObjectId = target.objectId;
			evt.toObjectId = targetUnit.objectId;
			evt.objectId = bullet.objectId;
		}
		
		public function get range():Number
		{
			return BattleBuilding(target).infoLevel.attackRange;
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