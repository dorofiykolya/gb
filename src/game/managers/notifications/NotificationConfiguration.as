package game.managers.notifications 
{
	import game.mvc.view.ILayers;
	import common.context.IContext;
	import game.view.LayerIndex;
	import mvc.configurations.IConfigurable;
	import starling.display.Stage;
	import starling.events.ResizeEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NotificationConfiguration implements IConfigurable 
	{
		[Inject]
		public var layers:ILayers;
		[Inject]
		public var view:INotificationView;
		[Inject]
		public var stage:Stage;
		
		public function NotificationConfiguration() 
		{
			
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void 
		{
			layers.getLayer(LayerIndex.NOTIFICATION).add(view.view);
			stage.addEventListener(ResizeEvent.RESIZE, onResize);
			view.resize(stage.stageWidth, stage.stageHeight);
		}
		
		private function onResize(e:ResizeEvent):void 
		{
			view.resize(e.width, e.height);
		}
	}
}