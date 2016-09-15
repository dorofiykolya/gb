package test
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import game.managers.battles.output.BulletCreateEvent;
	import test.commands.BuildingAttackCommand;
	import test.commands.BuildingChangeUnitsCommand;
	import test.commands.BuildingCreateCommand;
	import test.commands.BulletCreateCommand;
	import test.commands.BulletMoveCommand;
	import test.commands.BulletRemoveCommand;
	import test.commands.DamageApplyCommand;
	import test.commands.MannaChangeCommand;
	import test.commands.UnitAttachedCommand;
	import test.commands.UnitAttackCommand;
	import test.commands.UnitCreateCommand;
	import test.commands.UnitDieCommand;
	import test.commands.UnitMoveCommand;
	import test.commands.UnitRemoveCommand;
	import test.commands.UnitsChangeCommand;
	import test.views.TestView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TestBattleView extends Sprite
	{
		public var command:TestEventProcessor;
		
		public var buildings:TestActorContainer;
		public var units:TestActorContainer;
		public var bullets:TestActorContainer;
		
		public var playersManna:Dictionary = new Dictionary();
		
		public function TestBattleView()
		{
			command = new TestEventProcessor(this);
			buildings = new TestActorContainer(this);
			units = new TestActorContainer(this);
			bullets = new TestActorContainer(this);
			
			command.map(new BuildingCreateCommand());
			command.map(new BuildingAttackCommand());
			command.map(new BulletMoveCommand());
			command.map(new DamageApplyCommand());
			command.map(new MannaChangeCommand());
			command.map(new UnitAttachedCommand());
			command.map(new UnitAttackCommand());
			command.map(new UnitDieCommand());
			command.map(new UnitMoveCommand());
			command.map(new UnitsChangeCommand());
			command.map(new BulletCreateCommand());
			command.map(new BulletRemoveCommand());
			command.map(new UnitCreateCommand());
			command.map(new UnitRemoveCommand());
			command.map(new BuildingChangeUnitsCommand());
			command.map(new UnitsChangeCommand());
		}
		
		public function setManna(ownerId:int, value:Number):void
		{
			playersManna[ownerId] = value;
		}
		
		public function getById(objectId:int):TestView
		{
			for each (var item:TestActorContainer in new <TestActorContainer>[buildings, units, bullets])
			{
				var view:TestView = item.getById(objectId);
				if (view)
				{
					return view;
				}
			}
			return null;
		}
	
	}

}