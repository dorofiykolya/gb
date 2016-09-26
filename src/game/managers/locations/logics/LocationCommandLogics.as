package game.managers.locations.logics
{
	import common.injection.IInjector;
	import common.system.Assert;
	import common.system.ClassType;
	import flash.utils.Dictionary;
	import game.managers.battles.engine.OutputEvent;
	import game.managers.locations.commands.LocationCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationCommandLogics extends LocationLogic
	{
		[Inject]
		public var injector:IInjector;
		
		private var _map:Dictionary;
		
		public function LocationCommandLogics()
		{
			_map = new Dictionary();
		}
		
		public function add(command:LocationCommand):void
		{
			Assert.isTrue(!(command.eventType in _map));
			_map[command.eventType] = command;
		}
		
		public function execute(evt:OutputEvent):void
		{
			var command:LocationCommand = _map[ClassType.getClass(evt)];
			Assert.notNull(command);
			injector.inject(command);
			command.execute(evt);
		}
	
	}

}