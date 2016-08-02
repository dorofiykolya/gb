package game.managers.notifications
{
	import starling.extensions.utils.DisplayListUtils;
	import embeds.LayoutEmbeds;
	import game.modules.uibuilder.IUIBuilderFactory;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.SpriteBox;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	[Event(name = "complete", type = "starling.events.Event")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NotificationText extends EventDispatcher
	{
		private var _tween:Tween;
		
		private var _textField:TextField;
		private var _shadow:TextField;
		private var _content:Sprite
		private var _width:int;
		private var _height:int;
		
		public function NotificationText(width:int, height:int)
		{		
			
			_width = width;
			_height = height;
		}
		
		public function animate():void
		{
			_content.alpha = 1.0;
			_tween.reset(_content, 2, Transitions.EASE_IN);
			_tween.onComplete = onComplete;
			_tween.fadeTo(0);
			Starling.juggler.add(_tween);
		}
		
		public function get content():Sprite 
		{
			return _content;
		}
		public function set content(value:Sprite):void
		{
			_content = value;
			var itemBox:SpriteBox = DisplayListUtils.getSpriteBox(_content, "itemBox");
			_textField = DisplayListUtils.getTextField(itemBox, "text");	
			_shadow = DisplayListUtils.getTextField(itemBox, "shadow");
			_tween = new Tween(_content, 3);
		}
		
		public function get color():uint
		{
			return _textField.color;
		}
		
		public function set color(value:uint):void 
		{
			_textField.color = value;
		}
		
		private function onComplete():void
		{
			dispatchEventWith(Event.COMPLETE, false, this);
		}
		
		public function get text():String 
		{
			return _textField.text;
		}
		
		public function set text(value:String):void 
		{
			_textField.text = value;
			if (_shadow != null)
			{
				_shadow.text = value;
			}
		}
		
		public function get width():int 
		{
			return _width;
		}
		
		public function set width(value:int):void 
		{
			_width = value;
			if (_content != null)
			{
				//_content.width = _width;
			}
		}
		
		public function get height():int 
		{
			return _height;
		}
		
		public function set height(value:int):void 
		{
			_height = value;
			if (_content != null)
			{
				//_content.height = _height;
			}
		}
	
	}

}