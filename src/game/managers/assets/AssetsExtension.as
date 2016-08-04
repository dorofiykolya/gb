package game.managers.assets
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AssetsExtension implements IExtension
	{
		
		public function AssetsExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(AssetsConfiguration);
		}
	
	}

}