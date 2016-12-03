package game.managers.locations.components 
{
	import game.managers.locations.LocationLayerName;
	import game.managers.locations.LocationLayerProvider;
	import game.managers.locations.events.LocationObjectEvent;
	import game.managers.locations.logics.LocationBattlePlayerLogic;
	import game.records.PlayerColor;
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
		[Inject]
		public var playerLogic:LocationBattlePlayerLogic;
		
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
			locationObject.addEventListener(LocationObjectEvent.OWNER, onOwner);
		}
		
		private function onOwner(e:LocationObjectEvent):void 
		{
			var playerIndex:int = playerLogic.getIndex(e.object.ownerId);
			var color:uint = PlayerColor.getColor(playerIndex);
			_textField.color = color;
		}
		
		private function onMove(e:LocationObjectEvent):void 
		{
			_textField.x = e.object.x;
			_textField.y = e.object.y - e.object.z;
		}
		
		override protected function onDetach():void 
		{
			locationObject.removeEventListener(LocationObjectEvent.MOVE, onMove);
			locationObject.removeEventListener(LocationObjectEvent.OWNER, onOwner);
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