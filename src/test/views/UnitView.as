package test.views 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UnitView extends TestView 
	{
		public var unitId:int;
		public var level:int;
		private var _units:int;
		
		private var _t:TextField;
		
		public function UnitView() 
		{
			super();
			graphics.beginFill(0);
			graphics.drawRect( -2, -2, 4, 4);
			
			_t = new TextField();
			addChild(_t);
			_t.autoSize = TextFieldAutoSize.LEFT;
			_t.selectable = false;
		}
		
		override public function set ownerId(value:int):void 
		{
			super.ownerId = value;
			graphics.beginFill(COLORS[value]);
			graphics.drawRect( -2, -2, 4, 4);
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