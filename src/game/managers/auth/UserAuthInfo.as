package game.managers.auth 
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UserAuthInfo 
	{
		public var userKey:int;
		public var authTS:int;
		public var authKey:String;
		public var isNewAppUser:Boolean;
		public var isBrowser:Boolean;
		public var socialType:int;
		
		public function UserAuthInfo() 
		{
			
		}
		
	}

}