import haxe.Timer;
import haxe.Json;
import sys.io.File;
import sys.FileSystem;
import flixel.FlxState;
import flixel.FlxG;
import flixel.addons.ui.FlxInputText;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import states.BIOState;
import states.LoadState;
import states.MBRstate;
import states.OOBEState;
import states.SetupState;
import states.WindowsState;


typedef ConsoleType = {
    var isWindowsInstalled:Bool;
    var console:Bool;
    var autoMBR:Bool;
    var fastBIOS:Bool;
} 
class Console extends FlxState
{
    private var consoleInput:FlxInputText;
    private var consoleOutput:FlxText;
    var listCommand:Array<String> = ["/fixmbr","/help","/exit","/clear","/loadmbr","/autoconsole","/install windows"];
    var o:ConsoleType;
    var isAutoConsole:Bool = false;
    var cmd:String = null;
    
    override public function create():Void
    {
        super.create();
        FlxG.mouse.visible = true;
      
        consoleOutput = new FlxText(20, 20, FlxG.width - 40, "", 12);
        consoleOutput.color = FlxColor.WHITE;
        consoleOutput.scrollFactor.set();
        add(consoleOutput);
        
     
        consoleInput = new FlxInputText(20, FlxG.height - 40, FlxG.width - 40, "", 12, FlxColor.WHITE, FlxColor.GRAY);
        consoleInput.callback = onConsoleCommandEntered;
        consoleInput.scrollFactor.set();
        add(consoleInput);
        
      
        consoleInput.hasFocus = false;
        consoleInput.hasFocus = true;
        
        logToConsole("Type /help to list commands");
        if (FileSystem.exists("assets/data/settings.json"))
        {
            var data = File.getContent("assets/data/settings.json");
            o = Json.parse(data);
            
        }
    }
    
    private function onConsoleCommandEntered(text:String, action:String):Void
    {
         if (action == "enter")
        {
            switch (text)
            {
                case "/fixmbr":
                      logToConsole("Mbr Was Fixed");
                o.isWindowsInstalled = true;
                File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
                case "/clear":
                consoleOutput.text = "";
                logToConsole("Type /help to list commands");
                case "/help": 
                    for (cmd in listCommand)
                    {
                          logToConsole(cmd);
                    }
                case "/exit":
                     LoadState.setLoadingScreen(2000, BIOState.new);
                case "/loadmbr":
                    FlxG.switchState(MBRstate.new);
                case "/autoconsole":
                    logToConsole("Please, write variable autoconsole false or true\nExample: /autoconsole true");
                case "/autoconsole false":
                 o.console = false;
                File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
                  logToConsole("Succes!");
                case "/autoconsole true":
                 o.console = true;
                File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
                logToConsole("Succes!");
                case "/install windows":
                o.isWindowsInstalled = false;
                File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
                LoadState.setLoadingScreen(1000,SetupState.new);
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

        
  
        if (FlxG.keys.justPressed.GRAVEACCENT)
        {
            consoleInput.visible = !consoleInput.visible;
            consoleInput.hasFocus = consoleInput.visible;
        }
    }
}