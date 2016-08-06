package game
{
	import common.context.links.Link;
	import common.system.application.Application;
	import game.extensions.GameExtensions;
	import game.extensions.GameRecordsExtension;
	import game.flash.PreloaderView;
	import game.modules.applications.IApplicationDescription;
	import game.modules.preloaders.PreloaderManager;
	import game.mvc.ContextConfiguration;
	import game.mvc.GameContext;
	import game.mvc.events.GameContextEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GBContext extends GameContext
	{
		
		public function GBContext(application:Application)
		{
			super(application, Root, getConfiguration());
			
			addEventListener(GameContextEvent.STAGE_READY, onStageReady);
		}
		
		private function onStageReady():void
		{
			install(new Link(GameDescription, IApplicationDescription));
			install(new PreloaderManager(nativeStage, new PreloaderView()));
			install(new GameExtensions());
			install(new GameRecordsExtension());
		}
		
		private function getConfiguration():ContextConfiguration
		{
			var result:ContextConfiguration = new ContextConfiguration();
			return result;
		}
	}

}