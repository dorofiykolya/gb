package game.managers.locations.logics
{
	import common.injection.IInjector;
	import common.system.Assert;
	import common.system.ClassType;
	import flash.utils.Dictionary;
	import game.managers.battles.engine.OutputEvent;
	import game.managers.locations.commands.LocationBuildingChangeOwnerCommand;
	import game.managers.locations.commands.LocationBuildingCreateCommand;
	import game.managers.locations.commands.LocationBulletCreateCommand;
	import game.managers.locations.commands.LocationBulletMoveCommand;
	import game.managers.locations.commands.LocationBulletRemoveCommand;
	import game.managers.locations.commands.LocationCommand;
	import game.managers.locations.commands.LocationMannaChangeCommand;
	import game.managers.locations.commands.LocationUnitCreateCommand;
	import game.managers.locations.commands.LocationUnitMoveCommand;
	import game.managers.locations.commands.LocationUnitRemoveCommand;
	import game.managers.locations.commands.LocationUnitsChangeCommand;
	
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
			
			add(new LocationBuildingCreateCommand());
			add(new LocationBulletCreateCommand());
			add(new LocationBulletMoveCommand());
			add(new LocationBulletRemoveCommand());
			add(new LocationMannaChangeCommand());
			add(new LocationUnitCreateCommand());
			add(new LocationUnitRemoveCommand());
			add(new LocationUnitsChangeCommand());
			add(new LocationUnitMoveCommand());
			add(new LocationBuildingChangeOwnerCommand());
		}
		
		public function add(command:LocationCommand):void
		{
			Assert.isTrue(!(command.eventType in _map));
			_map[command.eventType] = command;
		}
		
		public function execute(evt:OutputEvent):void
		{
			var command:LocationCommand = _map[ClassType.getClass(evt)];
			if (command != null)
			{
				Assert.notNull(command);
				injector.inject(command);
				command.execute(evt);
			}
		}
	
	}

}