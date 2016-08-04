package game.managers.animations
{
	import common.context.IContext;
	import common.system.ClassType;
	import common.system.reflection.Constant;
	import game.modules.animations.AnimationProvider;
	import game.modules.animations.IAnimationParser;
	import game.modules.animations.LayerFactory;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AnimationConfiguration implements IConfigurable
	{
		[Inject]
		public var layerFactory:LayerFactory;
		[Inject]
		public var animationProvider:AnimationProvider;
		[Inject]
		public var parser:IAnimationParser;
		
		public function AnimationConfiguration()
		{
		
		}
		
		public function config(context:IContext):void
		{
			//animationProvider.mapByType(AnimationType.SPELL, DefaultSpellAnimationComponent);
			//animationProvider.mapByType(AnimationType.EFFECT, DefaultEffectComponent);
			//
			//animationProvider.defaultAnimation = DefaultAnimationComponent;
			//
			//loadAnimationFromEmbedClass(AnimationComponentsEmbeds);
			//
			//loadFromEmbedClass(AnimationEmbeds);
			//loadFromEmbedClass(UnitAnimationEmbeds);
			//loadFromEmbedClass(BuildingAnimationEmbeds);
			//loadFromEmbedClass(SpellAnimationEmbeds);
			//loadFromEmbedClass(EffectAnimationEmbeds);
		}
		
		private function loadAnimationFromEmbedClass(embed:Class):void
		{
			var list:Vector.<Constant> = ClassType.getClassType(embed).constants;
			for each (var item:Constant in list)
			{
				animationProvider.map(item.name, embed[item.name]);
			}
		}
		
		private function loadFromEmbedClass(embed:Class):void
		{
			var list:Vector.<Constant> = ClassType.getClassType(embed).constants;
			for each (var item:Constant in list)
			{
				layerFactory.map(item.name, parser.parse(embed[item.name]));
			}
		}
	}

}