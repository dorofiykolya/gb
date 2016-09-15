package game.managers.battles.players
{
	import common.composite.Component;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PlayerManna extends Component
	{
		private var _manna:Number = 0;
		private var _maxManna:Number = 100;
		
		public function PlayerManna()
		{
		
		}
		
		public function add(value:Number):Boolean
		{
			_manna += value;
			return true;
		}
		
		public function remove(value:Number):Boolean
		{
			_manna -= value;
			return true;
		}
		
		public function get max():Number
		{
			return _maxManna;
		}
		
		public function get value():Number
		{
			return _manna;
		}
	
	}

}