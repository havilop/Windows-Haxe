import haxe.Timer;
import openfl.display.BitmapData;
import states.WindowsState;
import haxe.Json;
import sys.io.File;
import hscript.*;
typedef Csd = {
    var wallpaper:String;
}
class Interpritator {
    public static var l:Csd;
    public static function main(info:String) {

        

         var data = File.getContent("assets/Windows/mbr.json");
        l = Json.parse(data);

        var parser = new Parser();
        var interp = new Interp();
        
        interp.variables.set("trace", function(x) trace(x));
        interp.variables.set("timeDelay", function(f:() -> Void,time:Int) {
            Timer.delay(f,time);
        });
        
        var WindowsState = {
  
        changeWallpaper: function(NewImage:Dynamic) {
            var bitmapData:BitmapData = BitmapData.fromFile(NewImage);
            WindowsState.bg.loadGraphic(bitmapData);
            l.wallpaper = NewImage;
            File.saveContent("assets/Windows/mbr.json", Json.stringify(l, null,""));
        },
        resetTaskBar: function () {
           WindowsState.IsReset = true;
           trace("reset");  
        },
    
    };
        var Json = {
       parse: function(data:String) {
            Json.parse(data);
        },};
        interp.variables.set("Json", Json);
        interp.variables.set("WindowsState", WindowsState);
        var infoo = File.getContent(info);
        var ast = parser.parseString(infoo);
        interp.execute(ast);
    }
}