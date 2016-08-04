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
					//new ResourceLink("http://app.vk.com/c420527/u9438868/e4ede7ed888536.swf", 1.0, "sounds.swf"),
					
					new ResourceLink("http://app.vk.com/c420924/u9438868/07e8df5b69a44c.swf", 0.46875, "backgrounds.swf"),
					new ResourceLink("http://app.vk.com/c420919/u9438868/0fff21f162af34.swf", 0.46875, "effects.swf"),
					
					new ResourceLink("http://app.vk.com/c420631/u9438868/cfd96c1411a0b5.swf", 0.46875, "cards1.swf"),
					new ResourceLink("http://app.vk.com/c6194/u9438868/c0da663aaf9943.swf", 0.46875, "cards2.swf"),
					new ResourceLink("http://app.vk.com/c420330/u9438868/9af962dadc42cb.swf", 0.46875, "buildings.swf"),
					
					new ResourceLink("http://app.vk.com/c420226/u9438868/1a714c4ad939c6.swf", 0.46875, "barrels.swf"),
					new ResourceLink("http://app.vk.com/c420220/u9438868/6d3589678803b2.swf", 0.46875, "bombs.swf"),
					
					new ResourceLink("http://app.vk.com/c420217/u9438868/0641dd946875eb.swf", 0.2, "shadows.swf")
				]);
			}
			else
			{
				resourceManager.load(new Vector.<ResourceLink>());
			}
		}
	
	}

}