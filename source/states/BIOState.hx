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
      var boot:String;
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
    var version = '0.0.2.22.08.2025';
    var autombr:FlxButton;
    var bool:FlxText;
    var installWindows:FlxButton;
    var desc:FlxText;
    var fastboot:FlxButton;
    var isFirst:Bool = false;
    var logo:FlxSprite;
    var screenX:Int = FlxG.width;
    var textChooseBoot:FlxText;
    var buttonON:FlxButton;
    var buttonSSD:FlxButton;
    var buttonUSB:FlxButton;
    var swFirst_buttonON:Bool = false;
    var textONE:FlxText;
    var textTWO:FlxText;
    var textCurrentBoot:FlxText;


    function AddStartUI() 
    {
        textMBR = new FlxText(0, 0,0,"Press ESC to BOOT", screenX == 1400 ? 32 : 52);
        textMBR.setFormat(null, 52, 0xFFFFFF, "left");
        textMBR.screenCenter(XY);
        textMBR.x = screenX == 1400 ? FlxG.width - 400 : FlxG.width - 600;
        textMBR.size = screenX == 1400 ? 32 : 52;
        textMBR.y += 20;
        add(textMBR);
trace(screenX);
        textBIOS = new FlxText(0, 0, 0,"Press DEL to BIOS", screenX == 1400 ? 32 : 52);
        textBIOS.setFormat(null, 52, 0xFFFFFF, "left");
        textBIOS.screenCenter(XY);
        textBIOS.x = screenX == 1400 ? FlxG.width - 400 : FlxG.width - 600;
        textBIOS.y += 100;
        textBIOS.size = screenX == 1400 ? 32 : 52;
        add(textBIOS);

        logo = new FlxSprite(0,0,"assets/images/uefi/logo.png");
        logo.screenCenter(XY);
        logo.x -= 100;
        logo.setGraphicSize(logo.width / 1.1,logo.height / 1.1);
        add(logo);
    }
    function AddBIOSUI() 
    {
        autombr = new FlxButton(85,95,'AutoBoot',function name() {

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

        fastboot = new FlxButton(85,165,'FastBoot',function name() {

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

        installWindows = new FlxButton(85,235,'Install Windows',function name() { LoadState.setLoadingScreen(1000,SetupState.new);});
        installWindows.makeGraphic(200,50,FlxColor.TRANSPARENT);
        installWindows.label.setFormat(BackendAssets.my,35,FlxColor.WHITE,CENTER);
        itemsBios.add(installWindows);

        textChooseBoot = new FlxText(300,95,0,'Choose Boot Priority:',30);
        textChooseBoot.color = FlxColor.WHITE;
        textChooseBoot.font = BackendAssets.my;
        itemsBios.add(textChooseBoot);

        buttonON = new FlxButton(600,95,'',function name() {
            if (swFirst_buttonON == false)
            {
                buttonON.loadGraphic("assets/images/uefi/buttonOFF.png");
                Timer.delay(function name() {
                    swFirst_buttonON = true;
                },10);
            }
            if (swFirst_buttonON == true)
            {
                buttonON.loadGraphic("assets/images/uefi/buttonON.png");
                  Timer.delay(function name() {
                    swFirst_buttonON = false;
                },10);
            }
        });
        buttonON.loadGraphic("assets/images/uefi/buttonON.png");
        buttonON.updateHitbox();
        itemsBios.add(buttonON);

        buttonSSD = new FlxButton( 320, 0,'SSD 126 GB',function name() {
            o.boot = "ssd";
            File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
            swFirst_buttonON = false;
        });
        buttonSSD.label.setFormat(BackendAssets.my, 35,FlxColor.WHITE,CENTER);
        buttonSSD.makeGraphic(200,50,FlxColor.TRANSPARENT);
        itemsBios.add(buttonSSD);

        buttonUSB = new FlxButton(320, 140,'USB 64 GB',function name() {
            o.boot = "usb";
            File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
            swFirst_buttonON = false;
        });
        buttonUSB.label.setFormat(BackendAssets.my, 35,FlxColor.WHITE,CENTER);
        buttonUSB.makeGraphic(200,50,FlxColor.TRANSPARENT);
        itemsBios.add(buttonUSB);

        textONE = new FlxText(300,145,0,"1",30);
        textONE.font = BackendAssets.my;
        itemsBios.add(textONE);

        textCurrentBoot = new FlxText(335,145,0,"0",30);
        textCurrentBoot.font = BackendAssets.my;
        itemsBios.add(textCurrentBoot);

        textTWO = new FlxText(300,190,0,"2",30);
        textTWO.font = BackendAssets.my;
        textTWO.visible = false;
        itemsBios.add(textTWO);

        bool = new FlxText(90,FlxG.height - 100,0,'',40);
        bool.font = BackendAssets.my;
        itemsBios.add(bool);

        desc = new FlxText(90,FlxG.height - 165,0,'',35);
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
          for ( i in itemsBios)
            {
                i.visible = false;
            }
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
                if (o.boot == "ssd")
                {
                    LoadState.setLoadingScreen(1,MBRstate.new);
                }
                if (o.boot == "usb")
                {
                    LoadState.setLoadingScreen(1000,SetupState.new);
                }
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
                 if (o.boot == "ssd")
                {
                    LoadState.setLoadingScreen(1,MBRstate.new);
                }
                if (o.boot == "usb")
                {
                    LoadState.setLoadingScreen(1000,SetupState.new);
                }
            }
        }
        if (FlxG.keys.justPressed.DELETE)
        {
            IsBios = true;
        }
        if (FlxG.keys.justPressed.ONE)
        {
            FlxG.switchState(DebugState.new);
        }
        if (IsBios == true)
        {

            FlxG.mouse.visible = true;
            itemsBios.visible = true;
            bg.visible = true;

            for ( i in itemsBios)
            {
                if (swFirst_buttonON == false)
                {
                    i.visible = true;
                    buttonSSD.visible = false;
                    buttonUSB.visible = false;
                    textTWO.visible = false;
                }
                   if (swFirst_buttonON == true)
                {
                    i.visible = true;
                    buttonSSD.visible = true;
                    buttonUSB.visible = true;
                    textTWO.visible = true;
                    textCurrentBoot.visible = false;
                }
            }

            textCurrentBoot.text = o.boot == "ssd" ? "SSD 126 GB" : o.boot == "usb" ? "USB 64 GB" : "USB 64 GB";
            buttonSSD.y = o.boot == "ssd" ? 140 : o.boot == "usb" ? 185 : 185;
            buttonUSB.y = o.boot == "ssd" ? 185 : o.boot == "usb" ? 140 : 140;

            installWindows.visible = false;
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