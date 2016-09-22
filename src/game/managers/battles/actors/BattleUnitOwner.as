package game.managers.battles.actors 
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUnitOwner extends BattleObject 
	{
		private var _units:Units;
		
		public function BattleUnitOwner() 
		{
			_units = new Units(this);
		}
		
		public function get units():Units
		{
			return _units;
		}
		
	}

}