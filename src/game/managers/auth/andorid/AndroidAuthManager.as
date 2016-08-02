package game.managers.auth.andorid
{
	import com.freshplanet.ane.AirDeviceId;
	import game.managers.auth.AuthFileManager;
	import game.managers.auth.IDeviceAuthManager;
	import game.modules.logs.ILogger;
	import game.net.ServerRequest;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AndroidAuthManager implements IDeviceAuthManager
	{
		[Inject]
		public var request:ServerRequest;
		[Inject]
		public var logger:ILogger;
		
		private var _file:AuthFileManager;
		
		public function AndroidAuthManager()
		{
			_file = new AuthFileManager(AndroidData);
		}
		
		/* INTERFACE game.managers.auth.IDeviceAuthManager */
		
		public function auth():void
		{
			try
			{
				var deviceId:String = AirDeviceId.getInstance().getID(null);
				logger.note("deviceId: " + deviceId);
				request.authByAndroid(deviceId);
			}
			catch (e:Error)
			{
				logger.error("[game.managers.auth.andorid.AndroidAuthManager][auth]", e);
			}
		}
	
	}

}