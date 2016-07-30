package game.managers.integration
{
	import common.context.extensions.IExtension;
	import common.context.IContext;
	import common.context.links.Link;
	import game.managers.integration.fb.FBSocialService;
	import game.managers.integration.mailru.MailRuService;
	import game.managers.integration.ok.OKSocialService;
	import game.managers.integration.vk.VKSocialService;
	import integration.DefaultSocialService;
	import integration.ISocialService;
	
	/**
	 * @author Mike Silanin
	 */
	public class SocialExtension implements IExtension
	{
		
		public function extend(context:IContext):void
		{
			context.install(DefaultSocialService);
			context.install(VKSocialService);
			context.install(OKSocialService);
			context.install(FBSocialService);
			context.install(MailRuService);
			
			context.install(SocialConfiguration);
			context.install(SocialManager);
			context.install(new Link(SocialManager, ISocialService));
		}
	
	}

}
