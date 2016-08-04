/**
 * Jenek Lukashuk on 31.10.2014.
 */
package game.commands
{
	import common.events.Event;
	import common.events.IDispatcher;
	import game.configurations.AssetsConfiguration;
	import game.modules.assets.AssetEvent;
	import game.modules.assets.IAssetsManager;
	import game.modules.resources.LocalDataLoaderManager;
	import game.modules.logs.ILogger;
	import game.modules.preloaders.PreloaderManager;
	import game.modules.sounds.Channel;
	import game.modules.sounds.SoundManager;
	import game.Sounds;
	import mvc.commands.ICommand;
	
	public class StarlingContextCommand implements ICommand
	{
		[Inject]
		public var dispatcher:IDispatcher;
		[Inject]
		public var assetManager:IAssetsManager;
		[Inject]
		public var assetsConfiguration:AssetsConfiguration;
		[Inject]
		public var preloaderManager:PreloaderManager;
		[Inject]
		public var soundManager:SoundManager;
		[Inject]
		public var logger:ILogger;
		[Inject]
		public var localLoader:LocalDataLoaderManager;
		
		public function StarlingContextCommand()
		{
		}
		
		public function execute():void
		{
			assetsConfiguration.loadAll();
			preloaderManager.show();
			preloaderManager.setProgress(0.25);
			
			soundManager.getChannel(Channel.FX).play(Sounds.SOUND_START_GAME);
			
			if (localLoader && !localLoader.completed)
			{
				localLoader.addEventListener(Event.COMPLETE, function(data:Object):void
				{
					assetManager.loadQueue(onProgress);
				});
			}
			else
			{
				assetManager.loadQueue(onProgress);
			}
		}
		
		private function onProgress(value:Number):void
		{
			logger.note("PROGRESS / " + value);
			preloaderManager.setProgress(0.25 + (value * 0.25));
			if (value == 1.0)
			{
				dispatcher.dispatchEventAs(AssetEvent, AssetEvent.LOADED);
			}
		}
	}
}
