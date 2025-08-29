import flixel.FlxSprite;
import sys.FileSystem;
import haxe.Timer;
import openfl.display.BitmapData;
import sys.io.File;
import states.WindowsState;
import haxe.Json;
import hscript.*;
typedef Isw = {
    var wallpaper:String;
} 
class Interpritator
{

    public static var info:String;
    var l:Isw; 

    public static function mai() 
    {
        
    
     /*    if (FileSystem.exists("assets/data/settings.json"))
        {
            var data = File.getContent("assets/Windows/mbr.json");
            l = Json.parse(data);
     */   
     var parser = new Parser();
    var program = parser.parseString(info);
    var interp = new Interp();
          // functions api;
        interp.variables.set("trace", function(x) trace(x));
        interp.variables.set("timeDelay", function(f:() -> Void,time:Int) {
            Timer.delay(f,time);
        });

   /*     var ConsoleApp = {
        logToConsole: function(message:Dynamic) {
            logToConsole(Std.string(message));
        },
        onConsoleCommandEntered: function(message:Dynamic) {
          onConsoleCommandEntered(message,"enter");
        },
    
    };*/
/*        var WindowsState = {
  
        changeWallpaper: function(NewImage:Dynamic) {
            var bitmapData:BitmapData = BitmapData.fromFile(NewImage);
            WindowsState.bg.loadGraphic(bitmapData);
            l.wallpaper = NewImage;
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        },
        resetTaskBar: function () {
           WindowsState.IsReset = true;
           trace("reset");  
        }, */
    
  //  };
        var Json = {
       parse: function(data:String) {
            Json.parse(data);
        },};
        interp.variables.set("Json", Json);
       //interp.variables.set("WindowsState", WindowsState);
       //this.variables.set("ConsoleApp", ConsoleApp);
       interp.execute(program);
    }
}