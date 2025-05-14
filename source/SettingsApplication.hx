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

typedef Setmbr = {
    var curLanguage:String;
    var wallpaper:String;
    var taskbar:String;
} 

class SettingsApplication extends FlxGroup
{
    public var currentSection:String;
    var bg:FlxSprite;
    var systemSection:FlxButton;
    var personalizationSection:FlxButton;
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
            Windows.bg.loadGraphic("assets/images/wallpapers/wallpaper.png");
            l.wallpaper = "assets/images/wallpapers/wallpaper.png";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        });
        wal1.loadGraphic("assets/images/wallpapers/wallpaper.png");
        wal1.setGraphicSize(50,50);
        wal1.updateHitbox();
        wal1.visible = false;
        add(wal1);

        wal2 = new FlxButton(0,0,"",function name() {
             Windows.bg.loadGraphic("assets/images/wallpapers/wallpaper2.png");
            l.wallpaper = "assets/images/wallpapers/wallpaper2.png";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        });
        wal2.loadGraphic("assets/images/wallpapers/wallpaper2.png");
        wal2.setGraphicSize(50,50);
        wal2.updateHitbox();
        wal2.visible = false;
        add(wal2);

        wal3 = new FlxButton(0,0,"",function name() {
             Windows.bg.loadGraphic("assets/images/wallpapers/wallpaper3.png");
            l.wallpaper = "assets/images/wallpapers/wallpaper3.png";
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        });
        wal3.loadGraphic("assets/images/wallpapers/wallpaper3.png");
        wal3.setGraphicSize(50,50);
        wal3.updateHitbox();
        wal3.visible = false;
        add(wal3);

        wal4 = new FlxButton(0,0,"",function name() {
             Windows.bg.loadGraphic("assets/images/wallpapers/wallpaper4.png");
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
            Windows.taskBar.kill();
            Windows.IsReset = true;
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
            Windows.taskBar.kill();
            Windows.IsReset = true;
        });
        down.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf",16,0x35599C,CENTER);
        down.text = l.curLanguage == "en" ? "DOWN" : "Вниз";
        down.setGraphicSize(60,20);
        down.makeGraphic(60,20,FlxColor.TRANSPARENT);
        down.updateHitbox();
        down.visible = false;
        add(down);
        
    }
    public function RemoveUI()
    {
        this.kill();
    }
    public function new() 
    {
        super();
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
            case "personalization":
                systemSection.loadGraphic("assets/images/settings/system.png");

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
        }
        bg.x = window.x;
        bg.y = window.y;

        systemSection.x = window.x + 14;
        systemSection.y = window.y + 28;

        back.x = window.x + 14;
        back.y = window.y + 28;

        personalizationSection.x = window.x + 14;
        personalizationSection.y = window.y + 77;

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
    }
}