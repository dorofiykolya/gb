package game.managers.users 
{
	import game.net.requests.InitializeUserInfo;
	/**
	 * ...
	 * @author ...
	 */
	public class UserInfoManager 
	{
		
		public function UserInfoManager() 
		{
			
		}
		
		public function get info():InitializeUserInfo
		{
			return new InitializeUserInfo();
		}
		
	}

}