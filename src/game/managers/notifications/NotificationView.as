package game.managers.notifications
{
	import common.injection.IInjector;
	import common.system.Environment;
	import embeds.LayoutEmbeds;
	import feathers.utils.display.calculateScaleRatioToFit;
	import game.modules.uibuilder.IUIBuilderFactory;
	import game.view.Content;
	import starling.display.SpriteBox;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NotificationView extends SpriteBox implements INotificationView
	{
		[Inject]
		public var inject:IInjector;
		[Inject]
		public var uiBuilder:IUIBuilderFactory;
		
		private var _pool:Vector.<NotificationText>;
		private var _list:Vector.<NotificationText>;
		
		public function NotificationView()
		{
			setContentSize(Content.contentWidth, Content.contentHeight);
			_list = new Vector.<NotificationText>();
			_pool = new Vector.<NotificationText>();
			touchable = false;
		}
		
		public function notify(message:String):void
		{
			var text:NotificationText = createText();			
			text.addEventListener(Event.COMPLETE, onComplete);
			text.text = message;
			text.color = 0xFFFFFF;
			text.animate();
			updateView();
		}
		
		public function warning(message:String):void
		{
			var text:NotificationText = createText();
			text.addEventListener(Event.COMPLETE, onComplete);
			text.text = message;
			text.color = 0xFAFF20;
			text.animate();
			updateView();
		}
		
		public function error(message:String):void
		{
			var text:NotificationText = createText();
			text.addEventListener(Event.COMPLETE, onComplete);
			text.text = message;
			text.color = 0xFF1010;
			text.animate();
			updateView();
		}
		
		public function resize(newWidth:Number, newHeight:Number):void
		{
			scale = calculateScaleRatioToFit(contentWidth, contentHeight, newWidth, newHeight);
			x = (newWidth - width) / 2;
			y = (newHeight - height) / 2;
			updateView();
		}
		
		public function get view():Object
		{
			return this;
		}
		
		private function onComplete(e:Event):void
		{
			removeText(NotificationText(e.data));
		}
		
		private function createText():NotificationText
		{
			var result:NotificationText;
			if (_pool.length != 0)
			{
				result = _pool.pop();
			}
			else
			{
				result = new NotificationText(contentWidth, contentHeight);
				result.content = uiBuilder.createByLayout(LayoutEmbeds.TEXT_NOTIFICATION);				
			}
			result.width = contentWidth;
			result.height = contentHeight;
			_list.push(result);
			insert(result.content);
			return result;
		}
		
		private function removeText(value:NotificationText):void
		{
			var index:int = _list.indexOf(value);
			_list.splice(index, 1);
			_pool.push(value);
			value.content.cutFromParent();
		}
		
		private function updateView():void
		{
			var i:int = _list.length;
			var y:int = contentHeight >> 1;
			var item:NotificationText;
			while (i-- > 0)
			{
				item = _list[i];
				item.content.y = y;
				item.width = contentWidth;
				y -= item.content.height;
			}
		}
		
		private function get scaleFactor():Number
		{
			if (Environment.isMobile)
			{
				return contentWidth / Content.contentWidth;
			}
			return 1.0;
		}
	
	}

}