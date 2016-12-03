package game.managers.records
{
	import common.context.IContext;
	import common.system.utils.ObjectUtils;
	import game.managers.checksum.ChecksumManager;
	import game.modules.storage.StorageManager;
	import game.net.commands.localization.Localization;
	import game.net.commands.initialization.Initialization;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class RecordManager
	{
		public var initialization:Initialization;
		public var localization:Localization;
		
		private var _storage:StorageManager;
		private var _checksum:ChecksumManager;
		
		public function RecordManager(storage:StorageManager, checksum:ChecksumManager)
		{
			_checksum = checksum;
			_storage = storage;
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function load():void
		{
			initialization = ObjectUtils.toType(_storage.map(String(Initialization)).value, Initialization) as Initialization;
			localization = ObjectUtils.toType(_storage.map(String(Localization)).value, Localization) as Localization;
		}
		
		public function saveInitialization(packet:Initialization):void
		{
			_storage.map(String(Initialization)).value = ObjectUtils.toObject(packet);
		}
		
		public function saveLocalization(packet:Localization):void
		{
			_storage.map(String(Localization)).value = ObjectUtils.toObject(packet);
		}
	
	}

}