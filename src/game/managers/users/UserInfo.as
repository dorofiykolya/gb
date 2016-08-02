package game.managers.users 
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UserInfo 
	{
		public var name:String;
		public var id:int;
		public var serverKey:String;
		public var userAccessLevel:int;
		public var canChangeName:Boolean;

		public var donatedToday:int;
		public var banReason:String;
		public var timeToClanChange:int;
		public var banRemainingTime:int;
		public var tutorialFinished:Boolean;
		public var isLinked:Boolean;
		public var shareReportText:Boolean;
		public var createTime:int;
		public var timeBeforeChangeName:int;
		public var settings:UserSettingsInfo;
		
		public function UserInfo() 
		{
			
		}
		
	}

}