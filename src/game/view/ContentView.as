package game.view
{
	import starling.extensions.utils.DisplayListUtils;
	import flash.geom.Rectangle;
	import game.view.Content;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.SpriteBox;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ContentView extends SpriteBox
	{
		private static var _helpRect:Rectangle = new Rectangle();
		
		public var vAlign:Boolean;
		public var hAlign:Boolean;
		public var scaleBackground:Boolean;
		public var backgroundVAlign:Boolean;
		public var backgroundHAlign:Boolean;
		
		private var _background:DisplayObject;
		private var _content:DisplayObject;
		private var _scaledChilds:Vector.<starling.display.DisplayObject>;
		
		public function ContentView()
		{
			_scaledChilds = new Vector.<DisplayObject>();
			
			setContentSize(Content.contentWidth, Content.contentHeight);
		}
		
		override public function set width(value:Number):void
		{
			contentWidth = value;
			updateContentViewSize();
		}
		
		override public function set height(value:Number):void
		{
			contentHeight = value;
			updateContentViewSize();
		}
		
		public function addScaledChild(child:DisplayObject):void
		{
			_scaledChilds.push(child);
			insert(child);
			updateScaledChilds();
		}
		
		public function removeScaledChild(child:DisplayObject):void
		{
			var index:int = _scaledChilds.indexOf(child);
			if (index != -1)
			{
				_scaledChilds.removeAt(index);
			}
			cut(child);
		}
		
		public function get background():DisplayObject
		{
			return _background;
		}
		
		public function set background(value:DisplayObject):void
		{
			if (value == null)
			{
				if (_background != null)
				{
					_background.cutFromParent();
					_background = null;
				}
			}
			else
			{
				_background = value;
				if (contains(value))
				{
					setChildIndex(value, 0);
				}
				else
				{
					insertAt(value, 0);
				}
				updateContentViewSize();
			}
		}
		
		public function get content():DisplayObject
		{
			return _content;
		}
		
		public function set content(value:DisplayObject):void
		{
			if (value == null)
			{
				if (_content != null)
				{
					_content.cutFromParent();
					_content = null;
				}
			}
			else
			{
				if (_content != value)
				{
					_content = value;
					onSetContent();
					insertContent(_content)
					updateContentViewSize();
				}
			}
		}
		
		protected function insertContent(value:DisplayObject):void
		{
			insert(value);
		}
		
		public function getContentElement(... path):DisplayObject
		{
			if (_content != null)
			{
				return DisplayListUtils.getByNamePath(DisplayObjectContainer(_content), path);
			}
			return null;
		}
		
		protected function onSetContent():void
		{
		
		}
		
		protected function updateContentViewSize():Boolean
		{
			var contentScale:Number = Content.calculateScale(Content.contentWidth, Content.contentHeight, contentWidth, contentHeight);
			if (_background != null)
			{
				if (scaleBackground)
				{
					_background.scale = contentScale;
					if (backgroundHAlign || backgroundVAlign)
					{
						_background.getBounds(_background.parent, _helpRect);
						if (backgroundHAlign)
						{
							_background.x = Content.round((contentWidth - _helpRect.width) / 2.0);
						}
						if (backgroundVAlign)
						{
							_background.y = Content.round((contentHeight - _helpRect.height) / 2.0);
						}
					}
				}
				else
				{
					_background.width = contentWidth;
					_background.height = contentHeight;
				}
			}
			if (_content)
			{
				_content.scale = contentScale;
				if (vAlign || hAlign)
				{
					_content.getBounds(_content.parent, _helpRect);
					if (hAlign)
					{
						_content.x = Content.round((contentWidth - _helpRect.width) / 2.0);
					}
					if (vAlign)
					{
						_content.y = Content.round((contentHeight - _helpRect.height) / 2.0);
					}
				}
			}
			updateScaledChilds();
			return true;
		}
		
		protected function updateScaledChilds():void
		{
			var contentScale:Number = Content.calculateScale(Content.contentWidth, Content.contentHeight, contentWidth, contentHeight);
			for each (var content:DisplayObject in _scaledChilds)
			{
				if (content)
				{
					content.scale = contentScale;
					if (vAlign || hAlign)
					{
						content.getBounds(content.parent, _helpRect);
						if (hAlign)
						{
							content.x = Content.round((contentWidth - _helpRect.width) / 2.0);
						}
						if (vAlign)
						{
							content.y = Content.round((contentHeight - _helpRect.height) / 2.0);
						}
					}
				}
			}
		}
	}

}