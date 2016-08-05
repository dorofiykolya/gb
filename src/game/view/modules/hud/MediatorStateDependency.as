package game.view.modules.hud
{
	import game.modules.states.State;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MediatorStateDependency
	{
		public var mediator:Class;
		public var view:Class;
		public var provider:IStateTransitionProvider;
		public var states:Vector.<State>;
		
		public var markToRemove:Boolean;
		
		public function MediatorStateDependency()
		{
		
		}
	
	}

}