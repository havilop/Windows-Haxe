package states;

import haxe.Timer;
import haxe.Json;
import sys.io.File;
import openfl.net.FileReference;
import sys.FileSystem;
import openfl.Lib;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;

typedef BiosSettings = {
      var autoMBR:Bool;
      var isWindowsInstalled:Bool;
      var fastBIOS:Bool;
      var console:Bool;
} 

class BIOState extends FlxState
{
    var textMBR:FlxText;
    var textBIOS:FlxText;
    var o:BiosSettings;
    var IsBootReady:Bool;
    var TimeDelay:Int;
    var IsBios:Bool = false;

    public function AddStartUI() 
    {
        textMBR = new FlxText(10, FlxG.height - 135,0,"Press ESC to load MBR", 52);
        textMBR.setFormat(null, 52, 0xFFFFFF, "left");
        add(textMBR);

        textBIOS = new FlxText(10, FlxG.height - 60, 0,"Press DEL to BIOS", 52);
        textBIOS.setFormat(null, 52, 0xFFFFFF, "left");
        add(textBIOS);
    }
    public function AddBIOSUI() 
    {
        
    }
    override function create() 
    {
        super.create();

        FlxG.sound.volumeDownKeys = null;
        FlxG.sound.muteKeys = null;
        FlxG.sound.volumeUpKeys = null;
        Lib.application.window.title = "Windows 10"; 
        FlxG.mouse.visible = false;
        FlxG.autoPause = false;

        AddStartUI();
        
        if (FileSystem.exists("assets/data/settings.json")) 
        {
            var data = File.getContent("assets/data/settings.json");
            o = Json.parse(data);
        }

        if (o.fastBIOS == true)
        {
            TimeDelay = 1000;
        }

        if (o.fastBIOS == false)
        {
            TimeDelay = 2000;
        }

        Timer.delay(function name() 
        {
            IsBootReady = true;
        },TimeDelay);

    }
    override function update(elapsed:Float) 
    {
        super.update(elapsed);

        if (o.autoMBR == true && IsBootReady == true && IsBios == false)
        {
            if (o.console == true)
            {
                LoadState.setLoadingScreen(1,Console.new);
            }
            if (o.console == false)
            {
                LoadState.setLoadingScreen(1,MBRstate.new);
            }
        }

        if (FlxG.keys.justPressed.ESCAPE && IsBios == false)
        {
            if (o.console == true)
            {
                LoadState.setLoadingScreen(1,Console.new);
            }
            if (o.console == false)
            {
                LoadState.setLoadingScreen(1,MBRstate.new);
            }
        }
    }
}