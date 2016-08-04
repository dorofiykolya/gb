package game.managers.animations
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	import game.modules.animations.AnimationProvider;
	import game.modules.animations.AnimationXMLParser;
	import game.modules.animations.IAnimationParser;
	import game.modules.animations.LayerFactory;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AnimationExtension implements IExtension
	{
		
		public function AnimationExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(AnimationConfiguration);
			context.install(LayerFactory);
			context.install(AnimationProvider);
			context.install(new Link(AnimationXMLParser, IAnimationParser));
		}
	
	}

}