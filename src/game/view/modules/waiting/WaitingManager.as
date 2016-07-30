package game.view.modules.waiting
{
	import embeds.LayoutEmbeds;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import game.modules.uibuilder.IUIBuilderFactory;
	import starling.animation.Juggler;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WaitingManager
	{
		private var _juggler:Juggler;
		private var _uiBuilder:IUIBuilderFactory;
		
		private var _list:Vector.<WaitingTimer>;
		private var _pool:Vector.<WaitingTimer>;
		private var _containerInstances:Dictionary;
		
		public function WaitingManager(uiBuilder:IUIBuilderFactory, juggler:Juggler)
		{
			_uiBuilder = uiBuilder;
			_juggler = juggler;
			
			_containerInstances = new Dictionary();
			
			_list = new Vector.<WaitingTimer>();
			_pool = new Vector.<WaitingTimer>();
		}
		
		public function showProgress(container:Sprite, progress:Number, position:Point = null):void
		{
			if (!(container in _containerInstances))
			{
				showWait(container, position);
			}
			else
			{
				var wait:WaitingTimer = container[_containerInstances];
				wait.setProgress(progress);
			}
		}
		
		public function showWait(container:Sprite, position:Point = null):void
		{
			var wait:WaitingTimer = _containerInstances[container];
			if (!wait)
			{
				wait = getInstance();
				if (position)
				{
					wait.x = position.x;
					wait.y = position.y;
				}
				else
				{
					wait.x = container.width / 2;
					wait.y = container.height / 2;
				}
				container.insert(wait);
				_containerInstances[container] = wait;
			}
			else
			{
				wait.startInternal();
			}
		}
		
		public function hideWait(container:Sprite):void
		{
			var wait:WaitingTimer = _containerInstances[container];
			if (wait)
			{
				wait.addEventListener(Event.COMPLETE, function(evt:Event):void
				{
					delete _containerInstances[container];
					releaseInstance(WaitingTimer(evt.data));
				});
				wait.fadeOut();
			}
		}
		
		public function getInstance():WaitingTimer
		{
			var result:WaitingTimer = _pool.length != 0 ? _pool.pop() : createInstance();
			result.startInternal();
			return result;
		}
		
		public function releaseInstance(value:WaitingTimer):void
		{
			if (value)
			{
				value.cutFromParent();
				value.stopInternal();
				if (_pool.indexOf(value) == -1)
				{
					_pool.push(value);
				}
				var index:int = _list.indexOf(value);
				if (index != -1)
				{
					_list.splice(index, 1);
				}
			}
		}
		
		private function createInstance():WaitingTimer
		{
			return new WaitingTimer(_uiBuilder.createByLayout(LayoutEmbeds.WAITING_TIMER), _juggler);
		}
	
	}

}