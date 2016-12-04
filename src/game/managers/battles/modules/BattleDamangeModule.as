package game.managers.battles.modules
{
	import common.composite.Component;
	import game.managers.battles.actors.bullets.BattleBullet;
	import game.managers.battles.actors.damages.ApplyDamageResult;
	import game.managers.battles.actors.damages.BattleDamage;
	import game.managers.battles.engine.ActorsGroup;
	import game.managers.battles.engine.BattleActorsGroup;
	import game.managers.battles.engine.BattleContext;
	import game.managers.battles.engine.BattleModule;
	import game.managers.battles.output.DamageApplyEvent;
	import game.managers.battles.output.UnitsChangeEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BattleDamangeModule extends BattleModule
	{
		private var _temp:Vector.<Component> = new Vector.<Component>();
		private var _damages:Vector.<ApplyDamageResult> = new Vector.<ApplyDamageResult>();
		
		public function BattleDamangeModule()
		{
		
		}
		
		override public function preTick(context:BattleContext, tick:int, deltaTick:int):void
		{
			_temp.length = 0;
			var actors:BattleActorsGroup = context.actors.damages;
			actors.getComponents(BattleDamage, false, _temp);
			
			for each (var damage:BattleDamage in _temp)
			{
				damage.update(tick, deltaTick);
				if (damage.needApplyDamage)
				{
					_damages.length = 0;
					damage.applyDamage(tick, _damages);
					for each (var damageResult:ApplyDamageResult in _damages) 
					{
						var evt:DamageApplyEvent = context.output.enqueueByFactory(DamageApplyEvent) as DamageApplyEvent;
						evt.tick = tick;
						evt.x = damageResult.x;
						evt.y = damageResult.y;
						evt.z = damageResult.z;
						evt.targetId = damageResult.targetId;
						evt.units = damageResult.units;
						evt.damageId = damageResult.damageObjectId;
						
						var unitsEvt:UnitsChangeEvent = context.output.enqueueByFactory(UnitsChangeEvent) as UnitsChangeEvent;
						unitsEvt.tick = tick;
						unitsEvt.objectId = damageResult.targetId;
						unitsEvt.units = damageResult.units;
					}
				}
				if (damage.needRemove)
				{
					damage.dispose();
				}
			}
		}
	
	}

}