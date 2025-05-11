import Logon.Logon;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import haxe.Json;
import haxe.Timer;
import sys.FileSystem;
import sys.io.File;
//Well this is the main state of this project//
//u can here find a lot of things//
typedef WindowsMain = {
    var wallpaper:String;
    var taskbar:String;
    var curLanguage:String;
} 
class Windows extends FlxState
{
    var screenLogon:Logon;
   static public var bg:FlxSprite;
    var o:WindowsMain;
    var menu:FlxSprite;
    var taskbarmenu:FlxButton;
    var taskBar:TaskBar;

    override function create() {
        super.create();

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
        bg.screenCenter(X);
        add(bg);

        menu = new FlxSprite(0,0,"assets/images/menu.png");
        menu.visible = false;
        add(menu);


        taskBar = new TaskBar();
        taskBar.visible = false;
        add(taskBar);
        
        taskbarmenu = new FlxButton(0,0,"",function name() {
            trace("is");
        });
        taskbarmenu.loadGraphic("assets/images/taskbarmeu.png");
        taskbarmenu.updateHitbox();
        taskbarmenu.text = o.curLanguage == "en" ? "Taskbar options" : "Параметры панель задач";
        taskbarmenu.label.setFormat(o.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 16,null,CENTER);
        taskbarmenu.visible = false;
        add(taskbarmenu);

        screenLogon = new Logon();
        add(screenLogon);

    }
    override function update(elapsed:Float) {
        super.update(elapsed);

        if (Logon.logon == false)
        {
            if (FlxG.mouse.justPressedRight)
            {
                if (FlxG.mouse.overlaps(taskBar.mainpart))
                {
                    taskbarmenu.x = FlxG.mouse.x;
                    taskbarmenu.y = FlxG.mouse.y;
                    taskbarmenu.visible = true;
                }
            }
            if (FlxG.mouse.justPressed)
            {
                Timer.delay(function name() {
                     taskbarmenu.visible = false;
                }, 100);
            }
            taskBar.visible = true;
        }
    }
}