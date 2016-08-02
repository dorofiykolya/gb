/**
 * Created by Evgeniy on 23.05.2016.
 */
package game.managers.top {
import common.events.Event;

public class TopEvent extends  Event 
{
    public static const CHANGE:String = "change";
    public static const USERS_CHANGE:String = "users_chage";
    public static const CLAN_CHANGE:String = "clans_chage";
    public static const LOCAL_USERS_CHANGE:String = "local_users_chage";
    public static const LOCAL_CLAN_CHANGE:String = "local_clans_chage";
    public static const USERS_PS_CHANGE:String = "user_ps_change";
    
    public function TopEvent(type:Object, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, data);
    }
}
}
