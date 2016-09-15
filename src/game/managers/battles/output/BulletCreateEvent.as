package game.managers.battles.output 
{
	import game.managers.battles.engine.OutputEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BulletCreateEvent extends OutputEvent 
	{
		public var objectId:int;
		public var fromObjectId:int;
		public var toObjectId:int;
		
		public function BulletCreateEvent() 
		{
			
		}
		
	}

}