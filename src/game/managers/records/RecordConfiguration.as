package game.managers.records 
{
	import common.context.IContext;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class RecordConfiguration implements IConfigurable 
	{
		[Inject]
		public var recordManager:RecordManager;
		
		public function RecordConfiguration() 
		{
			
		}
		
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void 
		{
			recordManager.load();
		}
		
	}

}