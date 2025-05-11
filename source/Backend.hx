import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
//backend functions///
class Backend
{
    ///this function doesnt work idk whats reason////
    static public function cover(sprite:FlxButton,path1:String,path2:String) {

    var wasOverlappin:Bool = false;
    var isOverlappin = sprite.overlapsPoint(FlxG.mouse.getWorldPosition());
    
    if (wasOverlappin && isOverlappin) {
        trace("doit");
        sprite.loadGraphic(path1);
    }

    if (wasOverlappin && !isOverlappin) {
        sprite.loadGraphic(path2);
    }
    
    wasOverlappin = isOverlappin;
    }
}