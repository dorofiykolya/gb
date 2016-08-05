package game.view.modules.hud
{
	import common.context.IContext;
	import game.GameState;
	import game.modules.states.IStateDispatcher;
	import game.view.hud.HUD;
	import game.view.hud.HUDProvider;
	import game.view.hud.HUDView;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class HUDMediatorConfiguration implements IConfigurable
	{
		[Inject]
		public var state:IStateDispatcher;
		
		private var _stateMediator:StateMediatorManager;
		
		public function HUDMediatorConfiguration(stateMediator:StateMediatorManager)
		{
			_stateMediator = stateMediator;
		}
		
		private function map(mediator:Class, view:Class, provider:IStateTransitionProvider, ... states):void
		{
			_stateMediator.map(mediator, view, provider, states);
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void
		{
			map(HUD, HUDView, new HUDProvider(), GameState.INITIALIZATION);
			state.current = GameState.INITIALIZATION;
		}
	
	}

}