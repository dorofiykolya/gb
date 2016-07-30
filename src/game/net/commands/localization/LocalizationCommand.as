package game.net.commands.localization
{
	import common.system.Environment;
	import game.managers.integration.SocialManager;
	import game.managers.integration.SocialType;
	import game.modules.localizations.LocalizationManager;
	import game.modules.net.NetCommand;
	import game.records.localizations.LocalizationRecordMap;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocalizationCommand extends NetCommand
	{
		[Inject]
		public var localizationRecordMap:LocalizationRecordMap;
		[Inject]
		public var localizationManager:LocalizationManager;
		[Inject]
		public var socialManager:SocialManager;
		
		private static const DEFAULT:String = "en";
		private static const DEFAULT_RU_SOCIAL:String = "ru";
		
		public function LocalizationCommand(... flags)
		{
			super(Localization, flags);
		}
		
		override public function execute(data:Object = null):void
		{
			var localization:Localization = Localization(data);
			localizationRecordMap.parse(localization.languages);
			localizationManager.update();
			
			var defaultLanguage:String = DEFAULT;
			if (socialManager.id == SocialType.VKONTAKTE || socialManager.id == SocialType.MAILRU || socialManager.id == SocialType.ODNOKLASSNIKI)
			{
				defaultLanguage = DEFAULT_RU_SOCIAL;
			}
			else
			{
				if(localizationRecordMap.contains(Environment.language.toLowerCase()))
				{
					defaultLanguage = Environment.language.toLowerCase();
				}
			}
			
			localizationManager.language = defaultLanguage;
		}
	
	}

}