package game.view.modules.hud
{
	import common.system.ClassType;
	import common.system.utils.ObjectUtils;
	import flash.utils.Dictionary;
	import game.modules.states.ChangeStateEvent;
	import game.modules.states.State;
	import game.modules.states.StateDispatcher;
	import mvc.mediators.IMediatorContext;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StateMediatorManager
	{
		private var _stateDispatcher:StateDispatcher;
		private var _map:Dictionary;
		private var _currentDependencies:Vector.<MediatorStateDependency>;
		private var _mediatorContext:IMediatorContext;
		
		public function StateMediatorManager(stateDispatcher:StateDispatcher, mediatorContext:IMediatorContext)
		{
			_mediatorContext = mediatorContext;
			_stateDispatcher = stateDispatcher;
			_map = new Dictionary();
			_currentDependencies = new Vector.<MediatorStateDependency>();
			_stateDispatcher.addEventListener(ChangeStateEvent.CHANGE, onStateChanged);
		}
		
		public function map(mediator:Class, view:Class, provider:IStateTransitionProvider, ... states):void
		{
			_mediatorContext.injector.inject(provider);
			
			if (states.length == 1)
			{
				if (ClassType.isVector(states[0]) || ClassType.isArray(states[0]))
				{
					states = states[0];
				}
			}
			
			var stateList:Vector.<State> = new Vector.<State>(states.length);
			for each (var item:State in states)
			{
				if (item)
				{
					stateList.push(item);
				}
			}
			
			var dependency:MediatorStateDependency = new MediatorStateDependency();
			dependency.mediator = mediator;
			dependency.view = view;
			dependency.provider = provider;
			dependency.states = stateList;
			addDependency(dependency);
		}
		
		private function onStateChanged(e:ChangeStateEvent):void
		{
			markUnused(e.current);
			removeMarked();
			
			var list:Vector.<MediatorStateDependency> = _map[e.current];
			if (list)
			{
				for each (var newDependency:MediatorStateDependency in list)
				{
					onAddDependency(newDependency);
				}
			}
		}
		
		private function onRemoveDependency(dependency:MediatorStateDependency):void
		{
			dependency.provider.remove();
		}
		
		private function onAddDependency(dependency:MediatorStateDependency):void
		{
			_mediatorContext.getObject(dependency.mediator);
			dependency.provider.add();
		}
		
		private function markUnused(current:State):void
		{
			for each (var dependency:MediatorStateDependency in _currentDependencies)
			{
				var markToRemove:Boolean = true;
				for each (var state:State in dependency.states)
				{
					if (state.isState(current))
					{
						markToRemove = false;
						break;
					}
				}
				dependency.markToRemove = markToRemove;
			}
		}
		
		private function removeMarked():void
		{
			var index:int = -1;
			while ((index = getIndex(_currentDependencies, isMarked)) != -1)
			{
				onRemoveDependency(_currentDependencies[index]);
				fastRemoveAt(_currentDependencies, index);
			}
		}
		
		private function addDependency(value:MediatorStateDependency):void
		{
			for each (var state:State in value.states)
			{
				var list:Vector.<MediatorStateDependency> = _map[state];
				if (list == null)
				{
					list = new Vector.<MediatorStateDependency>();
					_map[state] = list;
				}
				list.push(value);
			}
		}
		
		private function isMarked(value:MediatorStateDependency):Boolean
		{
			return value.markToRemove;
		}
		
		private function getIndex(list:Vector.<MediatorStateDependency>, callBack:Function):int
		{
			for (var i:int = 0; i < list.length; i++)
			{
				if (callBack(list[i]))
				{
					return i;
				}
			}
			return -1;
		}
		
		private function fastRemoveAt(list:Vector.<MediatorStateDependency>, index:int):void
		{
			var last:MediatorStateDependency = list[list.length - 1];
			list[index] = last;
			list.length = list.length - 1;
		}
	
	}

}