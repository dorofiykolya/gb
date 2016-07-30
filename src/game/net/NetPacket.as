package game.net
{
	import game.modules.net.Packet;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NetPacket extends Packet
	{
		static public const INITIALIZATION:NetPacket = new NetPacket("initialization");
		static public const LANGUAGES:NetPacket = new NetPacket("languages");
		
		public function NetPacket(name:String)
		{
			super(name);
		}
	
	}

}