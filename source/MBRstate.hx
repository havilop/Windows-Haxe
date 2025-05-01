import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import haxe.Json;
import haxe.Timer;
import sys.FileSystem;
import sys.io.File;

typedef Mbr = {
    var isWindowsInstalled:Bool;
} 

class MBRstate extends FlxState
{
    var o:Mbr;
    var textMBR:FlxText;
    var checkMBRstatus:Bool = false;


    override function create() {
        super.create();

        FlxG.mouse.visible = false;
        FlxG.autoPause = false;
        if (FileSystem.exists("assets/data/settings.json")) 
            {
                try 
                {
                    var data = File.getContent("assets/data/settings.json");
                    o = Json.parse(data);
                }
            }

            textMBR = new FlxText(0,1000,0,"Checking... MBR File",42);
            add(textMBR);
            Timer.delay(function MBRSTATUS() {
                checkMBRstatus = true;
            }, 2000);

   
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

        if (o.isWindowsInstalled == false && checkMBRstatus == true)
            {
                textMBR.text = "MBR File not Found or it corrupdet, Please Install/Reinstall Windows";
            if (FlxG.keys.justPressed.ESCAPE)
            {
                FlxG.switchState(BIOState.new);            
            }
            }
            if (o.isWindowsInstalled == true && checkMBRstatus == true)
                {
                    textMBR.text = "SUccess";
                }
    }
}