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
		public static const UNITS_INCREASE:ModifierType = new ModifierType();
	}

}