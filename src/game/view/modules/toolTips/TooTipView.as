package game.view.modules.toolTips
{
	import game.view.Content;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.display.SpriteBox;
	import starling.extensions.utils.DisplayListUtils;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TooTipView extends SpriteBox
	{
		private static const WIDTH_OFFSET:Number = Content.scale(28);
		private static const HEIGHT_OFFSET:Number = Content.scale(12);
		
		private var _value:Sprite;
		private var _background:DisplayObject;
		private var _title:TextField;
		
		public function TooTipView()
		{
			touchable = false;
		}
		
		public function setContent(value:Sprite):void
		{
			_value = value;
			
			_background = DisplayListUtils.getByName(value, "background");
			_title = DisplayListUtils.getTextField(value, "title");
			
			insert(_value);
		}
		
		public function resize(width:int, height:int):void
		{
			scale = Content.calculateScale(Content.contentWidth, Content.contentHeight, width, height);
		}
		
		public function get title():String
		{
			return _title.text;
		}
		
		public function set title(value:String):void
		{
			_title.text = value;
			updateBackground();
		}
		
		private function updateBackground():void
		{
			_background.width = contentWidth = _title.width + WIDTH_OFFSET;
			_background.height = contentHeight = _title.height + HEIGHT_OFFSET;
		}
	
	}

}