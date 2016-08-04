package game.commands
{
	import game.net.ServerRequest;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AuthSuccessCommand implements ICommand
	{
		[Inject]
		public var request:ServerRequest;
		
		public function AuthSuccessCommand()
		{
		
		}
		
		/* INTERFACE mvc.commands.ICommand */
		
		public function execute():void
		{
			request.versionHashes();
			request.clientTime();
		}
	
	}

}