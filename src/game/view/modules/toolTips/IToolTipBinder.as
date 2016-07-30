package game.view.modules.toolTips
{
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IToolTipBinder
	{
		/**
		 * bind tooltip
		 * @param	target - target
		 * @param	localizeKey - localization key
		 * @param	format - function(text:String):String { return text; }
		 * @param	everyFrame - update everyFrame
		 */
		function bind(target:DisplayObject, localizeKey:String = null, format:Function = null, everyFrame:Boolean = false, highLight:Boolean = true, highLightColor:uint = 0xffffff):void;
	}

}