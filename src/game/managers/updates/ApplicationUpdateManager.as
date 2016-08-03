package game.managers.updates
{
	import common.system.Environment;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import game.configurations.Configuration;
	import game.modules.alert.AlertManager;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ApplicationUpdateManager
	{
		private var _alertManager:AlertManager;
		private var _configuration:Configuration;
		
		public function ApplicationUpdateManager(alertManager:AlertManager, configuration:Configuration)
		{
			_alertManager = alertManager;
			_configuration = configuration;
		}
		
		public function openUpdate():void
		{
			_alertManager.alert("Update", "Update is available!\nA new version of the game is available.", "DOWNLOAD", onClickDownload);
		}
		
		private function onClickDownload():void
		{
			if (Environment.isAndroid)
			{
				navigateToURL(new URLRequest(_configuration.ANDROID_APP_LINK));
			}
			else if (Environment.isIOS)
			{
				navigateToURL(new URLRequest(_configuration.IOS_APP_LINK));
			}
		}
	
	}

}