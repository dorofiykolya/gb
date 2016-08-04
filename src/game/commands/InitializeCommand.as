package game.commands 
{
	import game.mvc.view.controllers.TouchController;
	import common.events.Event;
	import game.managers.users.UserManager;
	import game.managers.users.UserEvent;
	import game.modules.sounds.Channel;
	import game.modules.sounds.SoundManager;
	import game.Sounds;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class InitializeCommand implements ICommand 
	{
		[Inject]
		public var soundManager:SoundManager;
		
		[Inject]
		public var userManager:UserManager;

		public function InitializeCommand() 
		{
			
		}
		
		
		/* INTERFACE mvc.commands.ICommand */
		
		public function execute():void 
		{
			setClickSound();
			setSounds();
			//userManager.settings.addEventListener(UserEvent.CHANGE_SETTINGS, onChangeSettins);
		}
		
		private function onChangeSettins(e:UserEvent):void
		{
			//setSounds();
		}
		
		private function setSounds():void
		{
			soundManager.getChannel(Channel.MUSIC).playLoop(Sounds.MUSIC_MAIN);
		}
		
		private function setClickSound():void
		{
			//TouchController.defaultClickSoundСondition = function():Boolean
			//{
				//soundManager.getChannel(Channel.FX).play(Sounds.SOUND_SELECT_ITEM);
				//return userManager.settings.sounds;
			//}
		}
		
	}

}