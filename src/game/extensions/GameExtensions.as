package game.extensions
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	import embeds.csv.CSVEmbeds;
	import game.configurations.CommandConfiguration;
	import game.configurations.Configuration;
	import game.configurations.ConnectionConfiguration;
	import game.configurations.ConsoleCommandsConfiguration;
	import game.configurations.HotKeyConfiguration;
	import game.managers.animations.AnimationExtension;
	import game.managers.assets.AssetsExtension;
	import game.managers.auth.AuthExtension;
	import game.managers.checksum.ChecksumExtension;
	import game.managers.csv.CSVParserEmbeds;
	import game.managers.debug.DebugManager;
	import game.managers.dragonBones.DragonBonesExtension;
	import game.managers.localization.LocalizationProvider;
	import game.managers.navigations.NavigationExtension;
	import game.managers.notifications.NotificationExtension;
	import game.managers.purchase.PurchaseExtension;
	import game.managers.ratings.RatingManager;
	import game.managers.screens.ScreenManager;
	import game.managers.supersonic.SupersonicExtension;
	import game.managers.top.TopManager;
	import game.managers.users.UserManager;
	import game.managers.users.UserSettings;
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
	import game.mvc.view.ViewContext;
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
			context.install(new AuthExtension());
			context.install(new NavigationExtension());
			context.install(new ChecksumExtension());
			context.install(new DragonBonesExtension());
			context.install(new NotificationExtension());
			context.install(new PurchaseExtension());
			context.install(new SupersonicExtension());
			context.install(new AnimationExtension());
			context.install(new AssetsExtension());
			
			/**
			 * @LINKS
			 */
			
			// view context
			context.install(GameViewContext);
			context.install(new Link(GameViewContext, ViewContext));
			
			// configurations
			context.install(new Configuration());
			
			// screens
			context.install(ScreenManager);
			
			// user
			context.install(UserManager);
			context.install(UserSettings);
			
			context.install(RatingManager);
			context.install(TopManager);
			
			// net
			context.install(new Link(NetListener, INetHandler, "netListener"));
			context.install(new Link(NetErrorListener, INetErrorHandler, "netErrorListener"));
			context.install(ServerRequest);
			
			// localization
			context.install(new Link(new LocalizationProvider, ILocalizationProvider));
			context.install(LocalizationManager);
			
			// debug
			context.install(DebugManager);
			
			/**
			 * @CONFIGURATIONS
			 */
			context.install(ConsoleCommandsConfiguration);
			context.install(HotKeyConfiguration);
			context.install(ConnectionConfiguration);
			context.install(CommandConfiguration);
		
		}
	
	}

}