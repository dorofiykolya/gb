package game.managers.assets
{
	import common.context.IContext;
	import common.events.IDispatcher;
	import common.system.ClassType;
	import common.system.reflection.Constant;
	import embeds.AtlasEmbeds;
	import embeds.FontEmbeds;
	import embeds.LayoutEmbeds;
	import game.modules.assets.IAssetsManager;
	import game.modules.layouts.ILayoutProvider;
	import mvc.commands.IEventCommandMap;
	import mvc.configurations.IConfigurable;
	import starling.core.Starling;
	import starling.textures.TextureOptions;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AssetsConfiguration implements IConfigurable
	{
		[Inject]
		public var assets:IAssetsManager;
		[Inject]
		public var dispatcher:IDispatcher;
		[Inject]
		public var command:IEventCommandMap;
		[Inject]
		public var starling:Starling;
		[Inject]
		public var layoutProvider:ILayoutProvider;
		
		public function AssetsConfiguration()
		{
		
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void
		{
			loadFromClassEmbeds(AtlasEmbeds);
			loadFromClassEmbeds(FontEmbeds);
		}
		
		private function mapLayoutFromClassEmbeds(type:Class):void
		{
			var list:Vector.<Constant> = ClassType.getClassType(type).constants;
			for each (var cnst:Constant in list)
			{
				layoutProvider.map(cnst.name, type[cnst.name]);
			}
		}
		
		private function loadFromClassEmbeds(type:Class, scale:Number = 1.0):void
		{
			var list:Vector.<Constant> = ClassType.getClassType(type).constants.sort(function(c1:Constant, c2:Constant):int
			{
				return c1.name > c2.name ? 1 : -1;
			});
			for each (var cnst:Constant in list)
			{
				assets.enqueueWithName(type[cnst.name], cnst.name, new TextureOptions(scale, false));
			}
		}
	}
}