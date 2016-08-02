package game.managers.navigations 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NavigationExtension implements IExtension 
	{
		
		public function NavigationExtension() 
		{
			
		}
		
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			//CONFIG::ANDROID
			{
				context.install(NavigationManager);
			}
		}
		
	}

}