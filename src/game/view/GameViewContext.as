package game.view
{
	import common.context.IContext;
	import game.mvc.view.ViewContext;
	import game.view.modules.bubbles.BubbleExtension;
	import game.view.modules.toolTips.ToolTipExtension;
	import game.view.modules.waiting.WaitingExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GameViewContext extends ViewContext
	{
		
		public function GameViewContext(parent:IContext)
		{
			super(parent);
			install(new BubbleExtension());
			install(new ToolTipExtension());
			install(new WaitingExtension());
		}
	
	}

}