package game.view.modules.bubbles
{
	import common.context.IContext;
	import game.view.modules.bubbles.BubbleMediator;
	import game.view.modules.bubbles.BubbleView;
	import mvc.configurations.IConfigurable;
	import mvc.mediators.DefaultMediatorTargetProvider;
	import mvc.mediators.IMediatorContext;
	
	public class BubbleConfiguration implements IConfigurable
	{
		[Inject]
		public var mediatorContext:IMediatorContext;
		
		public function BubbleConfiguration()
		{
		}
		
		public function config(context:IContext):void
		{
			mediatorContext.map(BubbleMediator).target(BubbleView, new DefaultMediatorTargetProvider());
		}
	}
}
