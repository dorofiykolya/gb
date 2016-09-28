package game.managers.screens
{
	import common.events.EventDispatcher;
	import common.events.IDispatcher;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import flash.utils.Dictionary;
	import game.mvc.view.ILayers;
	import game.mvc.view.ViewContext;
	import game.view.ContentView;
	import game.view.LayerIndex;
	import mvc.mediators.IMediator;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	[Event(name="screenEvent.change", type="game.managers.screens.ScreenEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ScreenManager extends EventDispatcher
	{
		private var _screenNavigator:ScreenNavigator;
		private var _motionNavigator:ScreenFadeTransitionManager;
		private var _layers:ILayers;
		private var _map:Dictionary;
		private var _mapMediator:Dictionary;
		private var _viewContext:ViewContext;
		private var _dispatcher:IDispatcher;
		private var _previous:String;
		
		public function ScreenManager(layers:ILayers, viewContext:ViewContext, dispatcher:IDispatcher)
		{
			_dispatcher = dispatcher;
			_viewContext = viewContext;
			_map = new Dictionary();
			_mapMediator = new Dictionary();
			
			_layers = layers;
			_screenNavigator = new ScreenNavigator();
			_screenNavigator.addEventListener("transitionComplete", onTransitionComplete);
			_screenNavigator.addEventListener("transitionStart", onTransitionStart);
			
			_motionNavigator = new ScreenFadeTransitionManager(_screenNavigator);
			
			layers.getLayer(LayerIndex.SCREEN).add(_screenNavigator);
		}
		
		private function onTransitionStart(e:Event):void
		{
			_layers.touchable = false;
		}
		
		private function onTransitionComplete(e:Event):void
		{
			_layers.touchable = true;
		}
		
		/* DELEGATE feathers.controls.ScreenNavigator */
		
		public function getScreen(id:String):ScreenNavigatorItem
		{
			return _screenNavigator.getScreen(id);
		}
		
		public function showScreen(id:String, transition:Function = null):IMediator
		{
			var changed:Boolean;
			if (activeScreenID != id)
			{
				_previous = activeScreenID;
				changed = true;
			}
			var result:IMediator = _viewContext.load(_mapMediator[id]);
			_screenNavigator.showScreen(id, transition);
			
			dispatchEventAs(ScreenEvent, ScreenEvent.CHANGE, false, activeScreenID);
			_dispatcher.dispatchEventAs(ScreenEvent, ScreenEvent.CHANGE, false, activeScreenID);
			
			return result;
		}
		
		/* DELEGATE feathers.controls.ScreenNavigator */
		
		public function addScreen(id:String, item:ScreenNavigatorItem):void
		{
			_screenNavigator.addScreen(id, item);
		}
		
		public function get activeScreen():DisplayObject
		{
			return _screenNavigator.activeScreen;
		}
		
		public function get activeScreenID():String
		{
			return _screenNavigator.activeScreenID;
		}
		
		public function anyScreen(...screenIds):Boolean
		{
			for each (var screen:String in screenIds) 
			{
				if (this.activeScreenID == screen)
				{
					return true;
				}
			}
			return false;
		}
		
		public function get isTransitionActive():Boolean
		{
			return _screenNavigator.isTransitionActive;
		}
		
		public function get previousScreenID():String 
		{
			return _previous;
		}
		
		public function map(id:String, view:ContentView, mediator:Class):void
		{
			_map[id] = view;
			_mapMediator[id] = mediator;
			addScreen(id, new ScreenNavigatorItem(view));
		}
		
		public function getView(id:String):ContentView
		{
			return _map[id];
		}
	
	}

}