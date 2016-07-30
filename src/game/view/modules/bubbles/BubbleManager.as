package game.view.modules.bubbles
{
	import game.modules.sounds.Channel;
	import game.modules.sounds.SoundManager;
	import game.mvc.view.controllers.TouchController;
	import game.mvc.view.controllers.TouchControllerEvent;
	import mvc.mediators.IMediatorContext;
	import starling.core.Starling;
	import starling.events.Touch;
	
	public class BubbleManager
	{
		private var _mediatorContext:IMediatorContext;
		private var _touchController:TouchController;
		private var _soundManager:SoundManager;
		
		public function BubbleManager(mediatorContext:IMediatorContext, soundManager:SoundManager)
		{
			_soundManager = soundManager;
			_mediatorContext = mediatorContext;
		}
		
		public function show(object:Object, data:String):void
		{
			mediator.open(object, data);
			
			if (_touchController)
			{
				_touchController.removeEventListener(TouchControllerEvent.DOWN, onClickPastPopup);
				_touchController = null;
			}
			
			_touchController = new TouchController(Starling.current.stage);
			_touchController.addEventListener(TouchControllerEvent.DOWN, onClickPastPopup);
		}
		
		public function hide():void
		{
			mediator.close();
			//_soundManager.getChannel(Channel.FX).play(Sounds.SOUND_SELECT_ITEM);
		}
		
		private function get mediator():BubbleMediator
		{
			return _mediatorContext.getObject(BubbleMediator) as BubbleMediator;
		}
		
		private function onClickPastPopup(event:TouchControllerEvent):void
		{
			var touch:Touch = event.getTouch(mediator.view());
			
			if (touch)
			{
				if (touch.isTouching(mediator.view()))
				{
					return
				}
				
			}
			
			if (_touchController)
			{
				_touchController.removeEventListener(TouchControllerEvent.DOWN, onClickPastPopup);
				_touchController = null;
			}
			
			hide();
		}
	}
}
