package test.views 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TestView extends Sprite 
	{
		public static const COLORS:Array = [0x0000ff, 0xff0000, 0x00ff00];
		
		public var objectId:int;
		private var _ownerId:int;
		
		public function TestView() 
		{
			super();
			
		}
		
		public function get ownerId():int 
		{
			return _ownerId;
		}
		
		public function set ownerId(value:int):void 
		{
			_ownerId = value;
		}
		
	}

}