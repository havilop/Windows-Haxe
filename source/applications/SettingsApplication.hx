package applications;

import haxe.Timer;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;
import haxe.Json;
import lime.media.WebAudioContext;
import sys.FileSystem;
import sys.io.File;
import states.BIOState;
import states.LoadState;
import states.MBRstate;
import states.OOBEState;
import states.SetupState;
import states.WindowsState;

typedef Setmbr = {
    var curLanguage:String;
    var FPS:Int;
    var wallpaper:String;
    var taskbar:String;
    var icon:String;
    var userName:String;
    var autologin:Bool;
} 

class SettingsApplication extends App
{
    public var currentSection:String;
    var bg:FlxSprite;
    var systemSection:FlxButton;
    var personalizationSection:FlxButton;
    var useraccountSection:FlxButton;
    var textPesonalizationWallpaper:FlxText;
    var wallpaperCURRENT:FlxSprite;
    var textWallpaperCurent:FlxText;
    var window:CustomWindow;
    var l:Setmbr;
    var wal1:FlxButton;
    var wal2:FlxButton;
    var wal3:FlxButton;
    var wal4:FlxButton;
    var back:FlxSprite;
    var textTaskBar:FlxText;
    var textTaskBarChange:FlxText;
    var up:FlxButton;
    var down:FlxButton;
    var textLanguage:FlxText;
    var textLanguageCurrent:FlxText;
    var textLanguageChoose:FlxText;
    var textLanguageChooseRU:FlxButton;
    var textLanguageChooseEN:FlxButton;
    var messageBox:MessageBox;
    var textDisplay:FlxText;
    var textDisplayFPS:FlxText;
    var textDisplayFPSCUR:FlxText;
    var displayBUTTONMINUS:FlxButton;
    var displayBUTTONPLUS:FlxButton;
    var itemsUserAccount:FlxGroup;
    var iconUser:FlxSprite;
    var textUser:FlxText;
    var buttonChangeName:FlxButton;
    var buttonChangePassword:FlxButton;
    var buttonChangeIcon:FlxButton;
    var textAutoLogin:FlxText;
    var buttonAutoLogin:FlxButton;

    
    
    public function AddUI() 
    {
        bg = new FlxSprite(0,0,"assets/images/setup/bg.png");
        bg.screenCenter(XY);
        bg.setGraphicSize(1200,800);
        bg.updateHitbox();
        add(bg);

        back = new FlxSprite(0,0,"assets/images/settings/back.png");
        back.updateHitbox();
        add(back);

        systemSection = new FlxButton(0,0,"", function name() {
            currentSection = "system";
        });
        systemSection.loadGraphic("assets/images/settings/system.png");
        systemSection.updateHitbox();
        systemSection.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 26, 0x000000, CENTER);
        systemSection.text = l.curLanguage == "en" ? "System" : "Система";
        add(systemSection);

        personalizationSection = new FlxButton(0,0,"",function name() {
            currentSection = "personalization";
        });
        personalizationSection.loadGraphic("assets/images/settings/personalization.png");
        personalizationSection.updateHitbox();
        personalizationSection.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 26, 0x000000, CENTER);
        personalizationSection.text = l.curLanguage == "en" ? "Personalization" : "Персонализация";
        add(personalizationSection);

        useraccountSection = new FlxButton(0,0,"",function name() {
            currentSection = "useraccount";
        });
        useraccountSection.loadGraphic("assets/images/settings/useraccount.png");
        useraccountSection.updateHitbox();
        useraccountSection.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 26, 0x000000, CENTER);
        useraccountSection.text = l.curLanguage == "en" ? "User Account" : "Учетная запись";
        add(useraccountSection);

        textPesonalizationWallpaper = new FlxText(0,0,0,"",38);
        textPesonalizationWallpaper.color = 0x35599C;
        textPesonalizationWallpaper.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        textPesonalizationWallpaper.text = l.curLanguage == "en" ? "Wallpaper" : "Обои рабочего стола";
        textPesonalizationWallpaper.visible = false;
        add(textPesonalizationWallpaper);

        wallpaperCURRENT = new FlxSprite(0,0,null);
        wallpaperCURRENT.visible = false;
        add(wallpaperCURRENT);
