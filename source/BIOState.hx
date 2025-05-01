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
} 

enum BiosColumn {
	reset;
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
   var biosIs:Bool = false;
   var allow:Bool = false;
   var autoTextVar:FlxText;
   var autoText:FlxText;
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
                  

Timer.delay(function name() {
    trace("2secondAFter");
    isTwoSecond = true;
}, 4000);


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

if (bios == true && allow == false)
    {
        allow = true;


            bg = new FlxSprite(0,0,"assets/images/setup/bgsetup.png");
            bg.screenCenter(X);
            bg.setGraphicSize(2000,2000);
            add(bg);

            autoText = new FlxText(0,0,0,"AutoMBR Launch",52);
            add(autoText);

            

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
            autoTextVar.visible = false;
            resetText.color = 0xFF0000;
            autoText.color = 0xFFFFFF;
        case auto:
            autoDec.visible = true;
            autoTextVar.visible = true;
            autoTextVar.text = autoVar;
            autoText.color = 0xFF0000;
            resetText.color = 0xFFFFFF;
    }
}
    if (bios == false)
        {
                bg.kill();
                autoText.kill();
                autoTextVar.kill();
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
       if (FlxG.keys.justPressed.UP && curColumn == reset)
        {
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
          FlxG.switchState(LoadState.new);
       }
    }
}