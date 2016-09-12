package game.managers.battles.engine
{
	import common.system.enums.IncrementEnum;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ActorsGroup extends IncrementEnum
	{
		public static const BUILDING:ActorsGroup = new ActorsGroup();
		public static const UNIT:ActorsGroup = new ActorsGroup();
		public static const SPELL:ActorsGroup = new ActorsGroup();
		public static const BULLET:ActorsGroup = new ActorsGroup();
		public static const DAMAGE:ActorsGroup = new ActorsGroup();
	}

}