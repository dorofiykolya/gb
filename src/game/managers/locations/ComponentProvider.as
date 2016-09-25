package game.managers.locations
{
    import common.system.IDisposable;
    import flash.utils.Dictionary;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class ComponentProvider implements IDisposable
    {
        private var _components:Vector.<ProviderData>;
        private var _map:Dictionary;
        
        public function ComponentProvider()
        {
            _components = new Vector.<ProviderData>();
            _map = new Dictionary();
        }
        
        public function add(componentType:Class, componentApi:Class = null):void
        {
            var provider:ProviderData = new ProviderData(componentType, componentApi);
            _map[componentType] = provider;
            _components[_components.length] = provider;
        }
        
        public function get components():Vector.<ProviderData>
        {
            return _components;
        }
        
        public function getProvider(compoentType:Class):ProviderData 
        {
            return _map[compoentType];
        }
        
        public function get map():Dictionary
        {
            return _map;
        }
        
        /* INTERFACE common.system.IDisposable */
        
        public function dispose():void
        {
            _components.length = 0;
        }
    
    }

}