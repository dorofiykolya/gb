package game.managers.battles.engine
{
	import common.composite.Entity;
	import game.managers.battles.actions.BattleStartAction;
	import game.managers.battles.engine.BattleAction;
	import game.managers.battles.engine.BattleActionEngine;
	import game.managers.battles.engine.BattleActionQueue;
	import game.managers.battles.engine.BattleActors;
	import game.managers.battles.engine.BattleCommandsProvider;
	import game.managers.battles.engine.BattleConfiguration;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.players.BattlePlayers;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleEngine extends Entity
	{
		private var _configuration:BattleConfiguration;
		private var _actionQueue:BattleActionQueue;
		private var _state:BattleState;
		private var _processor:BattleEngineProcessor;
		private var _actionEngine:BattleActionEngine;
		private var _actors:BattleActors;
		private var _context:BattleContext;
		private var _modules:BattleModulesProcessor;
		private var _players:BattlePlayers;
		private var _output:BattleOutput;
		
		public function BattleEngine(config:BattleConfiguration, commandsProvider:BattleCommandsProvider, modulesProvider:BattleModulesProvider)
		{
			_configuration = config;
			
			_state = new BattleState(_configuration);
			_actionQueue = new BattleActionQueue(_configuration);
			_processor = new BattleEngineProcessor(_configuration, commandsProvider);
			_actionEngine = new BattleActionEngine(_actionQueue);
			_actors = new BattleActors(this);
			_players = new BattlePlayers(_configuration, this);
			_output = new BattleOutput();
			_context = new BattleContext(_configuration, this, _actors, _state, _players, _output);
			_modules = new BattleModulesProcessor(_context, modulesProvider);
			
			_actionEngine.enqueue(new BattleStartAction());
		}
		
		public function get output():BattleOutput
		{
			return _output;
		}
		
		public function get configuration():BattleConfiguration
		{
			return _configuration;
		}
		
		public function get state():BattleState
		{
			return _state;
		}
		
		public function get tick():int
		{
			return _state.tick;
		}
		
		public function get actions():BattleActionEngine
		{
			return _actionEngine;
		}
		
		public function fastForward(tick:int):int
		{
			if (_state.isFinished)
			{
				return _state.tick;
			}
			
			var finish:Boolean = false;
			if (tick >= _configuration.maxTicks)
			{
				tick = _configuration.maxTicks;
				finish = true;
			}
			while (true)
			{
				var currentAction:BattleAction;
				if (!_state.isFinished && _actionQueue.count > 0 && (currentAction = _actionQueue.peek()).tick < tick)
				{
					_state.updateTick(currentAction.tick);
					_actionQueue.dequeue();
					_modules.preTick(_context, tick, _state.deltaTick);
					_processor.execute(currentAction, _context);
					_modules.postTick(_context, tick, _state.deltaTick);
				}
				else
				{
					break;
				}
			}
			if (!_state.isFinished)
			{
				_state.updateTick(tick);
				if (finish)
				{
					_state.finishBattle()
				}
			}
			return _state.tick;
		}
	
	}

}