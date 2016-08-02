package game.managers.notifications 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NotificationExtension implements IExtension 
	{
		
		public function NotificationExtension() 
		{
			
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(new Link(NotificationView, INotificationView));
			context.install(NotificationManager);
			context.install(NotificationConfiguration);
		}
		
	}

}