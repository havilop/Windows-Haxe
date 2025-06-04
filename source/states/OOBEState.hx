package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIInputText;
import flixel.input.FlxInput;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.Json;
import haxe.Timer;
import sys.FileSystem;
import sys.io.File;
import states.BIOState;
import states.LoadState;
import states.MBRstate;
import states.OOBEState;
import states.SetupState;
import applications.ConsoleApp;
import states.WindowsState;

typedef Classic = {
    var OOBE:Bool;
    var allow:Bool;
    var curLanguage:String;
    var userName:String;
    var password:String;
    var taskbar:String;
} 

class OOBEState extends FlxState
{
    var afterLoading:Bool;
    var allow:Bool;

    var o:Classic;
    var l:Classic;

    var languageText:FlxText;
    var background:FlxSprite;
    var en:FlxButton;
    var ru:FlxButton;
    var isEn:Bool;
    var isRu:Bool;
    var NextButtonLanguage:FlxButton;

    var userText:FlxText;
    var inputUserText:FlxUIInputText;
    var inputPassword:FlxUIInputText;
    var storedPassword:String = "";
    var userButton:FlxButton;
    var storedText:String = "";

    var mainWindows:CustomWindow;

   

    override function create() {
        super.create();
          FlxG.sound.volumeDownKeys = null;
        FlxG.sound.volumeUpKeys = null;
        FlxG.mouse.visible = true;
        FlxG.mouse.useSystemCursor = true;
if (FileSystem.exists("assets/data/settings.json")) 
    {
        try 
        {
            var data = File.getContent("assets/data/settings.json");
            o = Json.parse(data);
        }
    }
if (FileSystem.exists("assets/Windows/mbr.json")) 
        {
            try 
            {
                var data = File.getContent("assets/Windows/mbr.json");
                l = Json.parse(data);
            }
        }
            mainWindows = new CustomWindow(1280,800,"OOBE","assets/images/icons/WindowsInstaller.png", 
            function OnAppear()
            {
                background = new FlxSprite(0,0,"assets/images/setup/bg.png");
                background.setGraphicSize(1280,800);
                background.updateHitbox();
                add(background);

                languageText = new FlxText(0,0,0,"Please, choose your language",45);
                languageText.color = 0x35599C;
                languageText.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
                languageText.text = l.curLanguage == "en" ? "Please, choose your language" : "Пожалуйста, выберите язык";
                add(languageText);

                en = new FlxButton(0,0,"EN/ENGLISH",function name() {
                    en.makeGraphic(150,50, FlxColor.fromRGB(16,156,238,50));
                    en.updateHitbox();

                    ru.makeGraphic(150,50,FlxColor.TRANSPARENT);
				    ru.updateHitbox();

                    isEn = true;
                    isRu = false;
                });
                en.label.setFormat("assets/fonts/my.ttf", 26, 0x35599C, CENTER);
                en.makeGraphic(150,50,0x568CDD);
				en.updateHitbox();
                add(en);

                ru = new FlxButton(0,0,"ru/Русский",function name() {
                    ru.makeGraphic(150,50, FlxColor.fromRGB(16,156,238,50));
                    ru.updateHitbox();

                    en.makeGraphic(150,50,FlxColor.TRANSPARENT);
                    en.updateHitbox();

                    isEn = false;
                    isRu = true;
                });
                ru.label.setFormat("assets/fonts/ots.ttf", 26, 0x35599C, CENTER);
                ru.makeGraphic(150,50,FlxColor.TRANSPARENT);
				ru.updateHitbox();
                add(ru);

                NextButtonLanguage = new FlxButton(0,0,"Next",function name() {
                    if (isEn == true)
                    {
                        l.curLanguage = "en";
                        File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
                        languageText.kill();
                        en.kill();
                        ru.kill();
                        NextButtonLanguage.kill();
                        userText.visible = true;
                        userButton.visible = true;
                        inputUserText.visible = true;
                        inputPassword.visible = true;
                    }
                    if (isRu == true)
                    {
                        l.curLanguage = "ru";
                        File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
                        languageText.kill();
                        en.kill();
                        ru.kill();
                        NextButtonLanguage.kill();
                        userText.visible = true;
                        userButton.visible = true;
                        inputUserText.visible = true;
                        inputPassword.visible = true;
                    }
                });
                NextButtonLanguage.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 26, 0x35599C, CENTER);
                NextButtonLanguage.makeGraphic(150,50,FlxColor.TRANSPARENT);
				NextButtonLanguage.updateHitbox();
                NextButtonLanguage.text = l.curLanguage == "en" ? "Next" : "Далее";
                add(NextButtonLanguage);

               userText = new FlxText(0,0,0,"Please, write name of your user",45);
               userText.color = 0x35599C;
               userText.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
               userText.text = l.curLanguage == "en" ? "Please, write name of your user" : "Пожалуйста, напишите имя для вашей учетной записи";
               userText.visible = false;
                add(userText);

                inputUserText = new FlxUIInputText(100,50,200,"",16);
                inputUserText.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
                inputUserText.visible = false;
                add(inputUserText);

                inputPassword = new FlxUIInputText(100,50,200,"",16);
                inputPassword.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
                inputPassword.visible = false;
                add(inputPassword);

                userButton = new FlxButton(0,0,"Next",function name() {
                    if (storedText != "") {
                    if (!FileSystem.exists("assets/Windows/Users")) {
						FileSystem.createDirectory("assets/Windows/Users");
					} 
                    l.userName = storedText;
                    l.password = storedPassword;
                    l.taskbar = "down";
                    o.OOBE = false;
                    File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
                    File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
                    FileSystem.createDirectory('assets/Windows/Users/$storedText');
                    FileSystem.createDirectory('assets/Windows/Users/$storedText/Desktop');
                    FlxG.switchState(BIOState.new);
                }

                });
                userButton.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 26, 0x35599C, CENTER);
                userButton.makeGraphic(150,50,FlxColor.TRANSPARENT);
				userButton.updateHitbox();
                userButton.visible = false;
                userButton.text = l.curLanguage == "en" ? "Next" : "Далее";
                add(userButton);

            }, function exit() 
            {
                LoadState.setLoadingScreen(1000,BIOState.new);
            }, true);
            mainWindows.screenCenter(XY);
            add(mainWindows);
  
          
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.F10)
            {
            var test = new ConsoleApp();
            add(test);
            }

        background.x = mainWindows.x;
        background.y = mainWindows.y;

        languageText.x = mainWindows.x + 375;
        languageText.y = mainWindows.y + 75;

        en.x = mainWindows.x + 250;
        en.y = mainWindows.y + 250;

        ru.x = mainWindows.x + 400;
        ru.y = mainWindows.y + 250;

        NextButtonLanguage.x = mainWindows.x + 1000;
        NextButtonLanguage.y = mainWindows.y + 650;

        userText.x = mainWindows.x + 125;
        userText.y = mainWindows.y + 75;
        userText.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        userText.text = l.curLanguage == "en" ? "Please, write name of your user" : "Пожалуйста, напишите имя для вашей учетной записи";

        inputUserText.x = mainWindows.x + 125;
        inputUserText.y = mainWindows.y + 150;
        
        inputPassword.x = mainWindows.x + 125;
        inputPassword.y = mainWindows.y + 185;

        userButton.x = mainWindows.x + 1000;
        userButton.y = mainWindows.y + 650;
        userButton.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 26, 0x35599C, CENTER);
        userButton.text = l.curLanguage == "en" ? "Next" : "Далее";

        storedText = inputUserText.text;
        storedPassword = inputPassword.text;
    }
    override function destroy() {
        super.destroy(); // Важно вызывать родительский destroy!
        FlxG.bitmap.clearCache();
        FlxG.bitmap.dumpCache();
    }
}