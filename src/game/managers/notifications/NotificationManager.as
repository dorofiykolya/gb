package game.managers.notifications
{
	import game.modules.localizations.ILocalizeProvider;
	import common.context.IContext;
	import common.injection.IInjector;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NotificationManager implements IConfigurable
	{
		[Inject]
		public var inject:IInjector;
		
		private var _view:INotificationView;
		private var _localize:ILocalizeProvider;
		
		public function NotificationManager(view:INotificationView, localize:ILocalizeProvider)
		{
			_localize = localize;
			_view = view;
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void 
		{
			inject.inject(_view);
		}
		
		public function notify(message:String):void
		{
			_view.notify(_localize.localize(message));
		}
		
		public function warning(message:String):void
		{
			_view.warning(_localize.localize(message));
		}
		
		public function error(message:String):void
		{
			_view.error(_localize.localize(message));
		}
		
		
		
	
	}

}