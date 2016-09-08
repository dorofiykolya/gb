package game.managers.battles.actors
{
	import game.managers.battles.components.MoveComponent;
	import game.managers.battles.engine.BattleObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUnit extends BattleObject
	{
		private var _move:MoveComponent;
		
		public function BattleUnit()
		{
			_move = addComponent(MoveComponent) as MoveComponent;
		}
		
		public function initialize(from:BattleBuilding, to:BattleBuilding, unitCount:int):void
		{
			transform.setFrom(from.transform);
			_move.moveTo(to.transform);
		}
	
	}

}