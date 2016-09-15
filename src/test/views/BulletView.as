package test.views
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BulletView extends TestView
	{
		public var fromObjectId:int;
		public var toObjectId:int;
		
		public function BulletView()
		{
			graphics.beginFill(0);
			graphics.drawRect(-1, -1, 2, 2);
		}
		
		override public function set ownerId(value:int):void
		{
			super.ownerId = value;
			graphics.beginFill(COLORS[value]);
			graphics.drawRect(-1, -1, 2, 2);
		}
	
	}

}