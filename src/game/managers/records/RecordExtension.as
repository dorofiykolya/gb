package game.managers.records 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class RecordExtension implements IExtension 
	{
		
		public function RecordExtension() 
		{
			
		}
		
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(RecordManager);
			context.install(RecordConfiguration);
		}
		
	}

}