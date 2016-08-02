package game.managers.dragonBones
{
	import common.context.IContext;
	import common.system.ClassType;
	import common.system.reflection.Constant;
	import embeds.DBAtlasEmbed;
	import embeds.DBEmbeds;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DBConfiguration implements IConfigurable
	{
		[Inject]
		public var factory:DragonBonesFactory;
		
		public function DBConfiguration()
		{
		
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void
		{
			factory.mapFromType(DBEmbeds);
			factory.mapAtlasFromType(DBAtlasEmbed);
		}
	
	}

}