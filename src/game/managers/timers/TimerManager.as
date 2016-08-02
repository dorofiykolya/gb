package game.managers.timers
{
	import common.events.EventDispatcher;
	import flash.utils.getTimer;
	import game.modules.formats.TimeFormat;
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;
	
	[Event(name = "tick", type = "game.managers.timers.TimerEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TimerManager extends EventDispatcher implements IAnimatable
	{
		private var _juggler:Juggler;
		private var _format:TimeFormat;
		private var _args:Array = [];
		
		public function TimerManager(juggler:Juggler, format:TimeFormat)
		{
			_args = [];
			_format = format;
			_juggler = juggler;
			_juggler.add(this);
		}
		
		public function get time():Number
		{
			return getTimer() / 1000.0;
		}
		
		/* INTERFACE starling.animation.IAnimatable */
		
		public function advanceTime(delta:Number):void
		{
			_args[0] = delta;
			_args[1] = time;
			_args.length = 2;
			dispatchEventAs(TimerEvent, TimerEvent.TICK, false, null, _args);
		}
		
		/* DELEGATE game.managers.timers.TimeFormat */
		
		public function format(timeInSeconds:Number):String
		{
			return _format.format(timeInSeconds);
		}
		
		public function formatDays(timeInSeconds:Number, dayLabel1:String = "день", dayLabel234:String = "дня", dayLabel567890:String = "дней"):String
		{
			return _format.formatDays(timeInSeconds, dayLabel1, dayLabel234, dayLabel567890);
		}
		
		public function formatFullTime(timeInSeconds:Number, dayLabel1:String = "день", dayLabel234:String = "дня", dayLabel567890:String = "дней"):String
		{
			return _format.formatFullTime(timeInSeconds, dayLabel1, dayLabel234, dayLabel567890);
		}
		
		public function formatShortTime(timeInSeconds:Number, dayLabel:String, hourLabel:String, minuteLabel:String, secondLabel:String):String
		{
			return _format.formatShortTime(timeInSeconds, dayLabel, hourLabel, minuteLabel, secondLabel);
		}
		
		public function formatWith(timeInSeconds:Number, isDynamic:Boolean = true, withNull:Boolean = true, withSeconds:Boolean = true, withChars:Boolean = true):String
		{
			return _format.formatWith(timeInSeconds, isDynamic, withNull, withSeconds, withChars);
		}
	}
}