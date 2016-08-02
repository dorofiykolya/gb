package game.managers.purchase
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PurchaseExtension implements IExtension
	{
		
		public function PurchaseExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(PurchasesTrackedManager);
			CONFIG::ANDROID
			{
				import game.managers.purchase.android.AndroidPurchase;
				context.install(new Link(AndroidPurchase, IPurchase));
			}
			CONFIG::IOS
			{
				import game.managers.purchase.ios.IOSPurchase;
				context.install(new Link(IOSPurchase, IPurchase));
			}
		}
	
	}

}