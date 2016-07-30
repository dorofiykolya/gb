package game.extensions
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	import embeds.csv.CSVEmbeds;
	import game.Configuration;
	import game.configurations.ConnectionConfiguration;
	import game.configurations.ConsoleCommandsConfiguration;
	import game.configurations.HotKeyConfiguration;
	import game.managers.csv.CSVParserEmbeds;
	import game.managers.localization.LocalizationProvider;
	import game.modules.alert.AlertExtension;
	import game.modules.assets.AssetExtension;
	import game.modules.csv.CSVExtension;
	import game.modules.localizations.ILocalizationProvider;
	import game.modules.localizations.LocalizationManager;
	import game.modules.net.ConnectionExtension;
	import game.modules.net.INetErrorHandler;
	import game.modules.net.INetHandler;
	import game.modules.sounds.SoundExtension;
	import game.modules.states.StateExtension;
	import game.modules.versions.VersionExtension;
	import game.net.NetErrorListener;
	import game.net.NetListener;
	import game.net.ServerRequest;
	import game.view.GameViewContext;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GameExtensions implements IExtension
	{
		
		public function GameExtensions()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			/**
			 * @EXTENSIONS
			 */
			
			context.install(new ConnectionExtension());
			context.install(new StateExtension());
			context.install(new AssetExtension());
			context.install(new CSVExtension(CSVParserEmbeds, CSVEmbeds));
			context.install(new SoundExtension());
			context.install(new VersionExtension());
			context.install(new AlertExtension());
			
			/**
			 * @LINKS
			 */
			
			context.install(GameViewContext);
			
			context.install(new Configuration());
			
			// net
			context.install(new Link(NetListener, INetHandler, "netListener"));
			context.install(new Link(NetErrorListener, INetErrorHandler, "netErrorListener"));
			context.install(ServerRequest);
			
			// localization
			context.install(new Link(new LocalizationProvider, ILocalizationProvider));
			context.install(LocalizationManager);
			
			/**
			 * @CONFIGURATIONS
			 */
			context.install(ConsoleCommandsConfiguration);
			context.install(HotKeyConfiguration);
			context.install(ConnectionConfiguration);
			
		
		}
	
	}

}