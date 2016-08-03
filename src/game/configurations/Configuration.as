package game.configurations
{
	import common.system.Environment;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Configuration
	{
		public var productionHost:String;
		public var productionPort:String;
		public var developerId:String;
		
		//status
		public var isBrowser:Boolean;
		public var isDeveloper:Boolean;
		
		//settings
		public var correctAspectRatio:Boolean = false;
		public var ignoreExit:Boolean;
		public var exitTime:Number = 20;//seconds
		public var fps:int = 60;
		public var sleepFps:int = 5;
		
		// debug
		public var isMobileEmulation:Boolean;
		public var isLocal:Boolean;
		public var openStartWindow:Boolean = true;
		public var forseExitFromFight:Boolean = Environment.isDebugger && Environment.isStandAlone;
		
		// app links
		public const ANDROID_APP_LINK:String = "androidAppLink";
		public const IOS_APP_LINK:String = "iosAppLink";
		
		public function Configuration()
		{
		
		}
	
	}

}