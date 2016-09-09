package game.managers.battles.actors
{
	import game.managers.battles.components.units.UnitMoveComponent;
	import game.managers.battles.engine.BattleObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUnit extends BattleObject
	{
		private var _move:UnitMoveComponent;
		
		public function BattleUnit()
		{
			_move = addComponent(UnitMoveComponent) as UnitMoveComponent;
		}
		
		public function initialize(from:BattleBuilding, to:BattleBuilding, unitCount:int):void
		{
			transform.setFrom(from.transform);
			_move.moveTo(to.transform);
		}
		
		public function get unitId():int
		{
			return 1;
		}
	
	}

}