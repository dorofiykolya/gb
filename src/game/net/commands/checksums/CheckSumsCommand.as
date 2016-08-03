package game.net.commands.checksums
{
	import game.managers.checksum.CheckSums;
	import game.managers.checksum.ChecksumManager;
	import game.modules.net.NetCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class CheckSumsCommand extends NetCommand
	{
		[Inject]
		public var checksum:ChecksumManager;
		
		public function CheckSumsCommand(... flags)
		{
			super(CheckSums, flags);
		}
		
		override public function execute(data:Object = null):void
		{
			var sum:CheckSums = CheckSums(data);
			checksum.update(sum);
		}
	
	}

}