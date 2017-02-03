package game.managers.battles.actors 
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleUnitOwner extends BattleObject 
	{
		private var _units:UnitsContainer;
		
		public function BattleUnitOwner() 
		{
			_units = new UnitsContainer(this);
		}
		
		public function get units():UnitsContainer
		{
			return _units;
		}
		
	}

}