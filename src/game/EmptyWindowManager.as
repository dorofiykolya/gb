package game 
{
	import game.modules.windows.WindowData;
	import game.modules.windows.WindowId;
	import game.modules.windows.WindowsManager;
	import game.mvc.view.ILayers;
	import game.mvc.view.ViewContext;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class EmptyWindowManager extends WindowsManager
	{
		
		public function EmptyWindowManager(context:ViewContext, layers:ILayers) 
		{
			super(context, layers);
		}
		
		override public function open(id:WindowId, data:WindowData = null, from:Object = null):void 
		{
			//super.open(id, data, from);
		}
		
	}

}