import SetupState.Settings;
import SetupState.Settings;
import Sys;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.Json;
import haxe.Timer;
import lime.system.System;
import openfl.Lib;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;


typedef BiosSettings = {
      public var autoMBR:Bool;
      var isWindowsInstalled:Bool;
      public var fastBIOS:Bool;
} 

enum BiosColumn {
	reset;
    fast;
	auto;
}

class BIOState extends FlxState 
{
   var cpu:String;
   var gpu:String;
   var o:BiosSettings;
   var bg:FlxSprite;
   var s:Settings;
   var ram:String;
   var notBios:Bool = true;
   var bios:Bool;
   var isreset:Bool;
   var biosIs:Bool = false;
   var allow:Bool = false;
   var autoTextVar:FlxText;
   var autoText:FlxText;
   var delayInt:Int = 2000;
   var fastText:FlxText;
   var fastTextVar:FlxText;
   var isTwoSecond:Bool;
  
   var resetText:FlxText;
   var autoDec:FlxText;
   public static var curColumn:BiosColumn = auto;
override function create() 
    {
        super.create();
        Lib.application.window.title = "Windows 10"; 
        FlxG.mouse.visible = false;
        FlxG.autoPause = false;
        var os = Sys.systemName();
        var output = "";
        if (os == "Windows") { 
             cpu = new Process("wmic", ["cpu", "get", "name"]).stdout.readAll().toString();
             gpu = new Process("wmic", ["path", "win32_VideoController", "get", "name"]).stdout.readAll().toString();
            ram = new Process("wmic", ["OS", "get", "TotalVisibleMemorySize"]).stdout.readAll().toString();

        }
        if (FileSystem.exists("assets/data/settings.json")) 
            {
                try 
                {
                    var data = File.getContent("assets/data/settings.json");
                    o = Json.parse(data);
                    s = Json.parse(data);
                  
                    if (o.fastBIOS == true)
                        {
                            delayInt = 1000;
                            trace("true");
                        }
                        if (o.fastBIOS == false)
                            {
                                delayInt = 2000;
                            }

Timer.delay(function name() {
    trace("2secondAFter");
    isTwoSecond = true;
}, delayInt);


                }
            }
        var infoText = new FlxText(10, 10, FlxG.width - 20, "", 16);
        infoText.setFormat(null, 16, 0xFFFFFF, "left");
        add(infoText);
        var text = new FlxText(10, 100, FlxG.width - 20, '$cpu$gpu$ram', 16);
        text.setFormat(null, 16, 0xFFFFFF, "left");
        add(text);
        var tex = new FlxText(10, 900,0,"Press ESC to load MBR", 52);
        tex.setFormat(null, 52, 0xFFFFFF, "left");
        add(tex);
        var te = new FlxText(10, 1000, 0,"Press DEL to BIOS", 52);
        te.setFormat(null, 52, 0xFFFFFF, "left");
        add(te);
        var osName = System.platformName;
        var osVersion = System.platformVersion;
        var infoString = 
        
            "OS: " + osName + " (VERSION: " + osVersion + ")\n" +
            "RESULATION: " + FlxG.stage.stageWidth + "x" + FlxG.stage.stageHeight + "\n" +
            "HAXEFLIXEL: " + FlxG.VERSION;
            "CPU:" + cpu;
            "GPU:" + gpu;
            "RAM:" + ram;

        infoText.text = infoString;


    }
override function update(elapsed:Float) 
    {
super.update(elapsed);
if (o.autoMBR == true && isTwoSecond == true && biosIs == false)
    {
        Timer.delay(function name() {
            FlxG.switchState(MBRstate.new);
        }, 500);
    }

        

var autoVar = o.autoMBR + "";
var fastVar = o.fastBIOS + "";

if (bios == true && allow == false)
    {
        allow = true;


            bg = new FlxSprite(0,0,"assets/images/setup/bgsetup.png");
            bg.screenCenter(X);
            bg.setGraphicSize(2000,2000);
            add(bg);

            autoText = new FlxText(0,0,0,"AutoMBR Launch",52);
            add(autoText);

            fastText = new FlxText(0,100,0,"FastBios",52);
            add(fastText);

            fastTextVar = new FlxText(0,1000,0,fastVar,52);
            fastTextVar.visible = false;
            add(fastTextVar);

            autoTextVar = new FlxText(0,1000,0,autoVar,52);
            autoTextVar.visible = false;
            add(autoTextVar);

            autoDec = new FlxText(0,900,0,"if AutoMBR Launch true then every launch MBR will be automatically launch",42);
            autoDec.visible = false;
            add(autoDec);

            resetText = new FlxText(0,50,0,"Reset Windows",52);
            add(resetText);
   

    }
if (bios == true) {
    switch (curColumn) 
    {
        case reset:
            autoDec.visible = false;
            fastTextVar.visible = false;
            autoTextVar.visible = false;
            fastText.color = 0xFFFFFF;
            resetText.color = 0xFF0000;
            autoText.color = 0xFFFFFF;
        case auto:
            autoDec.visible = true;
            fastTextVar.visible = false;
            autoTextVar.visible = true;
            autoTextVar.text = autoVar;
            autoText.color = 0xFF0000;
            resetText.color = 0xFFFFFF;
        case fast:
            autoDec.visible = false;
            isreset = false;
            autoTextVar.visible = false;
            fastText.visible = true;
            fastTextVar.text = fastVar;
            fastTextVar.visible = true;
            resetText.color = 0xFFFFFF;
            autoText.color = 0xFFFFFF;
            fastText.color = 0xFF0000;
    }
}
    if (bios == false)
        {
                bg.kill();
                autoText.kill();
                autoTextVar.kill();
                fastText.kill();
                fastTextVar.kill();
                resetText.kill();
                autoDec.kill();
                allow = false;
        }


if (FlxG.keys.justPressed.DELETE)
{
    bios = true;
    biosIs = true;
    notBios = false;
    trace("Pressed Delete");
  
}
if (FlxG.keys.justPressed.ESCAPE && notBios == true)
    {
        FlxG.switchState(MBRstate.new);
      
    }
if (FlxG.keys.justPressed.ESCAPE && notBios == false)
     {
         bios = false;
         biosIs = false;
         notBios = true;
    }
    if (FlxG.keys.justPressed.DOWN && curColumn == auto)
        {
            trace("Pressed DOWN");

            curColumn = reset;
       }
       if (FlxG.keys.justReleased.DOWN && curColumn == reset)
        {
           
isreset = false;
            
       }
       if (FlxG.keys.justPressed.UP && curColumn == reset)
        {
            isreset = true;
            curColumn = auto;
       }
       if (FlxG.keys.justPressed.RIGHT && curColumn == auto)
        {
            trace("asd");
            if (o.autoMBR == false)
            {
                o.autoMBR = true;
                File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
            }
       }
       if (FlxG.keys.justPressed.LEFT && curColumn == auto)
        {
            if (o.autoMBR == false)
            {
                o.autoMBR = true;
                File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
            }
            if (o.autoMBR == true)
                {
                    o.autoMBR = false;
                    File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
                }
       }
       if (FlxG.keys.justPressed.ENTER && curColumn == reset)
        {
           o.isWindowsInstalled = false;
           File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
           LoadState.setLoadingScreen(2000,SetupState.new);
       }
       if (FlxG.keys.justPressed.DOWN && curColumn == reset && isreset == false)
        {
         curColumn = fast;
         trace("fast");
       }
       if (FlxG.keys.justPressed.LEFT && curColumn == fast)
        {
         if (o.fastBIOS == true)
         {
            o.fastBIOS = false;
            File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
         }
       }
       if (FlxG.keys.justPressed.RIGHT && curColumn == fast)
        {
         if (o.fastBIOS == false)
         {
            o.fastBIOS = true;
            File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
         }
       }
       if (FlxG.keys.justPressed.UP && curColumn == fast)
        {
            isreset = true;
         curColumn = reset;
       }
    }
    override function destroy() {
        super.destroy(); // Важно вызывать родительский destroy!
        FlxG.bitmap.clearCache();
    }
}