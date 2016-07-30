package game.net
{
	import game.modules.net.IConnectionSend;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ServerRequest
	{
		private var _sender:IConnectionSend;
		
		public function ServerRequest(sender:IConnectionSend)
		{
			_sender = sender;
		}
		
		public function send(value:Object):void
		{
			_sender.send(value);
		}
	
	}

}