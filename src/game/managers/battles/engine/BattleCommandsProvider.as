package game.managers.battles.engine
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleCommandsProvider
	{
		private var _collection:Vector.<BattleEngineCommand>;
		
		public function BattleCommandsProvider()
		{
			_collection = new Vector.<BattleEngineCommand>();
		}
		
		public function add(command:BattleEngineCommand):BattleCommandsProvider
		{
			_collection.push(command);
			return this;
		}
		
		public function get commands():Vector.<BattleEngineCommand>
		{
			return _collection;
		}
	
	}

}