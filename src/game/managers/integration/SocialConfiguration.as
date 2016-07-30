package game.managers.integration
{
	import common.context.IContext;
	import flash.display.Stage;
	import game.managers.auth.AuthManager;
	import game.managers.integration.fb.FBSocialService;
	import game.managers.integration.mailru.MailRuService;
	import game.managers.integration.ok.OKSocialService;
	import game.managers.integration.vk.VKSocialService;
	import integration.DefaultSocialService;
	import integration.ISocialService;
	import integration.SocialType;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author Mike Silanin
	 */
	public class SocialConfiguration implements IConfigurable
	{
		[Inject]
		public var authManager:AuthManager;
		
		[Inject]
		public var socialManager:SocialManager;
		[Inject]
		public var stage:Stage;
		
		[Inject]
		public var defaultService:DefaultSocialService;
		[Inject]
		public var vkService:VKSocialService;
		[Inject]
		public var okService:OKSocialService;
		[Inject]
		public var fbService:FBSocialService;
		[Inject]
		public var mrService:MailRuService;
		
		public function config(context:IContext):void
		{
			socialManager.map(defaultService, SocialType.NONE);
			socialManager.map(defaultService, SocialType.DEFAULT);
			socialManager.map(vkService, SocialType.VKONTAKTE);
			socialManager.map(okService, SocialType.ODNOKLASSNIKI);
			socialManager.map(fbService, SocialType.FACEBOOK);
			socialManager.map(mrService, SocialType.MAILRU);
			
			//var parameters:Object = stage.loaderInfo.parameters;
			var socialId:int = authManager.browserSocialType;
			socialManager.select(socialId);
		}
	}

}