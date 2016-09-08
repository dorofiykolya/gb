package game.managers.battles.components
{
	import game.managers.battles.engine.BattleComponent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MannaRegenComponent extends BattleComponent
	{
		private var _manna:Number;
		
		public function MannaRegenComponent()
		{
			super();
		}
		
		override public function get needRemove():Boolean
		{
			return false;
		}
		
		public function get mannaPerTick():Number
		{
			return _manna;
		}
	
	}

}