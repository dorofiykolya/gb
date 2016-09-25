package game.managers.locations
{
	import starling.animation.IAnimatable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IJuggler
	{
		function add(animatable:IAnimatable):void;
		function remove(animatable:IAnimatable):void;
	}

}