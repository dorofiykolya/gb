package game.managers.supersonic
{

	import common.context.IContext;
	import common.context.extensions.IExtension;

	/**
	 * @author Evgeniy on 6/9/2016.
	 */
	public class SupersonicExtension implements IExtension
	{

		[Inject]
		public function extend(context:IContext):void
		{
			CONFIG::ANDROID
			{
				import com.supersonic.adobeair.Supersonic;

				Supersonic.instance.reportAppStarted();
				trace("Supersonic reportAppStarted");
			}
		}
	}
}
