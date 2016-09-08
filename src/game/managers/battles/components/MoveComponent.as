package game.managers.battles.components
{
	import flash.geom.Point;
	import game.managers.battles.engine.BattleComponent;
	import game.managers.battles.engine.BattleTransform;
	import game.utils.Math2;
	import game.utils.Point3;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MoveComponent extends BattleComponent
	{
		private var _moveTo:BattleTransform;
		
		public function MoveComponent()
		{
		
		}
		
		public function get distancePerTick():Number
		{
			return 1;
		}
		
		public function moveTo(transform:BattleTransform):void
		{
			_moveTo = transform;
		}
		
		public function updatePosition(deltaTick:int):void
		{
			var distance = distancePerTick * deltaTick;
			
		}
	
	}

}