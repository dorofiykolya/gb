package game.flash
{
	import embeds.TTFEmbeds;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;
	import game.modules.preloaders.IPreloaderViewMediator;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PreloaderView extends Sprite implements IPreloaderViewMediator
	{
		//[Embed(source = "../../../../embeds/preloader/preloader.jpg")]
		private static const PRELOADER:Class = Preloader.BACKGROUND_CLASS;
		
		//[Embed(source = "../../../../embeds/preloader/progress.jpg")]
		private static const PROGRESS:Class = Preloader.PROGRESS_CLASS;
		
		private var _bitmap:Bitmap;
		private var _opened:Boolean;
		private var _lastTime:int;
		private var _container:DisplayObjectContainer;
		private var _progress:Bitmap;
		private var _progressWidth:Number = 421.0;
		private var _text:TextField;
		
		public function PreloaderView()
		{
			mouseChildren = false;
			_bitmap = new PRELOADER();
			_bitmap.smoothing = true;
			addChild(_bitmap);
			
			_progress = new PROGRESS();
			_progress.smoothing = true;
			_progress.x = 167;
			_progress.y = 573;
			addChild(_progress);
			
			_text = new TextField();
			_text.width = 420;
			_text.height = 100;
			_text.x = 167;
			_text.y = 575;
			_text.defaultTextFormat = new TextFormat(null, 12, 0xffffff, null, null, null, null, null, TextFormatAlign.CENTER);
			_text.selectable = false;
			_text.mouseEnabled = false;
			_text.antiAliasType = AntiAliasType.ADVANCED;
			_text.cacheAsBitmap = true;
			addChild(_text);
			
			addEventListener(Event.ADDED_TO_STAGE, toStage);
			addEventListener(Event.ENTER_FRAME, onFrame);
			alpha = 1.0;
			
			setProgress(0.25);
		}
		
		private function onFrame(e:Event):void
		{
			var now:int = getTimer();
			if (_lastTime == 0)
			{
				_lastTime = now;
			}
			var diff:Number = (now - _lastTime) / 1000.0;
			var value:Number = alpha;
			var openSeconds:Number = .1;
			var closeSeconds:Number = 2.0;
			_lastTime = now;
			
			if (_opened)
			{
				if (alpha == 0.0)
				{
					if (parent == null)
					{
						_container.addChild(this);
						removeEventListener(Event.ENTER_FRAME, onFrame);
					}
				}
				if (alpha != 1.0)
				{
					value += diff / openSeconds;
					alpha = Math.min(value, 1.0);
				}
			}
			else
			{
				if (alpha != 0.0)
				{
					value -= diff / closeSeconds;
					alpha = Math.max(value, 0.0);
					if (alpha == 0.0)
					{
						if (parent != null)
						{
							parent.removeChild(this);
							removeEventListener(Event.ENTER_FRAME, onFrame);
						}
					}
				}
			}
		}
		
		/* INTERFACE game.modules.preloaders.IPreloaderViewMediator */
		
		public function getView():DisplayObject
		{
			return this;
		}
		
		public function setProgress(ratio:Number):void
		{
			_progress.width = _progressWidth * ratio;
			_text.text = Number(ratio * 100.0).toFixed(3) + "%";
		}
		
		public function setMessage(message:String):void
		{
		
		}
		
		/* INTERFACE game.modules.preloaders.IPreloaderViewMediator */
		
		public function close():void
		{
			if (_opened)
			{
				_opened = false;
				addEventListener(Event.ENTER_FRAME, onFrame);
			}
		}
		
		public function open():void
		{
			if (!_opened)
			{
				_opened = true;
				if (parent == null)
				{
					_container.addChild(this);
				}
				addEventListener(Event.ENTER_FRAME, onFrame);
			}
		}
		
		/* INTERFACE game.modules.preloaders.IPreloaderViewMediator */
		
		public function setContainer(root:DisplayObjectContainer):void
		{
			_container = root;
		}
		
		private function toStage(e:Event):void
		{
			onResize();
			stage.addEventListener(Event.RESIZE, onResize);
			stage.loaderInfo.addEventListener(Event.COMPLETE, onResize);
		}
		
		private function onResize(e:Event = null):void
		{
			if (stage != null)
			{
				scaleX = scaleY = 1;
				scaleX = scaleY = calculateScaleRatioToFill(width, height, stage.stageWidth, stage.stageHeight);
				x = (stage.stageWidth - width) / 2.0;
				y = (stage.stageHeight - height) / 2.0;
			}
		}
		
		public function calculateScaleRatioToFill(originalWidth:Number, originalHeight:Number, targetWidth:Number, targetHeight:Number):Number
		{
			var widthRatio:Number = targetWidth / originalWidth;
			var heightRatio:Number = targetHeight / originalHeight;
			if (widthRatio > heightRatio)
			{
				return widthRatio;
			}
			return heightRatio;
		}
	
	}

}