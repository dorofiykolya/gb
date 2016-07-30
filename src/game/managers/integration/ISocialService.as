package game.managers.integration
{
	/**
	 * @author Evgeniy on 4/26/2016.
	 */
	public interface ISocialService
	{
		function initilize():void
		function getUserData():void
		function showPayment(price:int, resourseCount:int, item:String):void;
		function getCurrencyPrefix(currency:int):String;
		function get id():int;
		function get prefix():String
	}
}
