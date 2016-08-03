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
		static public const USER_INFO:NetPacket = new NetPacket("userInfo");
		static public const USER_AUTH_INFO:NetPacket = new NetPacket("userAuthInfo");
		static public const USER_AUTH_STATE:NetPacket = new NetPacket("userAuthState");
		static public const CHECK_SUMS:NetPacket = new NetPacket("checkSums");
		
		static public const TOP:NetPacket = new NetPacket("top");
		static public const RATING:NetPacket = new NetPacket("rating");
		
		static public const NOT_TRACKED_PURCHASES:NetPacket = new NetPacket("notTrackedPurchases");
		static public const PURCHASES_PROCESSED:NetPacket = new NetPacket("purchasesProcessed");
		
		public function NetPacket(name:String)
		{
			super(name);
		}
	
	}

}