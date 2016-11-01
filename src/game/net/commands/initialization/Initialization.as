package game.net.commands.initialization
{
	import game.records.buildings.BuildingRecord;
	import game.records.locations.LocationRecord;
	import game.records.modes.ModeRecord;
	import game.records.skills.SkillRecord;
	import game.records.spells.SpellRecord;
	import game.records.units.UnitRecord;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Initialization
	{
		public var buildings:Vector.<BuildingRecord>;
		public var units:Vector.<UnitRecord>;
		public var locations:Vector.<LocationRecord>;
		public var spells:Vector.<SpellRecord>;
		public var modes:Vector.<ModeRecord>;
		public var skills:Vector.<SkillRecord>;
		
		public function Initialization()
		{
		
		}
	
	}

}