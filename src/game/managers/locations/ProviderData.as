package game.managers.locations 
{
	/**
     * ...
     * @author dorofiy.com
     */
    public class ProviderData 
    {
        public var componentType:Class;
        public var componentApi:Class;
        
        public function ProviderData(componentType:Class, componentApi:Class) 
        {
            this.componentType = componentType;
            this.componentApi = componentApi;   
        }
        
    }

}