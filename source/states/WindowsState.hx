package states;
import Logon.Logon;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.Json;
import haxe.Timer;
import sys.FileSystem;
import sys.io.File;
import applications.ConsoleApp;
import applications.SettingsApplication;
import states.BIOState;
import states.LoadState;
import states.MBRstate;
import states.OOBEState;
import states.SetupState;
import states.WindowsState;

typedef WindowsMain = {
    var wallpaper:String;
    var FPS:Int;
    var taskbar:String;
    var curLanguage:String;
} 
class WindowsState extends FlxState
{
    var screenLogon:Logon;
    var ISAPPEAR:Bool;
       var is = false;
   static public var bg:FlxSprite;
    var o:WindowsMain;
    var menu:FlxSprite;
    var settings:SettingsApplication;
    var taskbarmenu:FlxButton;
    var test:ConsoleApp;
    static public var taskBar:TaskBar;
    static public var IsReset:Bool;
    static public var IsSystem:Bool;

    public function ResetTaskBar() 
    {
        taskBar.kill();
        taskBar = new TaskBar();
        taskBar.visible = true;
        add(taskBar);
    }
    override function create() {
        super.create();
        FlxG.sound.volumeDownKeys = null;
        FlxG.sound.volumeUpKeys = null;
        FlxG.mouse.visible = true;
        FlxG.mouse.useSystemCursor = true;
        FlxG.autoPause = false;

        if (FileSystem.exists("assets/Windows/mbr.json"))
        {
            try 
            {
                var data = File.getContent("assets/Windows/mbr.json");
                o = Json.parse(data);
            }
        }

        bg = new FlxSprite(0,0,o.wallpaper);
        bg.loadGraphic(o.wallpaper);
        bg.setGraphicSize(FlxG.width,FlxG.height);
        bg.updateHitbox();
        bg.screenCenter(X);
        add(bg);

        menu = new FlxSprite(0,0,"assets/images/menu.png");
        menu.visible = false;
        add(menu);

        var testDesktop = new TestDesktop();
        add(testDesktop);
        
        taskBar = new TaskBar();
        taskBar.visible = false;
        add(taskBar);

        screenLogon = new Logon();
        add(screenLogon);

    }
    override function update(elapsed:Float) {
        super.update(elapsed);

        FlxG.drawFramerate = o.FPS;
        FlxG.updateFramerate = o.FPS;
        
        if (IsSystem == true)
        {
            settings = new SettingsApplication();
            settings.currentSection = "system";
            add(settings);
            IsSystem = false;
        }
            if(IsReset == true)
        {
            taskBar.kill();
        taskBar = new TaskBar();
        taskBar.visible = true;
        add(taskBar);
        IsReset = false;
        }
        if (Logon.logon == false)
        {
            if (FlxG.keys.justPressed.F10)
            {
            test = new ConsoleApp();
            add(test);
            }
            if (FlxG.mouse.justPressedRight)
            {
                if (FlxG.mouse.overlaps(taskBar.mainpart))
                {
                    if (is == false)
                    {
             taskbarmenu = new FlxButton(0,0,"",function name() {
            settings = new SettingsApplication();
            settings.currentSection = "personalization";
            add(settings);
        });
        taskbarmenu.loadGraphic("assets/images/taskbarmeu.png");
        taskbarmenu.updateHitbox();
        taskbarmenu.text = o.curLanguage == "en" ? "Taskbar options" : "Параметры панель задач";
        taskbarmenu.label.setFormat(o.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 16,FlxColor.WHITE,CENTER);
        add(taskbarmenu);
                    taskbarmenu.x = FlxG.mouse.x;
                    taskbarmenu.y = FlxG.mouse.y;
                    ISAPPEAR = true;
is = true;
    }
                }
            }
            if (FlxG.mouse.justReleased)
            {
                Timer.delay(function name() {
                    if (ISAPPEAR == true)
                    {
                         taskbarmenu.kill(); 
                         ISAPPEAR = false;
                         is = false;
                    }
                }, 1);
            }
            taskBar.visible = true;
        }
    }
}