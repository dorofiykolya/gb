package game.managers.battles.actors.damages
{
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.engine.BattleTransform;
	import game.managers.battles.actors.units.BattleUnit;
	import game.managers.battles.output.BuildingChangeOwnerEvent;
	import game.managers.battles.output.BuildingRemoveEvent;
	import game.managers.battles.output.UnitAttachedEvent;
	import game.managers.battles.records.BattleBuildingRecord;
	
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
		
		public function setEnemy(unit:BattleUnit, targetBuilding:BattleTransform):void
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
				attachUnits(building, unit);
				return result;
			}
			
			var damageResult:ApplyDamageResult = new ApplyDamageResult();
			
			var buildingDamage:Number = building.powerDamage;
			var unitDamage:Number = unit.powerDamage;
			
			building.receiveDamage(unitDamage);
			unit.receiveDamage(buildingDamage);
			
			if (unit.units.count > building.units.count)
			{
				building.changeOwner(unit.ownerId);
				building.units.change(unit.units.count);
				
				var evt:BuildingChangeOwnerEvent = BuildingChangeOwnerEvent(engine.output.enqueueByFactory(BuildingChangeOwnerEvent, tick));
				evt.objectId = building.objectId;
				evt.ownerId = unit.ownerId;
				evt.units = unit.units.count;
			}
			
			damageResult.x = building.transform.x;
			damageResult.y = building.transform.y;
			damageResult.z = building.transform.z;
			damageResult.ownerId = building.ownerId;
			damageResult.targetId = building.objectId;
			damageResult.damageObjectId = objectId;
			damageResult.units = building.units.count;
			
			result.push(damageResult);
			
			return result;
		}
		
		private function attachUnits(building:BattleBuilding, unit:BattleUnit):void
		{
			unit.attachTo(building);
			
			var evt:UnitAttachedEvent = engine.output.enqueueByFactory(UnitAttachedEvent) as UnitAttachedEvent;
			evt.tick = tick;
			evt.buildingObjectId = _buildingObjectId;
			evt.unitObjectId = unit.objectId;
			evt.buildingUnits = building.units.count;
		
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