package game.managers.users
{
	import common.events.EventDispatcher;
	import game.modules.localizations.LocalizationManager;
	import game.modules.sounds.Channel;
	import game.modules.sounds.SoundManager;
	import game.net.ServerRequest;
	
	[Event(name = "changeSettings", type = "game.managers.users.UserEvent")]
	
	public class UserSettings extends EventDispatcher
	{
		[Inject]
		public var soundManager:SoundManager;
		
		[Inject]
		public var localizationManager:LocalizationManager;
		
		[Inject]
		public var request:ServerRequest;
		
		private var _music:Boolean;
		private var _sounds:Boolean;
		
		public function UserSettings()
		{
			_music = true;
			_sounds = true;
		}
		
		public function get language():String
		{
			return localizationManager.language;
		}
		
		public function set language(value:String):void
		{
			if (localizationManager.language != value)
			{
				localizationManager.language = value;
				commitProperties();
			}
		}
		
		public function get sounds():Boolean
		{
			return _sounds;
		}
		
		public function set sounds(value:Boolean):void
		{
			if (_sounds == value)
			{
				return;
			}
			_sounds = value;
			soundManager.getChannel(Channel.FX).mute = !value;
			//soundManager.mute = _music == false && _sounds == false;
			commitProperties();
		}
		
		public function get music():Boolean
		{
			return _music;
		}
		
		public function set music(value:Boolean):void
		{
			if (_music == value)
			{
				return;
			}
			_music = value;
			soundManager.getChannel(Channel.MUSIC).mute = !value;
			//soundManager.mute = _music == false && _sounds == false;
			commitProperties();
		}
		
		public function set info(value:UserSettingsInfo):void
		{
			music = value.music;
			sounds = value.sounds;
			language = value.language;
		}
		
		private function commitProperties():void
		{
			dispatchEventAs(UserEvent, UserEvent.CHANGE_SETTINGS, false, this);
			request.settings(localizationManager.language, _sounds, _music);
		}
	}

}