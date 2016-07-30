package game.view.modules.waiting
{
	import starling.extensions.utils.DisplayListUtils;
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.display.SpriteBox;
	import starling.events.Event;
	
	[Event(name="complete", type="starling.events.Event")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WaitingTimer extends SpriteBox
	{
		public static const FADE_IN_TIME:Number = 1.0;
		public static const FADE_OUT_TIME:Number = 1.0;
		
		private var _progress:MovieClip;
		private var _juggler:Juggler;
		private var _tweenFade:Tween;
		
		public function WaitingTimer(content:Sprite, juggler:Juggler)
		{
			insert(content);
			_juggler = juggler;
			contentWidth = content.width;
			contentHeight = content.height;
			alpha = 0;
			alignPivot();
			_progress = DisplayListUtils.getMovieClip(content, "progress");
			_tweenFade = new Tween(this, 1);
		}
		
		internal function startInternal():void
		{
			_progress.loop = true;
			_juggler.add(_progress);
			fadeIn();
		}
		
		internal function stopInternal():void
		{
			_juggler.remove(_progress);
		}
		
		public function fadeIn():void
		{
			_tweenFade.reset(this, FADE_IN_TIME);
			_tweenFade.fadeTo(1);
			_juggler.add(_tweenFade);
		}
		
		public function fadeOut():void
		{
			_tweenFade.reset(this, FADE_OUT_TIME);
			_tweenFade.fadeTo(0);
			_tweenFade.onComplete = onFadeOutComplete;
			_juggler.add(_tweenFade);
		}
		
		private function onFadeOutComplete():void
		{
			dispatchEventWith(Event.COMPLETE, false, this);
			removeEventListeners(Event.COMPLETE);
		}
		
		public function setProgress(ratio:Number):void
		{
			stopInternal();
			_progress.currentFrame = (_progress.totalTime - 1) * ratio;
		}
	
	}

}