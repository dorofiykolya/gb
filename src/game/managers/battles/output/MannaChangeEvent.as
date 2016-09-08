package game.managers.battles.output
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MannaChangeEvent extends OutputEvent
	{
		public var ownerId:int;
		public var manna:Number;
		
		public function MannaChangeEvent()
		{
			super();
		}
	
	}

}