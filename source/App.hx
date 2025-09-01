import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import states.WindowsState;
import flixel.group.FlxGroup;

class App extends FlxGroup
{
    public static var listApplications:Array<String> = [];
    public static var Apps:Array<String> = ["console","settings","calc","explorer","notepad","photos"];
    public var nameApp:String = '';
    public static var isWindowsState:Bool = false;
    var items:FlxTypedGroup<FlxButton>;
    public function taskbar(name:String)
    {
        listApplications.push(name);
        TaskBar.isUpdate = true;
    }
    public  function updateItems()
    {
        items.kill();
    }
}