package game.managers.navigations
{
	import game.modules.windows.CurrentPathWindow;
	import game.modules.windows.WindowId;
	import game.modules.windows.WindowType;
    import flash.display.Stage;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
	import game.modules.consoles.ConsoleManager;
	import game.modules.net.UINetLoggerManager;
	import game.modules.windows.WindowsManager;
	import game.mvc.view.ViewContext;
	import game.view.GameWindowId;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class NavigationManager
    {
        private var _nativeStage:Stage;
        private var _windowsManager:WindowsManager;
		private var _viewContext:ViewContext;
		private var _uiNetLoggerManager:UINetLoggerManager;
		private var _consoleManager:ConsoleManager;
        
        public function NavigationManager(nativeStage:Stage, windowsManager:WindowsManager, viewContext:ViewContext, uiNetLoggerManager:UINetLoggerManager, consoleManager:ConsoleManager)
        {
			_consoleManager = consoleManager;
			_uiNetLoggerManager = uiNetLoggerManager;
            _viewContext = viewContext;
			_windowsManager = windowsManager;
            _nativeStage = nativeStage;
            _nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }
        
        private function onKeyDown(e:KeyboardEvent):void
        {
            if (Object(Keyboard).hasOwnProperty("BACK") && e.keyCode == Keyboard["BACK"])
            {
				e.preventDefault();
				e.stopImmediatePropagation();
				if (_viewContext.initialized)
                {
					navigate();
				}
            }
        }
        
        public function navigate():void
        {
			if (_uiNetLoggerManager.opened)
			{
				_uiNetLoggerManager.close();
			}
			else if (_consoleManager.opened)
			{
				_consoleManager.close();
			}
			else if (_windowsManager.getCurrentId(WindowType.POPUP) == GameWindowId.CONNECTION_LOST)
			{
				_windowsManager.open(GameWindowId.EXIT, null, new CurrentPathWindow(WindowType.POPUP));
			}
			else if (_windowsManager.getCurrentId(WindowType.POPUP) == GameWindowId.EXIT)
			{
				_windowsManager.close(GameWindowId.EXIT);
			}
            else if (_windowsManager.hasQueue(WindowType.POPUP))
            {
                _windowsManager.backByType(WindowType.POPUP);
            }
			else if (_windowsManager.hasQueue(WindowType.WINDOWS))
			{
				_windowsManager.backByType(WindowType.WINDOWS);
			}
			else
			{
				_windowsManager.open(GameWindowId.EXIT);
			}
        }
    
    }

}