package game.managers.battles.actors.damages
{
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.engine.ActorsGroup;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleDamageBuildingBullet extends BattleDamage
	{
		private var _targetObjectId:int;
		private var _damage:Number;
		
		public function BattleDamageBuildingBullet()
		{
		
		}
		
		public override function update(tick:int, deltaTick:int):void
		{
		
		}
		
		public override function applyDamage(tick:int, result:Vector.<ApplyDamageResult> = null):Vector.<ApplyDamageResult>
		{
			if (result == null) result = new Vector.<ApplyDamageResult>();
			var target:BattleUnit = engine.context.actors.getActorByObjectId(_targetObjectId) as BattleUnit;
			if (target == null)
			{
				return result;
			}
			
			target.receiveDamage(_damage);
			
			var damageResult:ApplyDamageResult = new ApplyDamageResult();
			damageResult.units = target.hp;
			damageResult.ownerId = target.ownerId;
			damageResult.targetId = _targetObjectId;
			damageResult.damageObjectId = objectId;
			damageResult.x = transform.x;
			damageResult.y = transform.y;
			damageResult.z = transform.z;
			
			result.push(damageResult);
			
			return result;
		}
		
		public function setDamage(damage:Number):void
		{
			_damage = damage;
		}
		
		public function setTarget(objectId:int):void
		{
			_targetObjectId = objectId;
		}
		
		public override function get needApplyDamage():Boolean
		{
			return true;
		}
		
		public override function get needRemove():Boolean
		{
			return true;
		}
	
	}

}