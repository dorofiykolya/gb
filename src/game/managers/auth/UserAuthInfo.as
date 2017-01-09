package game.managers.auth 
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UserAuthInfo 
	{
		public var userId:int;
		public var authTime:int;
		public var authKey:String;
		public var isNewAppUser:Boolean;
		public var isBrowser:Boolean;
		public var socialType:int;
		
		public function UserAuthInfo() 
		{
			
		}
		
	}

}