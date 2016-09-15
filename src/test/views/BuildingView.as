package test.views
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BuildingView extends TestView
	{
		public var buildingId:int;
		public var level:int;
		private var _units:int;
		
		private var _t:TextField;
		
		public function BuildingView()
		{
			super();
			
			graphics.beginFill(0);
			graphics.drawRect( -5, -5, 10, 10);
			
			_t = new TextField();
			_t.autoSize = TextFieldAutoSize.LEFT;
			addChild(_t);
		}
		
		override public function set ownerId(value:int):void
		{
			super.ownerId = value;
			graphics.beginFill(COLORS[value]);
			graphics.drawRect(-5, -5, 10, 10);
		}
		
		public function get units():int 
		{
			return _units;
		}
		
		public function set units(value:int):void 
		{
			_units = value;
			_t.text = value.toString();
		}
	
	}

}