package states;

import sys.FileSystem;
import haxe.Json;
import sys.io.File;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import states.BIOState;

typedef X = {
    var OOBE:Bool;
} 
class SetupState extends FlxState
{
    var bg:FlxSprite;
    var window:ModernWindow;
    var currentStage:Int = 1;
    var bgSetup:FlxSprite;
    var logo:FlxSprite;
    var buttonInstall:FlxButton;
    var buttonBack:FlxButton;
    var o:X;


    function AddUI() 
    {
        bgSetup = new FlxSprite(0,0,);
        bgSetup.makeGraphic(1000,650,FlxColor.fromRGB(28,28,28));
        bgSetup.updateHitbox();
        add(bgSetup);

        logo = new FlxSprite(0,0,"assets/images/uefi/logo.png");
        logo.setGraphicSize(logo.width / 2,logo.height / 2);
        logo.updateHitbox();
        add(logo);

        buttonInstall = new FlxButton(0,0,"Install",function name() {
            install();
            currentStage = 2;
        });
        buttonInstall.makeGraphic(100,25,FlxColor.fromRGB(55,55,55));
        buttonInstall.label.setFormat(BackendAssets.my,16,FlxColor.WHITE,CENTER);
        buttonInstall.updateHitbox();
        add(buttonInstall);

        buttonBack = new FlxButton(0,0,null,function name() {
            if (currentStage == 2)
            {
                currentStage = 1;
            }
        });
        buttonBack.loadGraphic("assets/images/back.png");
        buttonBack.updateHitbox();
        buttonBack.visible = false;
        add(buttonBack);
    }
    override function create() {
        super.create();

        var data = File.getContent("assets/data/settings.json");
        o = Json.parse(data);

        FlxG.mouse.visible = true;

        bg = new FlxSprite(0,0,"assets/images/setup/bgsetup.png");
        bg.setGraphicSize(FlxG.width,FlxG.height);
        bg.updateHitbox();
        bg.screenCenter(XY);
        add(bg);

        window = new ModernWindow(1000,"Windows Installer","assets/images/icons/WindowsInstaller.png",function name() {
            AddUI();
        },
        function exit() 
        {
            LoadState.setLoadingScreen(1000,BIOState.new);
        },
        function minus() {
            
        },true);
        window.screenCenter(X);
        window.y -= 250;
        add(window);
    }
    function install() {
					o.OOBE = true;
					File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
					FlxG.switchState(BIOState.new);
					var folderPath = "assets/Windows";
					var filePath = folderPath + "/mbr.json"; 
			
					
					if (!FileSystem.exists(folderPath)) {
						FileSystem.createDirectory(folderPath);
					} else {
					}	
			
					var content = "{ \"bootloader\": \"MBR\", \"curLanguage\": \"en\", \"wallpaper\": \"assets/images/wallpapers/wallpaper.png\", \"FPS\": 60, \"icon\": \"assets/images/user/default.png\", \"autologin\": false }"; // Содержимое JSON
					File.saveContent(filePath, content);
					trace('file: $filePath');
					FileSystem.createDirectory("assets/Windows/applications");
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

        switch (currentStage)
        {
            case 1:
                logo.visible = true;
                buttonInstall.visible = true;
                buttonBack.visible = false;
            case 2:
                logo.visible = false;
                buttonInstall.visible = false;
                buttonBack.visible = true;
        }

        bgSetup.x = window.x;
        bgSetup.y = window.y;

        logo.x = window.x + 50;
        logo.y = window.y + 50;

        buttonInstall.x = window.x + 850;
        buttonInstall.y = window.y + 580;

        buttonBack.x = window.x + 15;
        buttonBack.y = window.y + 30;
    }
}