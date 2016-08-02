package game.managers.dragonBones 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DragonBonesExtension implements IExtension 
	{
		
		public function DragonBonesExtension() 
		{
			
		}
		
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(DBConfiguration);
			context.install(DragonBonesFactory);
			context.install(new Link(DragonBonesFactory, IDBFactory));
		}
		
	}

}