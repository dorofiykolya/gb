package game.managers.checksum 
{
	import common.context.IContext;
	import game.modules.storage.StorageManager;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ChecksumConfiguration implements IConfigurable 
	{
		[Inject]
		public var checksum:ChecksumManager;
		
		public function ChecksumConfiguration() 
		{
			
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void 
		{
			checksum.load();
		}
		
	}

}