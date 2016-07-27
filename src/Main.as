package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Main extends GameApplication 
	{
		
		public function Main() 
		{
			new GameInitialization(this);
		}
		
	}
	
}