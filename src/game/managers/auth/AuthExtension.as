package game.managers.auth
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AuthExtension implements IExtension
	{
		
		public function AuthExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(AuthManager);
			
			CONFIG::ANDROID
			{
				import game.managers.auth.andorid.AndroidAuthManager;
				context.install(new Link(AndroidAuthManager, IDeviceAuthManager));
			}
			CONFIG::IOS
			{
				import game.managers.auth.ios.IOSAthManager;
				context.install(new Link(IOSAthManager, IDeviceAuthManager));
			}
		}
	
	}

}