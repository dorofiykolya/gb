package game.commands
{
	import mvc.commands.ICommand;
	import mvc.commands.IEventCommandMap;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class StarlingInitializeContext3DCommand implements ICommand
    {
        [Inject]
        public var command:IEventCommandMap;
        
        public function StarlingInitializeContext3DCommand()
        {
        
        }
        
        /* INTERFACE com.okapp.mvc.commands.ICommand */
        
        public function execute():void
        {
            
            //----------------------------------
            //	ui configuration
            //----------------------------------
            
        }
    }
}