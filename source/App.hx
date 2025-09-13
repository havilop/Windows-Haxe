import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import states.WindowsState;
import flixel.group.FlxGroup;

class App extends FlxGroup
{
    public static var listApplications:Array<String> = [];
    public static var Apps:Array<String> = ["console","settings","calc","explorer","notepad","photos","testgame"];
    public var nameApp:String = '';
    public static var isWindowsState:Bool = false;
    var items:FlxTypedGroup<FlxButton>;
    public static var visibleE:Bool = false;
    public var visibleEE:Bool = false;
    public function taskbar(name:String)
    {
        listApplications.push(name);
        TaskBar.isUpdate = true;
    }
    public  function updateItems()
    {
        items.kill();
    }
    public function Visible() {
        visibleEE = true;
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

        if (visibleE)
        {
            Visible();
            visibleE = false;
        }
        if (visibleEE)
        {
            this.visible = true;
            for (i in this)
            {
                i.active = true;
            }
            visibleEE = false;
        }
    }
}