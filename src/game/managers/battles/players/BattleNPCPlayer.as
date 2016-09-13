package game.managers.battles.players
{
	import game.managers.battles.records.BattleNPCRecord;
	
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
	
	}

}