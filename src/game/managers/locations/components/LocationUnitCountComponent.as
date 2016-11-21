package game.managers.locations.components 
{
	import game.managers.locations.LocationLayerName;
	import game.managers.locations.LocationLayerProvider;
	import game.managers.locations.events.LocationObjectEvent;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationUnitCountComponent extends LocationObjectComponent 
	{
		[Inject]
		public var layer:LocationLayerProvider;
		
		private var _textField:TextField;
		
		public function LocationUnitCountComponent() 
		{
			_textField = new TextField(100, 100, "", BitmapFont.MINI, 36, 0xff0000);
			_textField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
		}
		
		override protected function onAttach():void 
		{
			super.onAttach();
			layer.getLayer(LocationLayerName.UI).insert(_textField);
			locationObject.addEventListener(LocationObjectEvent.MOVE, onMove);
		}
		
		private function onMove(e:LocationObjectEvent):void 
		{
			_textField.x = e.object.x;
			_textField.y = e.object.y - e.object.z;
		}
		
		override protected function onDetach():void 
		{
			locationObject.removeEventListener(LocationObjectEvent.MOVE, onMove);
			_textField.cutFromParent();
			super.onDetach();
		}
		
		public function setUnits(units:int, color:uint):void 
		{
			_textField.text = units.toString();
			_textField.color = color;
			_textField.alignPivot();
		}
		
	}

}