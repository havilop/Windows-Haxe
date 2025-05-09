import Logon.Logon;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import haxe.Json;
import haxe.Timer;
import sys.FileSystem;
import sys.io.File;
//Well this is the main state of this project//
//u can here find a lot of things//
typedef WindowsMain = {
    var wallpaper:String;
} 
class Windows extends FlxState
{
    var screenLogon:Logon;
    var bg:FlxSprite;
    var o:WindowsMain;

    override function create() {
        super.create();

        FlxG.mouse.visible = true;
        FlxG.mouse.useSystemCursor = true;
        FlxG.autoPause = false;

        if (FileSystem.exists("assets/Windows/mbr.json"))
        {
            try 
            {
                var data = File.getContent("assets/Windows/mbr.json");
                o = Json.parse(data);
            }
        }

        bg = new FlxSprite(0,0,o.wallpaper);
        bg.screenCenter(X);
        add(bg);

        screenLogon = new Logon();
        add(screenLogon);

    }
    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}