package test
{
	import flash.display.Sprite;
	import test.views.TestView;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TestActorContainer
	{
		private var _list:Vector.<TestView> = new Vector.<TestView>();
		private var _view:TestBattleView;
		
		public function TestActorContainer(testBattleView:TestBattleView)
		{
			_view = testBattleView;
		
		}
		
		public function add(view:TestView):void
		{
			_view.addChild(view);
			_list.push(view);
		}
		
		public function remove(objectId:int):void
		{
			var value:TestView = getById(objectId);
			var index:int = _list.indexOf(value);
			if (index != -1)
			{
				_list.splice(index, 1);
				if (value.parent != null)
				{
					value.parent.removeChild(value);
				}
			}
		}
		
		public function get list():Vector.<TestView>
		{
			return _list;
		}
		
		public function getById(objectId:int):TestView
		{
			for each (var item:TestView in _list)
			{
				if (item.objectId == objectId)
				{
					return item;
				}
			}
			return null;
		}
	
	}

}