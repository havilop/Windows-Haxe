package states;

import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.ui.FlxButton;
import haxe.Timer;
import haxe.Json;
import sys.io.File;
import openfl.net.FileReference;
import sys.FileSystem;
import openfl.Lib;
import flixel.group.FlxGroup.FlxTypedGroup;
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
    var bg:FlxSprite;
    var itemsBios:FlxTypedGroup<FlxButton>;
    var itemsBiosName:Array<String> = ["autombr","fastbios"];
    var IsBios:Bool = false;

    function AddStartUI() 
    {
        textMBR = new FlxText(10, FlxG.height - 135,0,"Press ESC to load MBR", 52);
        textMBR.setFormat(null, 52, 0xFFFFFF, "left");
        add(textMBR);

        textBIOS = new FlxText(10, FlxG.height - 60, 0,"Press DEL to BIOS", 52);
        textBIOS.setFormat(null, 52, 0xFFFFFF, "left");
        add(textBIOS);
    }
    function AddBIOSUI() 
    {
        for (num => items in itemsBiosName)
        {
            trace(num);
            var item:FlxButton = createBiosItem(items,0,(num * 135) + 250,function name() {
                if (num == 0) 
                {
                    var first = false;

                    if (first == false) 
                    {
                    var com = new CommandFunction("/autombr true");
                    add(com);
                    Timer.delay(function name() {
                        first = true;
                    },50);
                    }
                    if (first == true)
                    {
                    var com = new CommandFunction("/autombr false");
                    add(com);
                    first = false;
                    }
                }
                if (num == 1)
                {
                    trace("1");
                }
            });
        }
    }
    function createBiosItem(name:String,x:Float,y:Float,?void:Null<()-> Void>) 
    {
        var itemBios:FlxButton = new FlxButton(x,y,name,void);
        itemsBios.add(itemBios);
        return itemBios;
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

        bg = new FlxSprite(0,0,"assets/images/setup/bg.png");
        bg.screenCenter(XY);
        bg.setGraphicSize(FlxG.width,FlxG.height);
        bg.color = 0x0400ff;
        bg.visible = false;
        add(bg);

        itemsBios = new FlxTypedGroup<FlxButton>();
        itemsBios.visible = false;
		add(itemsBios);

        AddBIOSUI();

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
        if (FlxG.keys.justPressed.DELETE)
        {
            IsBios = true;
        }
        if (IsBios == true)
        {
            itemsBios.visible = true;
            FlxG.mouse.visible = true;
            bg.visible = true;

            if (FlxG.keys.justReleased.ESCAPE)
            {
                IsBios = false;
            }
        }
        if (IsBios == false)
        {
             itemsBios.visible = false;
            FlxG.mouse.visible = false;
            bg.visible = false;
        }
    }
}