package game.configurations
{
	import com.junkbyte.console.Cc;
	import common.context.IContext;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ConsoleCommandsConfiguration implements IConfigurable
	{
		
		public function ConsoleCommandsConfiguration()
		{
		
		}
		
		private function map(name:String, callBack:Function, description:String = ""):void
		{
			Cc.addSlashCommand(name, callBack, description);
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void
		{
			
		}
	
	}

}