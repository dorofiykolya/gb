package game.view.modules.hud
{
	import common.system.Enum;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StateAction extends Enum
	{
		public static const NONE:StateAction = new StateAction(0);
		public static const UNLOAD:StateAction = new StateAction(1);
		public static const HIDE:StateAction = new StateAction(2);
		
		public function StateAction(value:Object)
		{
			super(value);
		}
	
	}

}