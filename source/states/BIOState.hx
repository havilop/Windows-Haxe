package states;

import flixel.util.FlxColor;
import flixel.group.FlxGroup;
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
    var IsBios:Bool = false;
    var itemsBios:FlxGroup;
    var version = '0.0.1.01.07.2025';
    var autombr:FlxButton;
    var bool:FlxText;
    var installWindows:FlxButton;
    var desc:FlxText;
    var fastboot:FlxButton;
    var isFirst:Bool = false;

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
        autombr = new FlxButton(185,80,'AutoBoot',function name() {

            if (o.autoMBR == false)
            {
                Timer.delay(function name() {
                o.autoMBR = true;
                File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
                },50);
            }
            if (o.autoMBR == true)
            {
                Timer.delay(function name() {
                o.autoMBR = false;
                File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
                },50);
            }
        });
        autombr.makeGraphic(200,50,FlxColor.TRANSPARENT);
        autombr.label.setFormat(BackendAssets.my,35,FlxColor.WHITE,CENTER);
        itemsBios.add(autombr);

        fastboot = new FlxButton(185,155,'FastBoot',function name() {

            if (o.fastBIOS == false)
            {
                Timer.delay(function name() {
                o.fastBIOS = true;
                File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
                },50);            }
            if (o.fastBIOS == true)
            {
                Timer.delay(function name() {
                o.fastBIOS = false;
                File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
                },50);
            }
        });
        fastboot.makeGraphic(200,50,FlxColor.TRANSPARENT);
        fastboot.label.setFormat(BackendAssets.my,35,FlxColor.WHITE,CENTER);
        itemsBios.add(fastboot);

        installWindows = new FlxButton(185,225,'Install Windows',function name() { o.isWindowsInstalled = false; File.saveContent("assets/data/settings.json", Json.stringify(o, null,"")); LoadState.setLoadingScreen(1000,SetupState.new);});
        installWindows.makeGraphic(200,50,FlxColor.TRANSPARENT);
        installWindows.label.setFormat(BackendAssets.my,35,FlxColor.WHITE,CENTER);
        itemsBios.add(installWindows);

        bool = new FlxText(185,FlxG.height - 200,0,'',40);
        bool.font = BackendAssets.my;
        itemsBios.add(bool);

        desc = new FlxText(185,FlxG.height - 325,0,'',35);
        desc.font = BackendAssets.my;
        itemsBios.add(desc);

        var windowsHaxeText = new FlxText(100,0,0,'Windows Haxe UEFI\nVERSION $version',28);
        windowsHaxeText.font = BackendAssets.my;
        itemsBios.add(windowsHaxeText);
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

        bg = new FlxSprite(0,0,"assets/images/uefi/uefi.png");
        bg.screenCenter(XY);
        bg.setGraphicSize(FlxG.width,FlxG.height);
        bg.visible = false;
        add(bg);
        
        itemsBios = new FlxGroup();
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

            FlxG.mouse.visible = true;
            itemsBios.visible = true;
            bg.visible = true;

            if (FlxG.mouse.overlaps(autombr))
            {
                var o = o.autoMBR + "";
                bool.text = o;
                desc.text = "auto loading boot after 2 seconds";
            }
            if (FlxG.mouse.overlaps(fastboot))
            {
                var o = o.fastBIOS + "";
                bool.text = o;
                desc.text = "if true then boot loading 1 second";
            }
            if (FlxG.keys.justReleased.ESCAPE)
            {
                IsBios = false;
            }
        }
        if (IsBios == false)
        {
            FlxG.mouse.visible = false;
            bg.visible = false;
            itemsBios.visible = false;
        }
    }}