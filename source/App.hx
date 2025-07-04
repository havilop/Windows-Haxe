import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import states.WindowsState;
import flixel.group.FlxGroup;

class App extends FlxGroup
{
    public static var listApplications:Array<String> = [];
    public static var Apps:Array<String> = ["cmd","settings","calc"];
    public var nameApp:String = '';
    public static var isWindowsState:Bool = false;
    var items:FlxTypedGroup<FlxButton>;
    public function taskbar(name:String)
    {
        listApplications.push(name);
        nameApp = name;
        trace(listApplications);

        items = new FlxTypedGroup<FlxButton>();
		add(items);

        for (num => i in listApplications)
        {
            var item = createNewItem((num * 50) + 50, isWindowsState == true ? WindowsState.taskBar.mainpart.y : 2000,i);
            add(item);
            
            var up:FlxSprite = new FlxSprite((num * 50) + 50,isWindowsState == true ? WindowsState.taskBar.mainpart.y : 2000,'assets/images/icons/app.png');
            up.updateHitbox();
            add(up);
        }

    }
    function createNewItem(x:Float,y:Float,name:String)
    {
        var item:FlxButton = new FlxButton(x,y,null,null);
        item.loadGraphic('assets/images/icons/$name.png');
        item.setGraphicSize(40,40);
        item.updateHitbox();
        items.add(item);
        return item;
    }
    public  function updateItems()
    {
        items.kill();
    }
}