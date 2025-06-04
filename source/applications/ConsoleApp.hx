package applications;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import haxe.Json;
import sys.io.File;
import sys.FileSystem;
import flixel.FlxState;
import flixel.FlxG;
import flixel.addons.ui.FlxInputText;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import applications.SettingsApplication;
import states.BIOState;
import states.LoadState;
import states.MBRstate;
import states.OOBEState;
import states.SetupState;
import states.WindowsState;

typedef Cs = {
    var isWindowsInstalled:Bool;
    var console:Bool;
} 
class ConsoleApp extends FlxGroup
{
    var window:ModernWindow;
    private var consoleInput:FlxInputText;
    private var consoleOutput:FlxText;
    var bg:FlxSprite;
    var listWords:Array<String> = ["god","russia","sex","windowshaxe","girl","house","engineer"];
    var listCommand:Array<String> = ["help","exit","clear","shutdown","apps"];
    var o:Cs;


    	public function int(from:Int, to:Int):Int
	{
		return from + Math.floor(((to - from + 1) * Math.random()));
	}

    public function new ()
    {
        super();
        window = new ModernWindow(900,"Console","assets/images/icons/null.png",function appear() 
        {

        bg = new FlxSprite(0,0,"assets/images/setup/bg.png");
        bg.setGraphicSize(900,500);
        bg.updateHitbox();
        bg.color = 0x181818;
        add(bg);

        consoleOutput = new FlxText(0, 0, FlxG.width - 40, "", 12);
        consoleOutput.color = FlxColor.WHITE;
        add(consoleOutput);
        
        consoleInput = new FlxInputText(0, 0, 895, "", 12, FlxColor.WHITE, FlxColor.BLACK);
        consoleInput.callback = onConsoleCommandEntered;
        add(consoleInput);
        
        consoleInput.hasFocus = false;
        consoleInput.hasFocus = true;
        
        logToConsole("Type help to list commands");
        if (FileSystem.exists("assets/data/settings.json"))
        {
            var data = File.getContent("assets/data/settings.json");
            o = Json.parse(data);
        }
        },function exit() 
        {
            this.kill();
        },
        function minus() 
        {
            this.kill();
        }, true);
        add(window);
    }
 private function onConsoleCommandEntered(text:Dynamic, action:String):Void
    {
         if (action == "enter")
        {
            switch (text)
            {
                case "clear":
                consoleOutput.text = "";
                logToConsole("Type help to list commands");
                case "help": 
                    for (cmd in listCommand)
                    {
                          logToConsole(cmd);
                    }
                case "exit":
                     this.kill();
                case "settings.exe":
                    var settings = new SettingsApplication();
                    settings.currentSection = "system";
                    add(settings);
                case "logon.exe":
                    var logon = new Logon();
                    add(logon);
                 case "taskbar.exe":
                   WindowsState.IsReset = true;
                case "shutdown /off":
                    Sys.exit(0);
                case "shutdown /restart":
                    LoadState.setLoadingScreen(2000,BIOState.new);
                case "shutdown":
                    logToConsole("shutdown /off");
                    logToConsole("shutdown /restart");
                case "explorer.exe":
                    logToConsole("Success!");
                case "apps":
                    logToConsole("settings.exe");
                    logToConsole("logon.exe");
                     logToConsole("taskbar.exe");
                     logToConsole("explorer.exe");
                case "random":
                   var max = listWords.length - 1;
                   trace(max);
                   var random = int(0,max);
                   trace(random);
                   var word = listWords[random];
                   trace(word);
                    logToConsole(word);
                default: 
                     logToConsole('Error invalid command $text');
            }
         
            consoleInput.text = "";
            consoleInput.hasFocus = false;
            consoleInput.hasFocus = true;
        }
    }
    
    private function logToConsole(message:String):Void
    {
        consoleOutput.text += "> " + message + "\n";
             consoleInput.hasFocus = false;
             consoleInput.hasFocus = true;
    }
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        bg.x = window.x;
        bg.y = window.y;

        consoleOutput.x = window.x + 10;
        consoleOutput.y = window.y + 30;

        consoleInput.x = window.x + 3;
        consoleInput.y = window.y + 480;
    }
}