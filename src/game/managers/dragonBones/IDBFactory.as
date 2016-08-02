package game.managers.dragonBones
{
	import dragonBones.Armature;
	import dragonBones.core.IArmature;
	import dragonBones.fast.FastArmature;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IDBFactory
	{
		function buildFastArmature(data:Object):FastArmature;
		function buildArmature(data:Object):Armature;
	}

}