package game.managers.battles.actors.bullets
{
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.actors.damages.BattleDamage;
	import game.managers.battles.actors.damages.BattleDamageBuildingBullet;
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.components.bullets.BulletMoveComponent;
	import game.managers.battles.modifiers.ModifierType;
	import game.managers.battles.output.BulletMoveEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleBulletBuilding extends BattleBullet
	{
		private var _target:BattleUnit;
		private var _move:BulletMoveComponent;
		private var _damage:Number;
		
		public function BattleBulletBuilding()
		{
			super();
			_move = BulletMoveComponent(addComponent(BulletMoveComponent));
		}
		
		override public function update(tick:int, deltaTick:int):void
		{
			var move:BulletMoveComponent = getComponent(BulletMoveComponent) as BulletMoveComponent;
			if (move.updatePosition(deltaTick))
			{
				var evt:BulletMoveEvent = engine.output.enqueueByFactory(BulletMoveEvent) as BulletMoveEvent;
				evt.objectId = this.objectId;
				evt.tick = tick;
				evt.x = this.transform.x;
				evt.y = this.transform.y;
				evt.z = this.transform.z;
			}
		}
		
		override public function generateDamage():BattleDamage 
		{
			var damage:BattleDamageBuildingBullet = engine.context.actors.factory.instantiate(BattleDamageBuildingBullet) as BattleDamageBuildingBullet;
			damage.transform.setFrom(transform);
			damage.setOwnerId(ownerId);
			damage.setDamage(_damage);
			damage.setTarget(_target.objectId);
			return damage;
		}
		
		public function setInfoFrom(building:BattleBuilding):void 
		{
			var damage:int = building.infoLevel.damage;
			_damage = engine.players.getPlayer(building.ownerId).modifier.calculate(ModifierType.BUILDING_DAMAGE, damage, building.info.id);
		}
		
		override public function get needGenerateDamage():Boolean 
		{
			return _move.moveCompleted;
		}
		
		override public function get needRemove():Boolean 
		{
			return _move.moveCompleted;
		}
		
		public function get target():BattleUnit
		{
			return _target;
		}
		
		public function set target(value:BattleUnit):void
		{
			_target = value;
			_move.moveTo(value.transform);
		}
	
	}

}