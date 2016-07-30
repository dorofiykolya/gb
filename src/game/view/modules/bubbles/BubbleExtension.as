package game.view.modules.bubbles
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	public class BubbleExtension implements IExtension
	{
		public function BubbleExtension()
		{
		}
		
		public function extend(context:IContext):void
		{
			context.install(BubbleConfiguration);
			context.install(BubbleManager);
		}
	}
}
