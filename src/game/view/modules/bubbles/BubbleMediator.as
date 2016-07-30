package game.view.modules.bubbles
{
	
	import embeds.LayoutEmbeds;
	import embeds.TTFEmbeds;
	import flash.geom.Point;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextLayoutFormat;
	import game.modules.uibuilder.IUIBuilderFactory;
	import game.mvc.view.ILayers;
	import game.view.Content;
	import game.view.LayerIndex;
	import mvc.mediators.IMediator;
	import starling.core.RenderSupport;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.ResizeEvent;
	import starling.extensions.tlfSprite.TLFSprite;
	import starling.extensions.utils.DisplayListUtils;
	
	public class BubbleMediator implements IMediator
	{
		[Inject]
		public var uiBuilder:IUIBuilderFactory;
		[Inject]
		public var layers:ILayers;
		[Inject]
		public var stage:Stage;
		
		private var _view:BubbleView;
		private var _container:Sprite;
		private var _scaleFactor:Number;
		
		private const BUTTOM_PADDING:int = 10;
		private const SIDE_OFFSET:int = 10;
		
		public function BubbleMediator()
		{
		}
		
		public function mediate(target:Object):void
		{
			_view = BubbleView(target);
			_view.setContent(uiBuilder.createByLayout(LayoutEmbeds.RESOURCE_BUBBLE));
			_view.setBackground(DisplayListUtils.getByName(_view.content, "background"));
			
			_container = Sprite(layers.getLayer(LayerIndex.BUBBLE));
			
			stage.addEventListener(ResizeEvent.RESIZE, onResize);
			updateSize();
		}
		
		private function onResize(event:ResizeEvent):void
		{
			close();
			updateSize();
		}
		
		private function updateSize():void
		{
			_scaleFactor = Content.calculateScale(Content.contentWidth, Content.contentHeight, stage.stageWidth, stage.stageHeight);
		}
		
		public function unmediate():void
		{
		}
		
		public function open(target:Object, data:String):void
		{
			_view.clearData();
			_container.insert(_view);
			_view.setData(createContent(data), _scaleFactor);
			validatePosition(target);
		}
		
		public function close():void
		{
			_view.clearData();
			_view.cutFromParent();
		}
		
		public function view():Sprite
		{
			return _view;
		}
		
		private function createContent(data:String):TLFSprite
		{
			var layoutFormat:TextLayoutFormat = new TextLayoutFormat();
			layoutFormat.columnWidth = Math.round((46 / 14) * 150 * _scaleFactor);
			layoutFormat.fontLookup = FontLookup.EMBEDDED_CFF;
			layoutFormat.fontFamily = TTFEmbeds.KautivaCyrillicBold.fontName;
			layoutFormat.fontSize = Math.round(46 * _scaleFactor);
			layoutFormat.color = "#6c4f3f";
			layoutFormat.renderingMode = RenderingMode.CFF;
			layoutFormat.cffHinting = CFFHinting.HORIZONTAL_STEM;
			
			var tlfSprite:TLFSprite = null;
			
			if (isHTMLText(data))
			{
				try
				{
					tlfSprite = TLFSprite.fromHTML(data);
				}
				catch (err:Error)
				{
					
				}
			}
			else
			{
				var textFlow:TextFlow = new TextFlow();
				tlfSprite = new TLFSprite(textFlow);
				tlfSprite.text = data;
			}
			
			if (tlfSprite)
			{
				tlfSprite.apply(layoutFormat);
				tlfSprite.render(new RenderSupport(), 1);
			}
			
			return tlfSprite;
		}
		
		private function isHTMLText(data:String):Boolean
		{
			var index:int = data.search("<");
			return index != -1;
		}
		
		private function validatePosition(target:Object):void
		{
			var convertedPosition:Point = target.localToGlobal(new Point(0, 0));
			
			var scaledItem:Number = target.width * _scaleFactor;
			var xOffset:Number = (scaledItem - _view.width) / 2;
			
			var newX:Number = convertedPosition.x + xOffset;
			var newY:Number = convertedPosition.y + BUTTOM_PADDING + target.height * _scaleFactor;
			
			_view.x = newX;
			_view.y = newY;
			
			validateBubbleSpade();
		}
		
		private function validateBubbleSpade():void
		{
			if (SIDE_OFFSET > _view.x)
			{
				_view.x = SIDE_OFFSET;
			}
			
			if (_view.x + _view.width > stage.stageWidth - SIDE_OFFSET)
			{
				_view.x = stage.stageWidth - _view.width - SIDE_OFFSET;
			}
		}
	}
}
