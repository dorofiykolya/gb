package game.managers.users
{
	import common.events.EventDispatcher;
	import flash.utils.getTimer;
	import game.configurations.Configuration;
	import game.modules.preloaders.IPreloaderDependency;
	import game.modules.preloaders.PreloaderDependencyEvent;
	import game.net.ServerRequest;
	import game.net.requests.InitializeUserInfoRequest;
	
	[Event(name = "change", type = "game.managers.users.UserEvent")]
	[Event(name = "ratingChange", type = "game.managers.users.UserEvent")]
	[Event(name = "experienceChange", type = "game.managers.users.UserEvent")]
	[Event(name = "levelChange", type = "game.managers.users.UserEvent")]
	[Event(name = "changeName", type = "game.managers.users.UserEvent")]
	[Event(name = "changeSocialName", type = "game.managers.users.UserEvent")]
	[Event(name = "initialize", type = "game.managers.users.UserEvent")]
	//[Event(name = "trainingProgress", type = "game.managers.users.UserEvent")]
	[Event(name = "donatedTodayCount", type = "game.managers.users.UserEvent")]
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UserManager extends EventDispatcher implements IPreloaderDependency
	{
		private var _userInfo:UserInfoManager;
		private var _userSettings:UserSettings;
		private var _request:ServerRequest;
		private var _name:String;
		private var _socialName:String;
		private var _experience:int;
		private var _level:int;
		private var _rating:int;
		
		public var serverKey:String;
		public var id:int;
		public var accessLevel:int;
		public var canChangeName:Boolean;
		
		public var banReason:String;
		public var timeToClanChange:int;
		public var banRemainingTime:int;
		public var tutorialFinished:Boolean;
		public var isLinked:Boolean;
		public var shareReportText:Boolean;
		public var createTime:int;
		public var timeBeforeChangeName:int;
		
		private var _donatedToday:int;
		private var _initialized:Boolean;
		
		public function UserManager(userInfo:UserInfoManager, userSettings:UserSettings, request:ServerRequest, configuration:Configuration)
		{
			_rating = -1;
			_userInfo = userInfo;
			_userSettings = userSettings;
			_request = request;
		}
		
		public function updateInfo(info:UserInfo):void
		{
			_name = info.name;
			id = info.id;
			accessLevel = info.userAccessLevel;
			serverKey = info.serverKey;
			canChangeName = info.canChangeName;
			
			banReason = info.banReason;
			timeToClanChange = info.timeToClanChange;
			banRemainingTime = info.banRemainingTime;
			tutorialFinished = info.tutorialFinished;
			isLinked = info.isLinked;
			shareReportText = info.shareReportText;
			createTime = info.createTime;
			timeBeforeChangeName = info.timeBeforeChangeName;
			donatedToday = info.donatedToday;
			
			dispatchEventAs(UserEvent, UserEvent.TRAINING_PROGRESS, false, this);
			
			if (_userSettings)
			{
				_userSettings.info = info.settings;
			}
			_initialized = true;
			dispatchEventAs(UserEvent, UserEvent.INITIALIZE, false, this);
			dispatchEventAs(UserEvent, UserEvent.CHANGE, false, this);
			dispatchEventAs(PreloaderDependencyEvent, PreloaderDependencyEvent.COMPLETE);
		}
		
		public function initializeUser():void
		{
			_request.initializeUserInfo(new InitializeUserInfoRequest(_userInfo.info));
		}
		
		/* INTERFACE game.modules.preloaders.IPreloaderDependency */
		
		public function get dependencyReady():Boolean
		{
			return _initialized;
		}
		
		public function get rating():int
		{
			return _rating;
		}
		
		public function get donatedToday():int
		{
			return _donatedToday;
		}
		
		public function set donatedToday(value:int):void
		{
			if (_donatedToday != value)
			{
				_donatedToday = value;
				dispatchEventAs(UserEvent, UserEvent.DONATED_TODAY_COUND, false);
			}
		}
		
		public function set rating(value:int):void
		{
			if (value != _rating)
			{
				_rating = value;
				dispatchEventAs(UserEvent, UserEvent.RATING_CHANGE, false, this);
			}
		}
		
		public function get level():int
		{
			return _level;
		}
		
		public function set level(value:int):void
		{
			if (_level != value)
			{
				_level = value;
				dispatchEventAs(UserEvent, UserEvent.LEVEL_CHANGE, false, this);
			}
		}
		
		public function get experience():int
		{
			return _experience;
		}
		
		public function set experience(value:int):void
		{
			if (_experience != value)
			{
				_experience = value;
				dispatchEventAs(UserEvent, UserEvent.EXPERIENCE_CHANGE, false, this);
			}
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			if (_name != value)
			{
				_name = value;
				dispatchEventAs(UserEvent, UserEvent.CHANGE_NAME, false, this);
			}
		}
		
		public function get socialName():String
		{
			return _socialName;
		}
		
		public function set socialName(value:String):void
		{
			if (_socialName != value)
			{
				_socialName = value;
				dispatchEventAs(UserEvent, UserEvent.CHANGE_SOCIAL_NAME, false, this);
			}
		}
		
		public function get userName():String
		{
			return _socialName || _name;
		}
		
		public function get settings():UserSettings
		{
			return _userSettings;
		}
		
		public function get availableClans():Boolean
		{
			return level >= 3;
		}
		
		public function get initialized():Boolean
		{
			return _initialized;
		}
	}

}