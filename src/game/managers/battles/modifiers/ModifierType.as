package game.managers.battles.modifiers
{
	import common.system.Enum;
	import common.system.enums.IncrementEnum;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ModifierType extends IncrementEnum
	{
		public static const MANNA_INCREASE:ModifierType = new ModifierType();
		public static const BUILDING_ATTACK_RANGE:ModifierType = new ModifierType();
		public static const BUILDING_DEFENSE:ModifierType = new ModifierType();
		public static const BUILDING_MAGIC_DEFENSE:ModifierType = new ModifierType();
		public static const BUILDING_DAMAGE:ModifierType = new ModifierType();
		public static const UNITS_INCREASE:ModifierType = new ModifierType();
		public static const UNITS_SPEED:ModifierType = new ModifierType();
		public static const UNITS_DAMAGE:ModifierType = new ModifierType();
		public static const UNITS_HP:ModifierType = new ModifierType();
		public static const UNITS_DEFENSE:ModifierType = new ModifierType();
		public static const UNITS_MAGIC_DEFENSE:ModifierType = new ModifierType();
	}

}