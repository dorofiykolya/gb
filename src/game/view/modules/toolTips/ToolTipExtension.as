package game.view.modules.toolTips
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ToolTipExtension implements IExtension
	{
		
		public function ToolTipExtension()
		{
		
		}
		
		public function extend(context:IContext):void
		{
			context.install(new Link(ToolTipManager, IToolTipBinder, "toolTip"));
			context.install(ToolTipConfiguration);
			context.install(ToolTipManager);
		}
	
	}

}