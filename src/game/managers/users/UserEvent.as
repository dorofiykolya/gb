package game.managers.users
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UserEvent extends Event
	{
		public static const CHANGE:String = "change";
		public static const RATING_CHANGE:String = "ratingChange";
		public static const EXPERIENCE_CHANGE:String = "experienceChange";
		public static const LEVEL_CHANGE:String = "levelChange";
		public static const CHANGE_NAME:String = "changeName";
		public static const CHANGE_SOCIAL_NAME:String = "changeSocialName";
		public static const CHANGE_SETTINGS:String = "changeSettings";
		static public const INITIALIZE:String = "initialize";
		static public const TRAINING_PROGRESS:String = "trainingProgress";
		static public const DONATED_TODAY_COUND:String = "donatedTodayCount";
		
		public function UserEvent(type:Object, data:Object = null)
		{
			super(type, data);
		}
		
		public function get userManager():UserManager
		{
			return data as UserManager;
		}
	
	}

}