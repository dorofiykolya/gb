package game.view.modules.toolTips
{
	import embeds.LayoutEmbeds;
	import game.modules.localizations.ILocalizeBinder;
	import game.modules.uibuilder.IUIBuilderFactory;
	import game.mvc.view.ILayers;
	import game.view.LayerIndex;
	import mvc.mediators.IMediator;
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;
	import starling.display.Stage;
	import starling.events.ResizeEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ToolTipMediator implements IMediator, IAnimatable
	{
		private static const OFFSET:int = 10;
		private static const MIN_WIDTH:int = 60;
		
		[Inject]
		public var layers:ILayers;
		[Inject]
		public var uiBuilder:IUIBuilderFactory;
		[Inject]
		public var stage:Stage;
		[Inject]
		public var localize:ILocalizeBinder;
		[Inject]
		public var juggler:Juggler;
		
		private var _view:TooTipView;
		private var _info:ToolTipInfo;
		
		public function ToolTipMediator()
		{
		
		}
		
		public function mediate(target:Object):void
		{
			_view = TooTipView(target);
			_view.setContent(uiBuilder.createByLayout(LayoutEmbeds.TOOL_TIP));
			_view.resize(stage.stageWidth, stage.stageHeight);
			layers.getLayer(LayerIndex.TOOL_TIP).add(_view);
			
			stage.addEventListener(ResizeEvent.RESIZE, onResize);
			
			close();
		}
		
		private function onResize(e:ResizeEvent):void
		{
			_view.resize(e.width, e.height);
		}
		
		private function update(info:ToolTipInfo):void
		{
			_info = info;
			_view.title = localize.localize(info.localizationKey);
		}
		
		public function unmediate():void
		{
		
		}
		
		public function close():void
		{
			_view.visible = false;
			_info = null;
		}
		
		public function open(info:ToolTipInfo):void
		{
			_view.visible = true;
			update(info);
			if (info.everyFrame)
			{
				juggler.add(this);
			}
		}
		
		public function move(x:Number, y:Number):void
		{
			_view.x = x + OFFSET;
			_view.y = y + OFFSET;
			
			if (x + OFFSET > stage.stageWidth - _view.width)
			{
				_view.x = x - OFFSET - _view.width;
			}
			else if (_view.x + _view.width > stage.stageWidth)
			{
				_view.x = stage.stageWidth - _view.width;
			}
			
			if (y + OFFSET > stage.stageHeight - _view.height)
			{
				_view.y = y - OFFSET - _view.height;
			}
			else if (_view.y + _view.height > stage.stageHeight)
			{
				_view.y = stage.stageHeight - _view.height;
			}
		}
		
		public function advanceTime(time:Number):void
		{
			if (_info && _info.everyFrame)
			{
				update(_info);
			}
			else
			{
				juggler.remove(this);
			}
		}
	
	}

}