package game.managers.assets
{
	import common.context.IContext;
	import common.events.IDispatcher;
	import common.system.ClassType;
	import common.system.reflection.Constant;
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
			//var uiScale:Number = Number(String(new ConfigurationEmbeds.uiScale));
			//var unitScale:Number = Number(String(new ConfigurationEmbeds.unitScale));
			//var effectScale:Number = Number(String(new ConfigurationEmbeds.effectScale));
			//var shadowScale:Number = Number(String(new ConfigurationEmbeds.shadowScale));
			//var backgroundsScale:Number = Number(String(new ConfigurationEmbeds.backgroundsScale));
			//var buildingsScale:Number = Number(String(new ConfigurationEmbeds.buildingsScale));
			//
			//mapLayoutFromClassEmbeds(LayoutEmbeds);
			//mapLayoutFromClassEmbeds(EffectLayoutEmbeds);
			//
			//loadFromClassEmbeds(UIEmbeds, uiScale);
			//loadFromClassEmbeds(UIDBEmbeds, 1.0);
			//
			//CONFIG::EMBED
			//{
			//loadFromClassEmbeds(BackgroundsExternalEmbeds, 0.46875);
			//loadFromClassEmbeds(BarrelsExternalEmbeds, 0.46875);
			//loadFromClassEmbeds(BombsExternalEmbeds, 0.46875);
			//loadFromClassEmbeds(BuildingsExternalEmbeds, 0.46875);
			//loadFromClassEmbeds(Cards1ExternalEmbeds, 0.46875);
			//loadFromClassEmbeds(Cards2ExternalEmbeds, 0.46875);
			//loadFromClassEmbeds(EffectsExternalEmbeds, 0.46875);
			//loadFromClassEmbeds(ShadowsExternalEmbeds, 0.2);
			//loadFromClassEmbeds(SoundsExternalEmbeds, 1.0);
			//}
		
			//loadFromClassEmbeds(AtlasesEmbeds, unitScale);
			//loadFromClassEmbeds(EffectEmbeds, effectScale);
			//loadFromClassEmbeds(ShadowEmbeds, shadowScale);
			//loadFromClassEmbeds(BackgroundEmbeds, backgroundsScale);
		
			//loadFromClassEmbeds(UnitEmbeds, unitScale);
			//loadFromClassEmbeds(BuildingsEmbeds, buildingsScale);
		
			//loadFromClassEmbeds(TempEmbeds);
			//loadFromClassEmbeds(FontEmbeds);
			//loadFromClassEmbeds(ParticleEmbeds);
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