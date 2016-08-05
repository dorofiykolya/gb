package game.view.modules.toolTips 
{
	import common.context.IContext;
	import common.system.Environment;
	import mvc.configurations.IConfigurable;
	import mvc.mediators.DefaultMediatorTargetProvider;
	import mvc.mediators.IMediatorContext;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ToolTipConfiguration implements IConfigurable 
	{
		[Inject]
		public var mediator:IMediatorContext;
		[Inject]
		public var manager:ToolTipManager;
		
		public function ToolTipConfiguration() 
		{
			
		}
		
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void 
		{
			mediator.map(ToolTipMediator).target(TooTipView, new DefaultMediatorTargetProvider());
			
			if (!Environment.isMobile)
			{
				//manager.startListen();
			}
		}
		
	}

}