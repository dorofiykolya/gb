package game.managers.locations.logics 
{
	import game.managers.locations.LocationLayerName;
	import game.modules.animations.LayerViewer;
	import game.modules.animations.descriptions.DescriptionType;
	import game.modules.assets.ITextureProvider;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocationTextureLayerFactoryLogic extends LocationLogic
	{
		[Inject]
		public var textureProvider:ITextureProvider;
		
		public function LocationTextureLayerFactoryLogic() 
		{
			
		}
		
		public function getLayer(source:String):LayerViewer
		{
			var textures:Vector.<Texture> = textureProvider.getTextures(source);
			if (textures != null && textures.length != 0)
			{
				var layer:LayerViewer = new LayerViewer(LocationLayerName.OBJECTS);
				var clip:MovieClip = new MovieClip(textures);
				clip.alignPivot();
				layer.add(DescriptionType.CLIP, clip);
				return layer;
			}
			return layer;
		}
	}

}