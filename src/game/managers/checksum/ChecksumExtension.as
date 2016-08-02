package game.managers.checksum 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ChecksumExtension implements IExtension 
	{
		
		public function ChecksumExtension() 
		{
			
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(ChecksumManager);
			context.install(ChecksumConfiguration);
		}
		
	}

}