var cur = l.wallpaper;
       textWallpaperCurent = new FlxText(0,0,0,"",16);
       textWallpaperCurent.color = 0x000000;
       textWallpaperCurent.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
       textWallpaperCurent.text = l.curLanguage == "en" ? 'Current: $cur' : 'Текущий: $cur';
       textWallpaperCurent.visible = false;
        add(textWallpaperCurent);

        wal1 = new FlxButton(0,0,"",function name() {
            WindowsState.bg.loadGraphic("assets/images/wallpapers/wallpaper.png");
            l.wallpaper = "assets/images/wallpapers/wallpaper.png";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        });
        wal1.loadGraphic("assets/images/wallpapers/wallpaper.png");
        wal1.setGraphicSize(50,50);
        wal1.updateHitbox();
        wal1.visible = false;
        add(wal1);

        wal2 = new FlxButton(0,0,"",function name() {
             WindowsState.bg.loadGraphic("assets/images/wallpapers/wallpaper2.png");
            l.wallpaper = "assets/images/wallpapers/wallpaper2.png";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        });
        wal2.loadGraphic("assets/images/wallpapers/wallpaper2.png");
        wal2.setGraphicSize(50,50);
        wal2.updateHitbox();
        wal2.visible = false;
        add(wal2);

        wal3 = new FlxButton(0,0,"",function name() {
             WindowsState.bg.loadGraphic("assets/images/wallpapers/wallpaper3.png");
            l.wallpaper = "assets/images/wallpapers/wallpaper3.png";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        });
        wal3.loadGraphic("assets/images/wallpapers/wallpaper3.png");
        wal3.setGraphicSize(50,50);
        wal3.updateHitbox();
        wal3.visible = false;
        add(wal3);

        wal4 = new FlxButton(0,0,"",function name() {
             WindowsState.bg.loadGraphic("assets/images/wallpapers/wallpaper4.png");
            l.wallpaper = "assets/images/wallpapers/wallpaper4.png";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        });
        wal4.loadGraphic("assets/images/wallpapers/wallpaper4.png");
        wal4.setGraphicSize(50,50);
        wal4.updateHitbox();
        wal4.visible = false;
        add(wal4);

        textTaskBar = new FlxText(0,0,0,"",38);
        textTaskBar.color = 0x35599C;
        textTaskBar.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        textTaskBar.text = l.curLanguage == "en" ? "Task Bar" : "Панель задач";
        textTaskBar.visible = false;
        add(textTaskBar);

        textTaskBarChange = new FlxText(0,0,0,"",24);
        textTaskBarChange.color = 0x000000;
        textTaskBarChange.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        textTaskBarChange.text = l.curLanguage == "en" ? "Taskbar location:" : "Расположение панели задач:";
        textTaskBarChange.visible = false;
        add(textTaskBarChange);

        up = new FlxButton(0,0,"",function name() {
            l.taskbar = "up";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
            WindowsState.taskBar.kill();
            WindowsState.IsReset = true;
        });
        up.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf",16,0x35599C,CENTER);
        up.text = l.curLanguage == "en" ? "UP" : "Вверх";
        up.setGraphicSize(75,20);
        up.makeGraphic(75,20,FlxColor.TRANSPARENT);
        up.updateHitbox();
        up.visible = false;
        add(up);

        down = new FlxButton(0,0,"",function name() {
             l.taskbar = "down";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
            WindowsState.taskBar.kill();
            WindowsState.IsReset = true;
        });
        down.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf",16,0x35599C,CENTER);
        down.text = l.curLanguage == "en" ? "DOWN" : "Вниз";
        down.setGraphicSize(60,20);
        down.makeGraphic(60,20,FlxColor.TRANSPARENT);
        down.updateHitbox();
        down.visible = false;
        add(down);

        textLanguage = new FlxText(0,0,0,"",38);
        textLanguage.color = 0x35599C;
        textLanguage.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        textLanguage.text = l.curLanguage == "en" ? "Language" : "Язык";
        textLanguage.visible = false;
        add(textLanguage);

        var curl = l.curLanguage;

        textLanguageCurrent = new FlxText(0,0,0,"",23);
        textLanguageCurrent.color = 0x000000;
        textLanguageCurrent.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        textLanguageCurrent.text = l.curLanguage == "en" ? 'Current: $curl' : 'Текущий: $curl';
        textLanguageCurrent.visible = false;
        add(textLanguageCurrent);

        textLanguageChoose = new FlxText(0,0,0,"",28);
        textLanguageChoose.color = 0x000000;
        textLanguageChoose.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        textLanguageChoose.text = l.curLanguage == "en" ? 'Choose language' : 'Выбор языка';
        textLanguageChoose.visible = false;
        add(textLanguageChoose);

        textLanguageChooseEN = new FlxButton(0,0,"",function name() {
            AddBoxEN();
        });
        textLanguageChooseEN.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf",16,0xFFFFFF,CENTER);
        textLanguageChooseEN.text = l.curLanguage == "en" ? "English" : "Английский";
        textLanguageChooseEN.makeGraphic(l.curLanguage == "en" ? 90 : 95, l.curLanguage == "en" ? 25 :25,FlxColor.GRAY);
        textLanguageChooseEN.updateHitbox();
        textLanguageChooseEN.visible = false;
        add(textLanguageChooseEN);

        textLanguageChooseRU = new FlxButton(0,0,"",function name() {
            AddBoxRU();
        });
        textLanguageChooseRU.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf",16,0xFFFFFF,CENTER);
        textLanguageChooseRU.text = l.curLanguage == "en" ? "Russian" : "Русский";
        textLanguageChooseRU.setGraphicSize(80,23);
        textLanguageChooseRU.makeGraphic(80,23,FlxColor.GRAY);
        textLanguageChooseRU.updateHitbox();
        textLanguageChooseRU.visible = false;
        add(textLanguageChooseRU);

        textDisplay = new FlxText(0,0,0,"",38);
        textDisplay.color = 0x35599C;
        textDisplay.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        textDisplay.text = l.curLanguage == "en" ? "Display" : "Дисплей";
        textDisplay.visible = false;
        add(textDisplay);

        
        textDisplayFPS = new FlxText(0,0,0,"",28);
        textDisplayFPS.color = 0x000000;
        textDisplayFPS.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        textDisplayFPS.text = l.curLanguage == "en" ? "FPS: " : "FPS: ";
        textDisplayFPS.visible = false;
        add(textDisplayFPS);
          var curf = l.FPS;
        textDisplayFPSCUR = new FlxText(0,0,0,"",28);
        textDisplayFPSCUR.color = 0x000000;
        textDisplayFPSCUR.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        textDisplayFPSCUR.text = l.curLanguage == "en" ? '$curf' : '$curf';
        textDisplayFPSCUR.visible = false;
        add(textDisplayFPSCUR);

        displayBUTTONMINUS = new FlxButton(0,0,"-",minus);
        displayBUTTONMINUS.label.setFormat(null,16,FlxColor.WHITE,CENTER);
        displayBUTTONMINUS.makeGraphic(25,25,FlxColor.GRAY);
        displayBUTTONMINUS.updateHitbox();
        add(displayBUTTONMINUS);

        displayBUTTONPLUS = new FlxButton(0,0,"+",plus);
        displayBUTTONPLUS.label.setFormat(null,16,FlxColor.WHITE,CENTER);
        displayBUTTONPLUS.makeGraphic(25,25,FlxColor.GRAY);
        displayBUTTONPLUS.updateHitbox();
        add(displayBUTTONPLUS);

        itemsUserAccount = new FlxGroup();
        itemsUserAccount.visible = false;
        add(itemsUserAccount);

        iconUser = new FlxSprite(0,0,l.icon);
        iconUser.setGraphicSize(200,200);
        iconUser.updateHitbox();
        itemsUserAccount.add(iconUser);

        textUser = new FlxText(0,0,0,l.userName,40);
        textUser.color = FlxColor.BLACK;
        textUser.font = l.curLanguage == "en" ? BackendAssets.my : l.curLanguage == "ru" ? BackendAssets.ru : BackendAssets.ru;
        itemsUserAccount.add(textUser);

        buttonChangeName = new FlxButton(0,0,l.curLanguage == "en" ? "Change name" : "Изменить имя",function name() {
            
        });
        buttonChangeName.label.setFormat(l.curLanguage == "en" ? BackendAssets.my : BackendAssets.ru,25,0x35599C,LEFT);
        buttonChangeName.makeGraphic(200,30,FlxColor.TRANSPARENT);
        itemsUserAccount.add(buttonChangeName);

        buttonChangePassword = new FlxButton(0,0,l.curLanguage == "en" ? "Change password" : "Изменить пароль",function name() {
            
        });
        buttonChangePassword.label.setFormat(l.curLanguage == "en" ? BackendAssets.my : BackendAssets.ru,25,0x35599C,LEFT);
        buttonChangePassword.makeGraphic(220,30,FlxColor.TRANSPARENT);
        itemsUserAccount.add(buttonChangePassword);

        buttonChangeIcon = new FlxButton(0,0,l.curLanguage == "en" ? "Change icon" : "Изменить иконку",function name() {
            
        });
        buttonChangeIcon.label.setFormat(l.curLanguage == "en" ? BackendAssets.my : BackendAssets.ru,25,0x35599C,LEFT);
        buttonChangeIcon.makeGraphic(220,30,FlxColor.TRANSPARENT);
        itemsUserAccount.add(buttonChangeIcon);

        textAutoLogin = new FlxText(0,0,0,l.curLanguage == "en" ? "Autologin :" : "Автологин :",25);
        textAutoLogin.color = FlxColor.BLACK;
        textAutoLogin.font = l.curLanguage == "en" ? BackendAssets.my : BackendAssets.ru;
        itemsUserAccount.add(textAutoLogin);

        buttonAutoLogin = new FlxButton(0,0,null,function name() {
            if (l.autologin == true)
            {
                Timer.delay(function name() {
                l.autologin = false;
                File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
                 buttonAutoLogin.loadGraphic(l.autologin == false ? "assets/images/buttonoff.png" : l.autologin == true ? "assets/images/buttonon.png" : "assets/images/buttonon.png");
                },50);
            }
             if (l.autologin == false)
            {
                Timer.delay(function name() {
                l.autologin = true;
                File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
                 buttonAutoLogin.loadGraphic(l.autologin == false ? "assets/images/buttonoff.png" : l.autologin == true ? "assets/images/buttonon.png" : "assets/images/buttonon.png");
                },50);
            }
        });
        buttonAutoLogin.loadGraphic(l.autologin == false ? "assets/images/buttonoff.png" : l.autologin == true ? "assets/images/buttonon.png" : "assets/images/buttonon.png");
        buttonAutoLogin.updateHitbox();
        itemsUserAccount.add(buttonAutoLogin);
    }
    public function plus() 
        {
            l.FPS += l.FPS >= 240 ? 0 : l.FPS <= 240 ? 5 : 5;
        FlxG.drawFramerate = l.FPS;
        FlxG.updateFramerate = l.FPS;
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        }
           public function minus() 
        {
            l.FPS -= l.FPS <= 60 ? 0 : l.FPS >= 60 ? 5 : 5;
        FlxG.drawFramerate = l.FPS;
        FlxG.updateFramerate = l.FPS;
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        }
    public function AddBoxRU() 
    {
        messageBox = new MessageBox(l.curLanguage == "en" ? "You need restart your System\nThat language will work right\n\nRestart now?" : "Вы должны перезапустить систему\nчтобы язык работал правильно\n\nПерезагрузить сейчас?",
        function name() 
        {
            l.curLanguage = "ru";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
            LoadState.setLoadingScreen(1000,BIOState.new); 
        }, function name() 
        {
            messageBox.kill();
        });
        add(messageBox);
    }
     public function AddBoxEN() 
    {
        messageBox = new MessageBox(l.curLanguage == "en" ? "You need restart your System\nThat language will work right\n\nRestart now?" : "Вы должны перезапустить систему\nчтобы язык работал правильно\n\nПерезагрузить сейчас?",
        function name() 
        {
            l.curLanguage = "en";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
            LoadState.setLoadingScreen(1000,BIOState.new); 
        },function name() 
        {
            messageBox.kill();
        });
        add(messageBox);
    }
    public function RemoveUI()
    {
        this.kill();
    }
    public function new() 
    {
        super();
        super.taskbar("settings");
    if (FileSystem.exists("assets/Windows/mbr.json"))
        {
            try 
            {
                var data = File.getContent("assets/Windows/mbr.json");
                l = Json.parse(data);
            }
        }

        window = new CustomWindow(1200,800,"Settings","assets/images/icons/null.png",function name() 
        {
            AddUI();
        }, function name() 
        {
            App.listApplications.remove("settings");
            this.updateItems();
            RemoveUI();
        },true);
        window.screenCenter(XY);
        add(window);
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        
        switch(currentSection)
        {
            case "system":
                systemSection.loadGraphic("assets/images/settings/systemCHOOSE.png");
                personalizationSection.loadGraphic("assets/images/settings/personalization.png");
                useraccountSection.loadGraphic("assets/images/settings/useraccount.png");
                textPesonalizationWallpaper.visible = false;
                wallpaperCURRENT.visible = false;
                textWallpaperCurent.visible = false;
                wal1.visible = false;
                wal2.visible = false;
                wal3.visible = false;
                wal4.visible = false;
                textTaskBar.visible = false;
                textTaskBarChange.visible = false;
                down.visible = false;
                up.visible = false;
                textLanguage.visible = true;
                textLanguageCurrent.visible = true;
                textLanguageChoose.visible = true;
                textLanguageChooseEN.visible = true;
                textLanguageChooseRU.visible = true;
                textDisplay.visible = true;
                textDisplayFPS.visible = true;
                textDisplayFPSCUR.visible = true;
                displayBUTTONPLUS.visible = true;
                displayBUTTONMINUS.visible = true;
                var curff = l.FPS;
                textDisplayFPSCUR.text = l.curLanguage == "en" ? '$curff' : '$curff';
                itemsUserAccount.visible = false;
                for (i in itemsUserAccount)
                {
                    i.visible = false;
                }

            case "personalization":
                systemSection.loadGraphic("assets/images/settings/system.png");
                useraccountSection.loadGraphic("assets/images/settings/useraccount.png");
                personalizationSection.loadGraphic("assets/images/settings/personalizationCHOOSE.png");

                textPesonalizationWallpaper.visible = true;

                wallpaperCURRENT.visible = true;

                wallpaperCURRENT.loadGraphic(l.wallpaper);
                wallpaperCURRENT.setGraphicSize(500,250);
                wallpaperCURRENT.updateHitbox();

                textWallpaperCurent.visible = true;
                var curw = l.wallpaper;
                textWallpaperCurent.text = l.curLanguage == "en" ? 'Current: $curw' : 'Текущий: $curw';

                wal1.visible = true;
                wal2.visible = true;
                wal3.visible = true;
                wal4.visible = true;

                textTaskBar.visible = true;
                textTaskBarChange.visible = true;

                down.visible = true;
                up.visible = true;

                textLanguage.visible = false;
                textLanguageCurrent.visible = false;
                textLanguageChoose.visible = false;
                textLanguageChooseEN.visible = false;
                textLanguageChooseRU.visible = false;
                textDisplay.visible = false;
                textDisplayFPS.visible = false;
                textDisplayFPSCUR.visible = false;
                 displayBUTTONPLUS.visible = false;
                displayBUTTONMINUS.visible = false;
                 itemsUserAccount.visible = false;
                for (i in itemsUserAccount)
                {
                    i.visible = false;
                }
            case "useraccount":
                useraccountSection.loadGraphic("assets/images/settings/useraccountChoose.png");
                systemSection.loadGraphic("assets/images/settings/system.png");
                personalizationSection.loadGraphic("assets/images/settings/personalization.png");

                textPesonalizationWallpaper.visible = false;
                wallpaperCURRENT.visible = false;
                textWallpaperCurent.visible = false;
                wal1.visible = false;
                wal2.visible = false;
                wal3.visible = false;
                wal4.visible = false;
                textTaskBar.visible = false;
                textTaskBarChange.visible = false;
                down.visible = false;
                up.visible = false;
                textLanguage.visible = false;
                textLanguageCurrent.visible = false;
                textLanguageChoose.visible = false;
                textLanguageChooseEN.visible = false;
                textLanguageChooseRU.visible = false;
                textDisplay.visible = false;
                textDisplayFPS.visible = false;
                textDisplayFPSCUR.visible = false;
                 displayBUTTONPLUS.visible = false;
                displayBUTTONMINUS.visible = false;
                itemsUserAccount.visible = true;
                for (i in itemsUserAccount)
                {
                    i.visible = true;
                }
        }
        bg.x = window.x;
        bg.y = window.y;

        systemSection.x = window.x + 14;
        systemSection.y = window.y + 28;

        back.x = window.x + 14;
        back.y = window.y + 28;

        personalizationSection.x = window.x + 14;
        personalizationSection.y = window.y + 77;

        useraccountSection.x = window.x + 14;
        useraccountSection.y = window.y + 126;

        textLanguage.x = window.x + 350;
        textLanguage.y = window.y + 28;

        textLanguageCurrent.x = textLanguage.x;
        textLanguageCurrent.y = textLanguage.y + 45;

        textLanguageChoose.x = textLanguage.x;
        textLanguageChoose.y = textLanguage.y + 75;

        textLanguageChooseEN.x = l.curLanguage == "en" ? textLanguageChoose.x + 235 :textLanguageChoose.x + 175 ;
        textLanguageChooseEN.y = textLanguageChoose.y + 5;

        textLanguageChooseRU.x = l.curLanguage == "en" ? textLanguageChoose.x + 335 : textLanguageChoose.x + 279 ;
        textLanguageChooseRU.y = textLanguageChoose.y + 5;

        textPesonalizationWallpaper.x = window.x + 350;
        textPesonalizationWallpaper.y = window.y + 28;

        wallpaperCURRENT.x = textPesonalizationWallpaper.x;
        wallpaperCURRENT.y = textPesonalizationWallpaper.y + 50;

        textWallpaperCurent.x = wallpaperCURRENT.x;
        textWallpaperCurent.y = wallpaperCURRENT.y + 250;

        wal1.x = textWallpaperCurent.x;
        wal1.y = textWallpaperCurent.y + 25;

        wal2.x = textWallpaperCurent.x + 55;
        wal2.y = textWallpaperCurent.y + 25;

        wal3.x = textWallpaperCurent.x + 110;
        wal3.y = textWallpaperCurent.y + 25;

        wal4.x = textWallpaperCurent.x + 165;
        wal4.y = textWallpaperCurent.y + 25;

        textTaskBar.x = wal1.x;
        textTaskBar.y = wal1.y + 45;

        
        textTaskBarChange.x = wal1.x;
        textTaskBarChange.y = textTaskBar.y + 40;

        up.x = l.curLanguage == "en" ? textTaskBarChange.x + 180 : textTaskBarChange.x + 325;
        up.y = textTaskBarChange.y + 5;

        down.x =  l.curLanguage == "en" ? textTaskBarChange.x + 250 : textTaskBarChange.x + 390;
        down.y = textTaskBarChange.y + 5;

        textDisplay.x = window.x + 350;
        textDisplay.y = textLanguageChoose.y + 35;

        textDisplayFPS.x = textDisplay.x;
        textDisplayFPS.y = textDisplay.y + 50;

        textDisplayFPSCUR.x = textDisplayFPS.x + 65;
        textDisplayFPSCUR.y = textDisplayFPS.y;

        displayBUTTONPLUS.x = textDisplayFPSCUR.x + 75;
        displayBUTTONPLUS.y = textDisplayFPSCUR.y + 5;

        displayBUTTONMINUS.x = textDisplayFPSCUR.x + 50;
        displayBUTTONMINUS.y = textDisplayFPSCUR.y + 5;

        FlxG.drawFramerate = l.FPS;
        FlxG.updateFramerate = l.FPS;

        iconUser.x = window.x + 350;
        iconUser.y = window.y + 30;

        textUser.x = window.x + 565;
        textUser.y = window.y + 30;

        buttonChangeName.x = window.x + 565;
        buttonChangeName.y = window.y + 70;

        buttonChangePassword.x = window.x + 565;
        buttonChangePassword.y = window.y + 105;

        buttonChangeIcon.x = window.x + 565;
        buttonChangeIcon.y = window.y + 140;

        textAutoLogin.x = window.x + 350;
        textAutoLogin.y = window.y + 250;

        buttonAutoLogin.x = window.x + 500;
        buttonAutoLogin.y = window.y + 250;
    }
    override function destroy() {
        super.destroy();
        App.listApplications.remove("settings");
    }
}