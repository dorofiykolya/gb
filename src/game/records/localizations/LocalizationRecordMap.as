package game.records.localizations
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocalizationRecordMap
	{
		private var _byName:Dictionary;
		private var _byLanguage:Dictionary;
		private var _languages:Vector.<LocalizationRecord>;
		
		public function LocalizationRecordMap()
		{
			_byName = new Dictionary();
			_byLanguage = new Dictionary();
		}
		
		public function getByName(name:String):LocalizationRecord
		{
			return _byName[name];
		}
		
		public function getByLanguage(language:String):LocalizationRecord
		{
			return _byLanguage[language];
		}
		
		public function get collection():Vector.<LocalizationRecord>
		{
			return _languages;
		}
		
		public function parse(languages:Vector.<LocalizationRecord>):void
		{
			_languages = languages;
			for each (var item:LocalizationRecord in languages)
			{
				_byName[item.name] = item;
				_byLanguage[item.language] = item;
			}
		}
		
		public function contains(language:String):Boolean
		{
			if (_languages)
			{
				for each (var item:LocalizationRecord in _languages)
				{
					if (item.language == language)
					{
						return true;
					}
				}
			}
			return false;
		}
	
	}

}