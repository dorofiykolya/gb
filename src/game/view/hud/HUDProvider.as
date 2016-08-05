package game.view.hud
{
	import game.view.modules.hud.IStateTransitionProvider;
	import mvc.mediators.IMediator;
	import starling.display.Stage;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class HUDProvider implements IStateTransitionProvider
	{
		[Inject]
		public var stage:Stage;
		
		private var _view:HUDView;
		private var _mediator:IMediator;
		
		public function HUDProvider()
		{
			_view = new HUDView(300,300, 0xff0000);
		}
		
		/* INTERFACE game.view.modules.hud.IStateTransitionProvider */
		
		public function remove():void
		{
			stage.removeChild(_view);
		}
		
		public function add():void
		{
			stage.addChild(_view);
		}
		
		public function provide(mediator:Object, expected:Class):void
		{
			_mediator = IMediator(mediator);
			_mediator.mediate(_view);
		}
		
		public function unProvide():void
		{
			_mediator.unmediate();
		}
		
		public function dispose():void
		{
		
		}
	
	}

}