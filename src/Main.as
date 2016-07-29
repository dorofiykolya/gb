package
{
	import game.GBContext;
	import game.GameApplication;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Main extends GameApplication
	{
		
		private var _context:GBContext;
		
		public function Main()
		{
			_context = new GBContext(this);
		}
	
	}

}