package applications;

import openfl.display.BitmapData;
import states.WindowsState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;

class Photos extends App 
{
    var window:ModernWindow;
    var bg:FlxSprite;
    var bgupItems:FlxSprite;
    var addButton:FlxButton;
    var image:FlxSprite;
    var bitmapData:BitmapData;
    public static var isJust:Bool = false;
    public static var pathFile:String;

    function Appear() 
    {
        bg = new FlxSprite(0,0,'assets/images/setup/bg.png');
        bg.setGraphicSize(1000,699);
        bg.updateHitbox();
        bg.color = 0x272729;
        add(bg);

        bgupItems = new FlxSprite(0,0,'assets/images/setup/bg.png');
        bgupItems.setGraphicSize(1000,50);
        bgupItems.color = 0x18181A;
        bgupItems.updateHitbox();
        add(bgupItems);

        addButton = new FlxButton(0,0,null,function name() {
            WindowsState.openApp("explorer");
            Explorer.isClose = true;
        });
        addButton.makeGraphic(25,25);
        addButton.loadGraphic("assets/images/apps/add.png");
        addButton.updateHitbox();
        add(addButton);

        bitmapData = BitmapData.fromFile(pathFile);

        image = new FlxSprite(0,0,bitmapData);
        image.loadGraphic(bitmapData);
        image.updateHitbox();
        add(image);
    }
    public static function updateFile() 
    {
        isJust = true;
    }
    public function new() 
    {
        super();
        super.taskbar("photos");

        window = new ModernWindow(1000,"Photos","assets/images/icons/photos.png",
        function OnAppear()
        {
            Appear();
        },function name() 
        {
            App.listApplications.remove("photos");
            this.updateItems();
            this.kill();
            
        },function name() 
        {
            
        }, true);
        add(window);
    }
    override function update(elapsed:Float) 
    {
        super.update(elapsed);

        bg.x = window.x;
        bg.y = window.y;

        bgupItems.x = window.x;
        bgupItems.y = window.y;

        addButton.x = window.x;
        addButton.y = window.y + 25;

        image.x = window.x;
        image.y = window.y + 50;
        if ( isJust == true)
        {
            bitmapData = BitmapData.fromFile(pathFile);

            image.loadGraphic(bitmapData);
            isJust = false;
        }
    }
}