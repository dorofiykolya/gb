package game.managers.battles.actors.damages
{
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.engine.BattleTransform;
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.output.UnitAttachedEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleDamageUnitToBuilding extends BattleDamage
	{
		private var _unitObjectId:int;
		private var _buildingObjectId:int;
		
		public function BattleDamageUnitToBuilding()
		{
		
		}
		
		public function setEnemies(unit:BattleUnit, targetBuilding:BattleTransform):void
		{
			_unitObjectId = unit.objectId;
			_buildingObjectId = targetBuilding.target.objectId;
		}
		
		public override function update(tick:int, deltaTick:int):void
		{
		
		}
		
		public override function applyDamage(tick:int, result:Vector.<ApplyDamageResult> = null):Vector.<ApplyDamageResult>
		{
			if (result == null) result = new Vector.<ApplyDamageResult>();
			
			var unit:BattleUnit = engine.context.actors.getActorByObjectId(_unitObjectId) as BattleUnit;
			if (unit == null) 
			{
				return result;
			}
			
			var building:BattleBuilding = engine.context.actors.getActorByObjectId(_buildingObjectId) as BattleBuilding;
			if (building.ownerId == unit.ownerId)
			{
				unit.attachTo(building);
				
				var evt:UnitAttachedEvent = engine.output.enqueueByFactory(UnitAttachedEvent) as UnitAttachedEvent;
				evt.tick = tick;
				evt.buildingObjectId = _buildingObjectId;
				evt.unitObjectId = unit.objectId;
				evt.buildingUnits = building.units;
				
				return result;
			}
			
			var damageResult:ApplyDamageResult = new ApplyDamageResult();
			
			var buildingDamage:Number = building.powerDamage;
			var unitDamage:Number = unit.powerDamage;
			
			building.receiveDamage(unitDamage);
			unit.receiveDamage(buildingDamage);
			
			if (unit.units > 0 && building.units > 0)
			{
				throw new Error();
			}
			if (building.units <= 0 && unit.units > 0)
			{
				building.changeOwner(unit.ownerId);
				building.setUnits(unit.units);
			}
			
			damageResult.x = building.transform.x;
			damageResult.y = building.transform.y;
			damageResult.z = building.transform.z;
			damageResult.ownerId = building.ownerId;
			damageResult.targetId = building.objectId;
			damageResult.damageObjectId = objectId;
			damageResult.hp = building.hp;
			
			result.push(damageResult);
			
			return result;
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