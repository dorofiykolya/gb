package game.net.requests
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class InitializeUserInfo
	{
		/**
		 * - тип клиента (может быть не определен)
		 */
		public var clientType:String;
		/**
		 *  — текущий язык клиента;
		 */
		public var language:String;
		/**
		 *  — языки, доступные на клиенте.
		 */
		public var languages:String;
		/**
		 *  — версия андроида;
		 */
		public var osVersion:String;
		/**
		 *  — модель устройства;
		 */
		public var productModel:String;
		/**
		 *  — марка устройства;
		 */
		public var productBrand:String;
		/**
		 *  — название продукта (устройства).
		 */
		public var productName:String;
		/**
		 *  — версия клиента (обязательный параметр!).
		 */
		public var clientVersion:String;
		/**
		 *  — maxTexture
		 */
		public var maxTexture:int;
		/**
		 *
		 */
		public var totalMemory:int;
		/**
		 *
		 */
		public var time:int;
		
		public function InitializeUserInfo()
		{
		
		}
	
	}

}