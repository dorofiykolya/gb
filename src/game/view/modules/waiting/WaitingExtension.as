package game.view.modules.waiting
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WaitingExtension implements IExtension
	{
		
		public function WaitingExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(WaitingManager);
		}
	
	}

}