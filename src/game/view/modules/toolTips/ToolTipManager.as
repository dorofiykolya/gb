package game.view.modules.toolTips
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import mvc.mediators.IMediatorContext;
	import starling.display.DisplayObject;
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.filters.FragmentFilter;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ToolTipManager implements IToolTipBinder
	{
		[Inject]
		public var stage:starling.display.Stage;
		[Inject]
		public var nativeStage:flash.display.Stage;
		[Inject]
		public var mediatorContext:IMediatorContext;
		
		private var _lastGlobalY:Number;
		private var _lastGlobalX:Number;
		private var _lastTarget:DisplayObject;
		private var _map:Dictionary;
		private var _info:ToolTipInfo;
		private var _mediator:ToolTipMediator;
		private var _filter:BlurFilter;
		
		public function ToolTipManager()
		{
			_map = new Dictionary();
		}
		
		public function bind(target:DisplayObject, localizeKey:String = null, format:Function = null, everyFrame:Boolean = false, highLight:Boolean = true, highLightColor:uint = 0xffffff):void
		{
			_map[target] = new ToolTipInfo(target, localizeKey, format, everyFrame, highLight, highLightColor);
		}
		
		public function startListen():void
		{
			mediatorContext.getObject(ToolTipMediator);
			stage.addEventListener(TouchEvent.TOUCH, onTouchHandler);
			nativeStage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);
		}
		
		private function get mediator():ToolTipMediator
		{
			return _mediator || (_mediator = ToolTipMediator(mediatorContext.getObject(ToolTipMediator)));
		}
		
		private function open(target:DisplayObject, x:Number, y:Number):void
		{
			_info = _map[target];
			if (_info && _info.highLight)
			{
				highLightTarget(_info.highLightColor);
			}
			if (_info && _info.localizationKey)
			{
				mediator.open(_info);
				update(x, y);
			}
			else
			{
				close();
			}
		}
		
		private function close():void
		{
			mediator.close();
			_info = null;
		}
		
		private function hasToolTip(target:DisplayObject):Boolean
		{
			return true || target in _map;
		}
		
		private function update(x:Number, y:Number):void
		{
			mediator.move(x, y);
		}
		
		private function onMouseLeave(e:flash.events.Event):void
		{
			close();
		}
		
		private function unHighLightPreviousTarget():void
		{
			if (_lastTarget && _lastTarget != stage && _lastTarget.filter)
			{
				_lastTarget.filter = null;
				_lastTarget = null;
			}
		}
		
		private function highLightTarget(color:uint):void
		{
			if (_lastTarget != stage && _lastTarget in _map)
			{
				if (_filter == null)
				{
					_filter = BlurFilter.createGlow(0xffffff, 1, 5, 1);
				}
				_filter.setUniformColor(true, color);
				_lastTarget.filter = _filter;
			}
		}
		
		private function onTouchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.HOVER);
			if (touch == null)
			{
				return;
			}
			_lastGlobalX = touch.globalX;
			_lastGlobalY = touch.globalY;
			var target:DisplayObject = touch.target;
			if (target == _lastTarget)
			{
				update(_lastGlobalX, _lastGlobalY);
				return;
			}
			unHighLightPreviousTarget();
			_lastTarget = target;
			while (target != null)
			{
				if (hasToolTip(target))
				{
					open(target, _lastGlobalX, _lastGlobalY);
					return;
				}
				target = target.parent;
				if (target == stage)
				{
					close();
					return;
				}
			}
			close();
		}
	
	}

}