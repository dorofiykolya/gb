package game.managers.auth
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AuthState
	{
		//(0 — все хорошо, 1 — не верный userKey, 2 — время сессии истекло, 3 — корявый authKey, 4 — неведома зверушка, тобишь, ошибка)
		public static const SUCCESS:int = 0;
		public static const INCORRECT_USER_KEY:int = 1;
		public static const SESSION_TIME_OUT:int = 2;
		public static const INCORRECT_AUTH_KEY:int = 3;
		public static const ERROR:int = 4;
		
		public function AuthState()
		{
		
		}
	
	}

}