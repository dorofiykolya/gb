package game.net 
{
	import game.modules.net.NetHandler;
	import game.net.commands.localization.LocalizationCommand;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NetListener extends NetHandler
	{
		
		public function NetListener() 
		{
			add(NetPacket.LANGUAGES, new LocalizationCommand());
		}
		
	}

}