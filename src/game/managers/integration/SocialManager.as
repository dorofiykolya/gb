package game.managers.integration
{
	import flash.utils.Dictionary;
	import game.managers.integration.ISocialService;
	
	public class SocialManager implements ISocialService
	{
		private var _collection:Dictionary;
		private var _current:ISocialService;
		
		public function SocialManager()
		{
			_collection = new Dictionary();
		}
		
		public function map(socialService:ISocialService, id:int):void
		{
			_collection[id] = socialService;
		}
		
		public function select(id:int):void
		{
			current = _collection[id];
			initilize();
			getUserData();
		}
		
		/* DELEGATE integration.ISocialService */
		
		public function initilize():void
		{
			_current.initilize();
		}
		
		public function getUserData():void
		{
			_current.getUserData();
		}
		
		public function getCurrencyPrefix(currency:int):String
		{
			return _current.getCurrencyPrefix(currency);
		}
		
		public function get id():int
		{
			return _current.id;
		}
		
		public function get prefix():String
		{
			return _current.prefix;
		}
		
		public function get current():ISocialService
		{
			return _current;
		}
		
		public function set current(value:ISocialService):void
		{
			_current = value;
		}
		
		public function showPayment(price:int, resourseCount:int, item:String):void
		{
			_current.showPayment(price, resourseCount, item);
		}
	
	}

}