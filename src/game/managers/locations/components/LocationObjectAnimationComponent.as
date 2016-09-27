package game.managers.locations.components
{
	import common.injection.IInjector;
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
		
		private var _animationComponent:AnimationComponent;
		
		public function LocationObjectAnimationComponent()
		{
		
		}
		
		public function setup(source:String):void
		{
			unsetup();
			
			_animationComponent = animationFactory.instantiate(source);
			addComponent(_animationComponent);
			inject.inject(_animationComponent);
			
			postSetup();
		}
		
		public function unsetup():void
		{
			if (_animationComponent != null)
			{
				_animationComponent.dispose();
				_animationComponent = null;
			}
		}
		
		override protected function onDispose():void 
		{
			unsetup();
			super.onDispose();
		}
		
		protected function postSetup():void
		{
		
		}
	
	}

}