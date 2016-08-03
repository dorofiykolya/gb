package game.net
{
	import game.modules.net.NetHandler;
	import game.net.commands.auth.UserAuthInfoCommand;
	import game.net.commands.auth.UserAuthStateCommand;
	import game.net.commands.checksums.CheckSumsCommand;
	import game.net.commands.initialization.InitializationCommand;
	import game.net.commands.localization.LocalizationCommand;
	import game.net.commands.purchase.NotTrackedPurchasesCommand;
	import game.net.commands.purchase.PurchasesProcessedCommand;
	import game.net.commands.rating.RatingCommand;
	import game.net.commands.top.TopCommand;
	import game.net.commands.userInfo.UserInfoCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NetListener extends NetHandler
	{
		
		public function NetListener()
		{
			add(NetPacket.INITIALIZATION, new InitializationCommand());
			add(NetPacket.LANGUAGES, new LocalizationCommand());
			add(NetPacket.USER_INFO, new UserInfoCommand());
			add(NetPacket.USER_AUTH_INFO, new UserAuthInfoCommand());
			add(NetPacket.USER_AUTH_STATE, new UserAuthStateCommand());
			add(NetPacket.CHECK_SUMS, new CheckSumsCommand());
			
			add(NetPacket.TOP, new TopCommand());
			add(NetPacket.RATING, new RatingCommand());
			
			add(NetPacket.NOT_TRACKED_PURCHASES, new NotTrackedPurchasesCommand());
			add(NetPacket.PURCHASES_PROCESSED, new PurchasesProcessedCommand());
		}
	
	}

}