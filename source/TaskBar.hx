import haxe.Log;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.Json;
import haxe.Timer;
import lime.media.vorbis.Vorbis;
import sys.FileSystem;
import sys.io.File;
import applications.SettingsApplication;
import applications.ConsoleApp;
import states.BIOState;
import states.LoadState;
import states.MBRstate;
import states.OOBEState;
import states.SetupState;
import states.WindowsState;


typedef TaskBarSettings = 
{
var taskbar:String;
var curLanguage:String;
}

class TaskBar extends FlxGroup
{
  public var mainpart:FlxSprite;
    var o:TaskBarSettings;
    var settingsWindow:SettingsApplication;
    var startmenu:FlxButton;
    var wasOverlapping:Bool = false;
    var wasoff:Bool = false;
    var allowcover:Bool = false;
    var timeText:FlxText;
    var bgturnoff:FlxSprite;
    var was:Bool = false;
    var off:FlxButton;
    public var listApplications:Array<String> = [];
    var restart:FlxButton;
    var volume:FlxButton;
    var swithcFirstTimed:Bool = false;
    var wasOverlappin:Bool = false;
    var menu:FlxSprite;
    var windowEXIT:CustomWindow;
    var menuextraSETTINGS:FlxButton;
    var menuextraOFF:FlxButton;
    var appsMenu:FlxTypedGroup<FlxButton>;

