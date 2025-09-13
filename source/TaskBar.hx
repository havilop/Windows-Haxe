
import openfl.display.BitmapData;
import flixel.graphics.FlxGraphic;
import flixel.system.FlxAssets.FlxGraphicAsset;
import applications.TestGame;
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
    var restart:FlxButton;
    var volume:FlxButton;
    var swithcFirstTimed:Bool = false;
    var wasOverlappin:Bool = false;
    var menu:FlxSprite;
    static public var isUpdate:Bool = false;
    static public var isClear:Bool = false; 
    var windowEXIT:CustomWindow;
    var menuextraSETTINGS:FlxButton;
    var menuextraOFF:FlxButton;
    var appsMenu:FlxGroup;
    var items:FlxGroup;

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
            appsMenu.visible = true;
            for (i in appsMenu)
            {
                i.visible = true;
            }
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
            appsMenu.visible = false;
               for (i in appsMenu)
            {
                i.visible = false;
            }
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
        mainpart.setGraphicSize(FlxG.width,40);
        mainpart.updateHitbox();
        mainpart.y += o.taskbar == "down" ? FlxG.height - 40 : o.taskbar == "up" ? 0 : 0; 
        add(mainpart);

        startmenu = new FlxButton(0,0,"",appear);
        startmenu.loadGraphic("assets/images/startmenu.png");
        startmenu.updateHitbox();
        startmenu.onOut.callback = function name() {
            startmenu.loadGraphic("assets/images/startmenu.png");
        }
        startmenu.onOver.callback = function name() {
            startmenu.loadGraphic("assets/images/startmenuCOVER.png");
        }
        startmenu.y += o.taskbar == "down" ? FlxG.height - 40 : o.taskbar == "up" ? 0 : 0; 
        add(startmenu);

        menuextraOFF = new FlxButton(0,0,"",appearOFF);
        menuextraOFF.loadGraphic("assets/images/menuEXTRAOFF.png");
        menuextraOFF.onOut.callback = function name() {
            menuextraOFF.loadGraphic("assets/images/menuEXTRAOFF.png");
        }
        menuextraOFF.onOver.callback = function name() {
            menuextraOFF.loadGraphic("assets/images/menuEXTRAOFFCOVER.png");
        }
        menuextraOFF.y = o.taskbar == "down" ? FlxG.height - 87 : o.taskbar == "up" ? 719 : 719;
        menuextraOFF.visible = false;
        add(menuextraOFF);

        menuextraSETTINGS = new FlxButton(0,0,"",function Open() {
           WindowsState.IsSystem = true;
            swithcFirstTimed = true;
            appear();
        });
        menuextraSETTINGS.loadGraphic("assets/images/menuEXTRASETTINGS.png");
        menuextraSETTINGS.onOver.callback = function name() {
            menuextraSETTINGS.loadGraphic("assets/images/menuEXTRASETTINGSCOVER.png");
        }
        menuextraSETTINGS.onOut.callback = function name() {
            menuextraSETTINGS.loadGraphic("assets/images/menuEXTRASETTINGS.png");
        }
        menuextraSETTINGS.y = o.taskbar == "down" ? FlxG.height - 133 : o.taskbar == "up" ? 670 : 670;
        menuextraSETTINGS.visible = false;
        add(menuextraSETTINGS);

        restart = new FlxButton(0,0,"",function name()
            { ConsoleApp.isRestart = true;

                 for (i in App.listApplications)
                    {
                        App.listApplications.remove(i);
                            for (v in App.listApplications)
                                {
                                     App.listApplications.remove(v);
                                      for (w in App.listApplications)
                                {
                                     App.listApplications.remove(w);
                                }
                            }
                    }

                    TaskBar.isUpdate = true;

                     Timer.delay(function name() {
                        LoadState.setLoadingScreen(200,BIOState.new);
                    },2000);});
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

        appsMenu = new FlxGroup();
        appsMenu.visible = false;
		add(appsMenu);

        for (num => i in App.Apps)
        {
            
            function returnSprite() 
            {
                var cur:String = '';
                var current = 'assets/images/icons/$cur.png';
                var apps = App.Apps;
                var listOfFiles = FileSystem.readDirectory("assets/images/icons");
                var string = listOfFiles.toString();
                var resul = StringTools.replace(string, "[", "");
                resul = StringTools.replace(resul, "]", "");
                resul = StringTools.replace(resul, ",", "");
                var c = resul;
                var newW = c.split(".png");
                newW.pop();
                var result = "sex";

                if (i != result)
                {
                    current = 'assets/images/icons/null.png';
                }

                if (newW.indexOf(i) != -1) 
                {
                    result = i;
                   if (i == result)
                {
                    current = 'assets/images/icons/$result.png';
                }
                }
                return current;
            }
            var image = returnSprite();
            var item = new FlxButton(90, (num * 40) + (o.taskbar == "up" ? 40 : o.taskbar == "down" ? 315 :315) , i,function nam() { WindowsState.openApp(i);  swithcFirstTimed = true;appear();});
            item.makeGraphic(220,40,FlxColor.TRANSPARENT);
            item.label.setFormat(BackendAssets.my,16,FlxColor.WHITE,LEFT);
            item.text = item.text == "console" ? "console" : item.text == "calc" ? "calculator" : i;
            item.updateHitbox();
            var img = new FlxSprite(50,(num * 40) + (o.taskbar == "up" ? 40 : o.taskbar == "down" ? 315 :315),image);
            img.setGraphicSize(40,40);
            img.updateHitbox();
            appsMenu.add(item);
            appsMenu.add(img);
        }

        timeText = new FlxText(0, 10, 0, "", 12);
        timeText.font = "assets/fonts/my.ttf";
        timeText.color = FlxColor.WHITE;
        timeText.alignment = CENTER;
        timeText.x = FlxG.width - 65;
        timeText.y += o.taskbar == "down" ? FlxG.height - 50 : o.taskbar == "up" ? -10 : -10; 
        add(timeText);

        volume = new FlxButton(0,0,"",null);
        volume.loadGraphic("assets/images/volume.png");
        volume.onOver.callback = function name() {
            volume.loadGraphic("assets/images/volumeCOVER.png");
        }
        volume.onOut.callback = function name() {
            volume.loadGraphic("assets/images/volume.png");
        }
        volume.updateHitbox();
        volume.x = FlxG.width - 90;
        volume.y += o.taskbar == "down" ? FlxG.height - 40 : o.taskbar == "up" ? 0 : 0; 
        add(volume);

        items = new FlxGroup();
		add(items);
        
        updateTime();
        updateItems();
    }   
    override function update(elapsed:Float) {
        super.update(elapsed);
    
    if (isClear)
    {
        items.clear();
        updateItems();
        isClear = false;
    }
    
   if (isUpdate)
    {
        updateItems();
        isUpdate = false;
    }
 updateTime();
    }
     function createNewItem(x:Float,y:Float,name:String)
        {
            function returnSprite() 
            {
                var cur:String = '';
                var current = 'assets/images/icons/$cur.png';
                var apps = App.Apps;
                var listOfFiles = FileSystem.readDirectory("assets/images/icons");
                var string = listOfFiles.toString();
                var resul = StringTools.replace(string, "[", "");
                resul = StringTools.replace(resul, "]", "");
                resul = StringTools.replace(resul, ",", "");
                var c = resul;
                var newW = c.split(".png");
                newW.pop();
                var result = "sex";

                if (name != result)
                {
                    current = 'assets/images/icons/null.png';
                }

                if (newW.indexOf(name) != -1) 
                {
                    result = name;
                   if (name == result)
                {
                    current = 'assets/images/icons/$result.png';
                }
                }
                return current;
            }
        var image = returnSprite();
        var item:FlxButton = new FlxButton(x,y,null,function nam() {
            App.visibleE = true;
        });
        item.loadGraphic(image);
        item.setGraphicSize(40,40);
        item.updateHitbox();
        return item;

        }

         function updateItems() {
            for (num => i in App.listApplications)
        {
            var item = createNewItem((num * 50) + 50, App.isWindowsState == true ? WindowsState.taskBar.mainpart.y : 2000,i);
            items.add(item);
            
            var up:FlxSprite = new FlxSprite((num * 50) + 50,App.isWindowsState == true ? WindowsState.taskBar.mainpart.y : 2000,'assets/images/icons/app.png');
            up.updateHitbox();
            items.add(up);
        }
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