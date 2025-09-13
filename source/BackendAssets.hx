import flixel.FlxG;
import flixel.group.FlxSpriteGroup;

class BackendAssets
{
    static public var my = 'assets/fonts/my.ttf';
    static public var ru = 'assets/fonts/ots.ttf';

    static public function isFile(filename:String,type:String):Bool 
    {
    if (filename == null) return false;
    return StringTools.endsWith(filename.toLowerCase(), '.$type');
    }
}