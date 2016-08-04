package game.commands
{
	import game.Sounds;
	import game.managers.screens.ScreenEvent;
	import game.managers.screens.ScreenId;
	import game.modules.sounds.Channel;
	import game.modules.sounds.SoundManager;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ScreenChangeCommand implements ICommand
	{
		[Inject]
		public var event:ScreenEvent;
		[Inject]
		public var soundManager:SoundManager;
		
		public function ScreenChangeCommand()
		{
		
		}
		
		/* INTERFACE mvc.commands.ICommand */
		
		public function execute():void
		{
			switch(event.screenId)
			{
				case ScreenId.MAIN:
					soundManager.getChannel(Channel.MUSIC).playLoop(Sounds.MUSIC_MAIN);
					break;
				case ScreenId.BATTLE:
					soundManager.getChannel(Channel.FX).play(Sounds.SOUND_BATTLE_START).enqueue(Sounds.SOUND_BATTLE_CAUTION);
					break;
				case ScreenId.BATTLE_REPLAY:
					soundManager.getChannel(Channel.FX).play(Sounds.SOUND_BATTLE_START);
					break;
			}
		}
	
	}

}