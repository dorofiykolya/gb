package game.view.modules.toolTips
{
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ToolTipInfo
	{
		public var highLightColor:uint;
		public var highLight:Boolean;
		public var everyFrame:Boolean;
		public var format:Function;
		public var localizationKey:String;
		public var target:DisplayObject;
		
		public function ToolTipInfo(target:DisplayObject, localizationKey:String, format:Function, everyFrame:Boolean, highLight:Boolean, highLightColor:uint)
		{
			this.highLightColor = highLightColor;
			this.highLight = highLight;
			this.everyFrame = everyFrame;
			this.format = format;
			this.localizationKey = localizationKey;
			this.target = target;
		}
	
	}

}