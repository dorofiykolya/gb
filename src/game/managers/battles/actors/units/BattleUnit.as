package game.managers.battles.actors.units
{
	import game.managers.battles.actors.buildings.BattleBuilding;
	import game.managers.battles.components.units.UnitDefenseComponent;
	import game.managers.battles.components.units.UnitMoveComponent;
	import game.managers.battles.actors.BattleObject;
	import game.managers.battles.modifiers.ModifierType;
	import game.records.units.UnitLevelRecord;
	import game.records.units.UnitRecord;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUnit extends BattleObject
	{
		private var _move:UnitMoveComponent;
		private var _info:UnitRecord;
		private var _infoLevel:UnitLevelRecord;
		private var _level:int;
		private var _hp:Number;
		private var _unitHP:Number;
		private var _attachedToBuilding:Boolean;
		
		public function BattleUnit()
		{
			_move = addComponent(UnitMoveComponent) as UnitMoveComponent;
		}
		
		public function get info():UnitRecord
		{
			return _info;
		}
		
		public function get infoLevel():UnitLevelRecord
		{
			return _infoLevel;
		}
		
		public function initialize(from:BattleBuilding, to:BattleBuilding, unitCount:int):void
		{
			_attachedToBuilding = false;
			_level = from.battleInfo.unitLevel;
			_info = engine.configuration.unitRecords.getById(from.battleInfo.unitId);
			_infoLevel = _info.levels[_level];
			_move.moveTo(to.transform);
			transform.setFrom(from.transform);
			
			_unitHP = engine.players.getPlayer(from.ownerId).modifier.calculate(ModifierType.UNITS_HP, _infoLevel.hp, _info.id);
			_hp = _unitHP * unitCount;
		}
		
		public function get hp():Number
		{
			return _hp;
		}
		
		public function decreaseHp(value:Number):void
		{
			_hp -= value;
		}
		
		public function die():void
		{
			_hp = 0;
		}
		
		public function attachTo(building:BattleBuilding):void 
		{
			building.addUnits(units);
			_attachedToBuilding = true;
			_hp = 0;
		}
		
		public function get level():int
		{
			return _level;
		}
		
		public function get units():int
		{
			return Math.ceil(_hp / _unitHP);
		}
		
		public function get unitId():int
		{
			return _info.id;
		}
		
		public function get powerDamage():Number
		{
			return units * damageOneUnit;
		}
		
		public function get damageOneUnit():Number
		{
			var damage:Number = engine.players.getPlayer(ownerId).modifier.calculate(ModifierType.UNITS_DAMAGE, infoLevel.damage, info.id);
			return damage;
		}
		
		public function get unitDefense():Number
		{
			var defense:UnitDefenseComponent = getComponent(UnitDefenseComponent) as UnitDefenseComponent;
			if (defense != null)
			{
				return defense.calculateDefense(_infoLevel.defense);
			}
			return _infoLevel.defense;
		}
		
		public function get unitMagicDefense():Number
		{
			var defense:UnitDefenseComponent = getComponent(UnitDefenseComponent) as UnitDefenseComponent;
			if (defense != null)
			{
				return defense.calculateMagicDefense(_infoLevel.magicDefense);
			}
			return _infoLevel.magicDefense;
		}
		
		public function get hpOneUnit():Number
		{
			return _unitHP;
		}
		
		public function get attachedToBuilding():Boolean 
		{
			return _attachedToBuilding;
		}
	
	}

}