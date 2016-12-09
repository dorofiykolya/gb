package game.commands
{
	import common.system.Environment;
	import game.modules.resources.ResourceLink;
	import game.modules.resources.ResourceManager;
	import mvc.commands.ICommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ResourceStartLoadCommand implements ICommand
	{
		[Inject]
		public var resourceManager:ResourceManager;
		
		public function ResourceStartLoadCommand()
		{
		
		}
		
		/* INTERFACE mvc.commands.ICommand */
		
		public function execute():void
		{
			if (CONFIG::MOBILE)
			{
				resourceManager.load(new Vector.<ResourceLink>());
			}
			else if(!CONFIG::EMBED)
			{
				resourceManager.load(new <ResourceLink>
				[
					//new ResourceLink("http://app.swf", 1.0, "app.swf"),
				]);
			}
			else
			{
				resourceManager.load(new Vector.<ResourceLink>());
			}
		}
	
	}

}