    public function updateTaskBarMembers() 
    {
        trace("Updated",listApplications);
    }
    public function new() {
        super();
        if (FileSystem.exists("assets/Windows/mbr.json"))
        {
            try 
            {
                var data = File.getContent("assets/Windows/mbr.json");
                o = Json.parse(data);
            }
        }
        
        function appear()
        {
            if (swithcFirstTimed == false)
            {
            menu.visible = true;
            menuextraOFF.visible = true;
            menuextraSETTINGS.visible = true;
            Timer.delay(function name() {
                       swithcFirstTimed = true;
            },100);
            }
            if(swithcFirstTimed == true)
            {
            menu.visible = false;
            menuextraOFF.visible = false;
            menuextraSETTINGS.visible = false;
            swithcFirstTimed = false;
            restart.visible = false;
            off.visible = false;
            }
        }
        function appearOFF() 
        {
            restart.visible = true;
            off.visible = true;
        }

        menu = new FlxSprite(0,0,"assets/images/menu.png");
        menu.y = o.taskbar == "down" ? FlxG.height - 768 : o.taskbar == "up" ? 40 : 40;
        menu.visible = false;
        add(menu);

        
        mainpart = new FlxSprite(0,0,"assets/images/taskbar.png");
        mainpart.screenCenter(X);
        mainpart.y += o.taskbar == "down" ? FlxG.height - 40 : o.taskbar == "up" ? 0 : 0; 
        add(mainpart);

        startmenu = new FlxButton(0,0,"",appear);
        startmenu.loadGraphic("assets/images/startmenu.png");
        startmenu.updateHitbox();
        startmenu.y += o.taskbar == "down" ? FlxG.height - 40 : o.taskbar == "up" ? 0 : 0; 
        add(startmenu);

        menuextraOFF = new FlxButton(0,0,"",appearOFF);
        menuextraOFF.loadGraphic("assets/images/menuEXTRAOFF.png");
        menuextraOFF.y = o.taskbar == "down" ? FlxG.height - 87 : o.taskbar == "up" ? 719 : 719;
        menuextraOFF.visible = false;
        add(menuextraOFF);

        menuextraSETTINGS = new FlxButton(0,0,"",function Open() {
           WindowsState.IsSystem = true;
            swithcFirstTimed = true;
            appear();
        });
        menuextraSETTINGS.loadGraphic("assets/images/menuEXTRASETTINGS.png");
        menuextraSETTINGS.y = o.taskbar == "down" ? FlxG.height - 133 : o.taskbar == "up" ? 670 : 670;
        menuextraSETTINGS.visible = false;
        add(menuextraSETTINGS);

        restart = new FlxButton(0,0,"",function name(){LoadState.setLoadingScreen(500,BIOState.new);});
        restart.loadGraphic("assets/images/taskbar/restart.png");
        restart.updateHitbox();
        restart.text = o.curLanguage == "en" ? "Restart" : "Перезагрузка";
        restart.label.setFormat(o.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 16,FlxColor.WHITE,CENTER);
        restart.updateHitbox();
        restart.y = o.taskbar == "down" ? FlxG.height - 125 : o.taskbar == "up" ? 719 : 719;
        restart.x = 300;
        restart.visible = false;
        add(restart);

        
        off = new FlxButton(0,0,"",function name() {Sys.exit(0);});
        off.loadGraphic("assets/images/taskbar/off.png");
        off.updateHitbox();
        off.text = o.curLanguage == "en" ? "Turn Off" : "Завершение работы";
        off.label.setFormat(o.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 16,FlxColor.WHITE,CENTER);
        off.updateHitbox();
        off.y = o.taskbar == "down" ? FlxG.height - 167 : o.taskbar == "up" ? 676 : 676;
        off.x = 300;
        off.visible = false;
        add(off);

        timeText = new FlxText(0, 10, 0, "", 12);
        timeText.font = "assets/fonts/my.ttf";
        timeText.color = FlxColor.WHITE;
        timeText.alignment = CENTER;
        timeText.x = FlxG.width - 65;
        timeText.y += o.taskbar == "down" ? FlxG.height - 50 : o.taskbar == "up" ? -10 : -10; 
        add(timeText);

        volume = new FlxButton(0,0,"",null);
        volume.loadGraphic("assets/images/volume.png");
        volume.updateHitbox();
        volume.x = FlxG.width - 90;
        volume.y += o.taskbar == "down" ? FlxG.height - 40 : o.taskbar == "up" ? 0 : 0; 
        add(volume);
        
        updateTime();
    }   
    override function update(elapsed:Float) {
        super.update(elapsed);

          
    var isOverlapping = startmenu.overlapsPoint(FlxG.mouse.getWorldPosition());
    
    if (wasOverlapping && isOverlapping) {
        startmenu.loadGraphic("assets/images/startmenuCOVER.png");
    }

    if (wasOverlapping && !isOverlapping) {
        trace("out");
        startmenu.loadGraphic("assets/images/startmenu.png");
    }
    
    wasOverlapping = isOverlapping;
//////////////////////////////////////////////////////////////
     var isOveroOff = menuextraOFF.overlapsPoint(FlxG.mouse.getWorldPosition());
    
    if (wasoff && isOveroOff) {
        menuextraOFF.loadGraphic("assets/images/menuEXTRAOFFCOVER.png");
    }

    if (wasoff && !isOveroOff) {
menuextraOFF.loadGraphic("assets/images/menuEXTRAOFF.png");
    }
    
    wasoff = isOveroOff;

    
    var isOverlappin = menuextraSETTINGS.overlapsPoint(FlxG.mouse.getWorldPosition());
    
    if (wasOverlappin && isOverlappin) {
        trace("doit");
        menuextraSETTINGS.loadGraphic("assets/images/menuEXTRASETTINGSCOVER.png");
    }

    if (wasOverlappin && !isOverlappin) {
        menuextraSETTINGS.loadGraphic("assets/images/menuEXTRASETTINGS.png");
    }
    
    wasOverlappin = isOverlappin;

    
        var isOver = volume.overlapsPoint(FlxG.mouse.getWorldPosition());
    if (was && isOver) {
        volume.loadGraphic("assets/images/volumeCOVER.png");
    }

    if (was && !isOver) {
    volume.loadGraphic("assets/images/volume.png");
    }
    was = isOver;
    

 updateTime();
    }

    
    private function updateTime():Void
    {
        var now = Date.now();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var day = now.getDate();
        var month = now.getMonth() + 1;
        var year = now.getFullYear();
        
    
        var timeStr = StringTools.lpad(Std.string(hours), "0", 2) + ":" + 
                      StringTools.lpad(Std.string(minutes), "0", 2);
        
      
        var dateStr = StringTools.lpad(Std.string(day), "0", 2) + "." + 
                      StringTools.lpad(Std.string(month), "0", 2) + "." + 
                      Std.string(year);
        
      
        timeText.text = timeStr + "\n" + dateStr;
        
       
        timeText.width = timeText.textField.textWidth + 10;
    }
}