import flixel.FlxState;
import openfl.text.TextField;
import flixel.addons.ui.FlxUIInputText;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import sys.FileSystem;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;
import applications.SettingsApplication;
import applications.Notepad;
import applications.Explorer;
import applications.ConsoleApp;
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
        parser.allowTypes = true;
        parser.allowJSON = true;
        parser.allowMetadata = true; 
        var interp = new Interp();
        
        interp.variables.set("trace", function(x) trace(x));
        interp.variables.set("timeDelay", function(f:() -> Void,time:Int) {
            Timer.delay(f,time);
        });
        interp.variables.set("add", function(obj) {
    if (FlxG.state != null) {
        FlxG.state.add(obj);
    }
});
        interp.variables.set("FlxG",FlxG);
        interp.variables.set("FlxSprite",FlxSprite);
        interp.variables.set("FlxButton",FlxButton);
        interp.variables.set("FlxText",FlxText);
        interp.variables.set("File",File);
        interp.variables.set("FlxState",FlxState);
        interp.variables.set("FileSystem",FileSystem);
        interp.variables.set("BitmapData",BitmapData);
        interp.variables.set("FlxGroup",FlxGroup);
        interp.variables.set("FlxTypedGroup",FlxTypedGroup);
        interp.variables.set("FlxUIInputText",FlxUIInputText);
        interp.variables.set("TextField",TextField);
        interp.variables.set("BackendAssets", BackendAssets);
        interp.variables.set("SettingsApplication",SettingsApplication);
        interp.variables.set("ModernWindow",ModernWindow);
        interp.variables.set("Notepad",Notepad);
        interp.variables.set("Explorer",Explorer);
        interp.variables.set("ConsoleApp",ConsoleApp);
        interp.variables.set("WindowsState",WindowsState);
        interp.variables.set("App",App);
        interp.variables.set("Json", Json);
    
        var infoo = File.getContent(info);
        var ast = parser.parseString(infoo);
        interp.execute(ast);
    }
}