package game.net.commands.rating
{
	import game.managers.users.UserManager;
	import game.modules.net.NetCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class RatingCommand extends NetCommand
	{
		[Inject]
		public var userManager:UserManager;
		
		public function RatingCommand(... flags)
		{
			super(Rating, flags);
		}
		
		override public function execute(data:Object = null):void
		{
			var rating:Rating = Rating(data);
			userManager.rating = rating.quantity;
		}
	
	}

}