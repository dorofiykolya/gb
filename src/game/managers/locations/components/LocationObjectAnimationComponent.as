package game.managers.locations.components
{
	import common.injection.IInjector;
	import game.managers.locations.animations.LocationAnimationComponent;
	import game.modules.animations.AnimationComponent;
	import game.modules.animations.AnimationFactory;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationObjectAnimationComponent extends LocationObjectComponent
	{
		[Inject]
		public var animationFactory:AnimationFactory;
		[Inject]
		public var inject:IInjector;
		
		private var _animationComponent:LocationAnimationComponent;
		
		public function LocationObjectAnimationComponent()
		{
		
		}
		
		public final function setup(source:String):void
		{
			unsetup();
			
			_animationComponent = animationFactory.instantiate(source) as LocationAnimationComponent;
			inject.inject(_animationComponent);
			
			_animationComponent.source = source;
			
			addComponent(_animationComponent);
			
			onSetup();
		}
		
		public final function unsetup():void
		{
			if (_animationComponent != null)
			{
				_animationComponent.dispose();
				_animationComponent = null;
			}
			onUnsetup();
		}
		
		override protected function onDispose():void 
		{
			unsetup();
			super.onDispose();
		}
		
		protected function onSetup():void
		{
		
		}
		
		protected function onUnsetup():void
		{
			
		}
	
	}

}