package game.managers.battles.engine
{
	import common.composite.Entity;
	import game.managers.battles.actions.BattleStartAction;
	import game.managers.battles.engine.BattleOutput;
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
			
			_context = new BattleContext();
			_context._configuration = _configuration;
			_context._battleEngine = this;
			
			_state = new BattleState(_configuration);
			_actionQueue = new BattleActionQueue(_configuration);
			_processor = new BattleEngineProcessor(_configuration, commandsProvider);
			_actionEngine = new BattleActionEngine(_actionQueue);
			_actors = new BattleActors(this);
			_players = new BattlePlayers(_configuration, this);
			_output = new BattleOutput();
			_modules = new BattleModulesProcessor(_context, modulesProvider);
			
			_context._actors = _actors;
			_context._state = _state;
			_context._players = _players;
			_context._output = _output;
			
			_actionEngine.enqueue(new BattleStartAction());
		}
		
		public function get context():BattleContext
		{
			return _context;
		}
		
		public function get players():BattlePlayers
		{
			return _players;
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
			var currentTick:int = _state.tick;
			while (++currentTick < tick)
			{
				_state.updateTick(currentTick);
				_modules.preTick(_context, currentTick, _state.deltaTick);
				var currentAction:BattleAction;
				if (!_state.isFinished && _actionQueue.count > 0 && (currentAction = _actionQueue.peek()).tick < currentTick)
				{
					_actionQueue.dequeue();
					_processor.execute(currentAction, _context);
				}
				_modules.postTick(_context, currentTick, _state.deltaTick);
				if (_state.isFinished)
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