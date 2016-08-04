package game.commands
{
	import game.modules.sounds.Channel;
	import game.modules.sounds.SoundManager;
	import game.Sounds;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class FightStartCommand implements ICommand
	{
		[Inject]
		public var soundManager:SoundManager;
		
		public function FightStartCommand()
		{
		
		}
		
		/* INTERFACE mvc.commands.ICommand */
		
		public function execute():void
		{
			soundManager.getChannel(Channel.MUSIC).playLoop(Sounds.MUSIC_BATTLE);
		}
	
	}

}