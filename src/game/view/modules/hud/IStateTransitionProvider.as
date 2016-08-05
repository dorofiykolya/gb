package game.view.modules.hud
{
	import mvc.mediators.IMediatorProvider;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IStateTransitionProvider extends IMediatorProvider
	{
		function remove():void;
		function add():void;
	}

}