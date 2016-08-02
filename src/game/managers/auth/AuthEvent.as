package game.managers.auth
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AuthEvent extends Event
	{
		static public const SUCCESS:String = "success";
		static public const RE_AUTH:String = "reAuth";
		static public const LOST:String = "lost";
		
		public function AuthEvent(type:Object)
		{
			super(type, false, null);
		}
	
	}

}