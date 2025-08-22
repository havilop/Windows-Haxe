package applications;

import flixel.FlxSprite;

class Notepad extends App 
{
    var window:ModernWindow;
    var bg:FlxSprite;

    function Appear() 
    {
        bg = new FlxSprite(0,0,'assets/images/setup/bg.png');
        bg.setGraphicSize(1000,699);
        bg.updateHitbox();
        bg.color = 0x272729;
        add(bg);
    }
    public function new() 
    {
        super();
        super.taskbar("notepad");

        window = new ModernWindow(1000,"Notepad","assets/images/icons/notepad.png",
        function OnAppear()
        {
            Appear();
        },function name() 
        {
            App.listApplications.remove("notepad");
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
    }
}