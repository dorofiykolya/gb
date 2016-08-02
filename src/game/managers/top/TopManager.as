package game.managers.top
{
	import common.events.EventDispatcher;
	
	[Event(name = "change", type = "common.events.Event")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TopManager extends EventDispatcher
	{
		private var _userTop:Top;
		private var _clanTop:Top;
		private var _localUserTop:Top;
		private var _localClanTop:Top;
		private var _userTopPreviousSeason:Top;
		
		public function TopManager()
		{
		}
		
		public function update(top:Top):void
		{
			
			if (top.isPastSeason && top.ratingType == TopType.USER)
			{
				_userTopPreviousSeason = top;
				dispatchEventAs(TopEvent, TopEvent.USERS_PS_CHANGE, false, -1);
				return;
			}
			
			if (top.ratingType == TopType.CLAN)
			{
				_clanTop = top;
				dispatchEventAs(TopEvent, TopEvent.CLAN_CHANGE, false, -1);
				return;
			}
			
			if (!top.isPastSeason && top.ratingType == TopType.USER)
			{
				_userTop = top;
				dispatchEventAs(TopEvent, TopEvent.USERS_CHANGE, false, -1);
				return
			}
			
			if (top.ratingType == TopType.LOCAL_USER)
			{
				_localUserTop = top;
				dispatchEventAs(TopEvent, TopEvent.LOCAL_USERS_CHANGE, false, -1);
				return
			}
			
			if (top.ratingType == TopType.LOCAL_CLAN)
			{
				_localClanTop = top;
				dispatchEventAs(TopEvent, TopEvent.LOCAL_CLAN_CHANGE, false, -1);
				return
			}
			
			dispatchEventAs(TopEvent, TopEvent.CHANGE, false, -1);
		}
		
		public function get timeForEndSeason():String
		{
			return "5.30";
		}
		
		public function get topClan():Vector.<TopClan>
		{
			return _clanTop && _clanTop.clans ? _clanTop.clans : null;
		}
		
		public function get topUser():Vector.<TopUser>
		{
			return _userTop && _userTop.users ? _userTop.users : null;
		}
		
		public function get localTopUser():Vector.<TopUser>
		{
			return _localUserTop && _localUserTop.users ? _localUserTop.users : null
		}
		
		public function get localTopClan():Vector.<TopClan>
		{
			return _localClanTop && _localClanTop.clans ? _localClanTop.clans : null
		}
		
		public function get topUserPreviousSeason():Vector.<TopUser>
		{
			return _userTopPreviousSeason && _userTopPreviousSeason.users ? _userTopPreviousSeason.users : null;
		}
	}
}