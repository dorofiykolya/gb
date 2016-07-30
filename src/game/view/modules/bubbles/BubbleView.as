/**
 * Created by Evgeniy on 10.05.2016.
 */
package game.view.modules.bubbles {
import feathers.display.Scale9Image;

import starling.display.DisplayObject;

import starling.display.Sprite;
import starling.display.SpriteBox;

public class BubbleView extends SpriteBox
{
    private var _bubbleBackground:Scale9Image;
    private var _currentSpriteData:Sprite;
    private var _content:Sprite;
    
    public function BubbleView() {

    }

    public function setContent(content:Sprite):void
    {
        insert(content);
        _content = content;
    }

    public function setBackground(value:DisplayObject):void
    {
        _bubbleBackground = value as Scale9Image;
    }
    
    public function setData(data:Sprite, scale:Number):void
    {
        _currentSpriteData = data;

        if(_bubbleBackground && _currentSpriteData)
        {
            _bubbleBackground.insert(data);
			_bubbleBackground.textureScale = scale;
            _bubbleBackground.height = data.height + 80 * scale;
            _bubbleBackground.width = data.width + 80 * scale;

            _currentSpriteData.x = 40 * scale;
            _currentSpriteData.y = 40 * scale;
        }
    }

    public function clearData():void
    {
        if(_currentSpriteData && _bubbleBackground)
        {
            _bubbleBackground.removeChild(_currentSpriteData);
            _currentSpriteData.dispose();
            _currentSpriteData = null;
        }     
    }

    public function get content():Sprite
    {
        return _content;
    }
  }
}
