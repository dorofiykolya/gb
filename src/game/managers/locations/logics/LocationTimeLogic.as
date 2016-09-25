package game.managers.locations.logics
{
	import game.managers.locations.IJuggler;
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationTimeLogic extends LocationLogic implements IAnimatable, IJuggler
	{
		private var _scale:Number;
		private var _juggler:Juggler;
		private var _isPlay:Boolean;
		private var _elapsedTime:Number;
		
		public function LocationTimeLogic()
		{
			super();
		}
		
		override public function initialize():void
		{
			_elapsedTime = 0.0;
			_scale = 1;
			location.juggler.add(this);
		}
		
		public function add(animatable:IAnimatable):void
		{
			_juggler.add(animatable);
		}
		
		public function remove(animatable:IAnimatable):void
		{
			_juggler.remove(animatable);
		}
		
		public function get elapsedTime():Number
		{
			return _elapsedTime;
		}
		
		public function pause():void
		{
			_isPlay = false;
		}
		
		public function play():void
		{
			_isPlay = true;
		}
		
		public function get isPlay():Boolean
		{
			return _isPlay;
		}
		
		/* INTERFACE starling.animation.IAnimatable */
		
		public function advanceTime(time:Number):void
		{
			if (isPlay)
			{
				_juggler.advanceTime(time * scale);
				_elapsedTime += time * scale;
			}
		}
		
		public function get scale():Number
		{
			return _scale;
		}
		
		public function set scale(value:Number):void
		{
			_scale = value;
		}
	
	}

}