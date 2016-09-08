package game.managers.battles.records
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleOwnerRecord
	{
		public var id:int;
		public var name:String;
		public var units:Vector.<BattleUnitRecord>;
		public var skills:Vector.<BattleSkillRecord>;
		public var modifiers:Vector.<BattleModifierRecord>;
		
		public function BattleOwnerRecord()
		{
		
		}
	
	}

}