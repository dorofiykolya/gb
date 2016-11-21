package game.managers.locations.logics
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationBattlePlayerLogic extends LocationLogic
	{
		[Inject]
		public var battleLogic:LocationBattleLogic;
		
		public function LocationBattlePlayerLogic()
		{
		
		}
		
		public function getRace(ownerId:int):int
		{
			return battleLogic.engine.players.getPlayer(ownerId).race;
		}
		
		public function getIndex(ownerId:int):int
		{
			return battleLogic.engine.players.getPlayer(ownerId).index;
		}
	
	}

}