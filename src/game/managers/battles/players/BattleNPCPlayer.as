package game.managers.battles.players
{
	import game.managers.battles.records.BattleNPCRecord;
	import game.records.Race;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleNPCPlayer extends BattlePlayer
	{
		private var _npcPlayer:BattleNPCRecord;
		
		public function BattleNPCPlayer(npcPlayer:BattleNPCRecord)
		{
			_npcPlayer = npcPlayer;
		}
		
		override public function get race():int 
		{
			return Race.RACE_1;
		}
	
	}

}