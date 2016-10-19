package game.managers.locations.commands
{
	import common.system.utils.ObjectUtils;
	import game.managers.battles.engine.OutputEvent;
	import game.managers.battles.output.MannaChangeEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationMannaChangeCommand extends LocationCommand
	{
		
		public function LocationMannaChangeCommand()
		{
			super(MannaChangeEvent);
		}
		
		override public function execute(evt:OutputEvent):void
		{
			var data:MannaChangeEvent = evt as MannaChangeEvent;
			//trace(ObjectUtils.toString(data));
		}
	
	}

}