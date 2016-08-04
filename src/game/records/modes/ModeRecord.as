package game.records.modes
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ModeRecord
	{
		public var id:int;
		public var name:String;
		public var description:String;
		public var icon:String;
		public var view:String;
		public var type:int;
		public var levels:Vector.<ModeLevelRecord>;
		
		public function ModeRecord()
		{
		
		}
	
	}

}