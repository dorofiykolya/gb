package game.managers.notifications
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface INotificationView
	{
		function notify(message:String):void;
		function warning(message:String):void;
		function error(message:String):void;
		function get view():Object;
		function resize(width:Number, height:Number):void;
	}

}