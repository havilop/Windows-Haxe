package applications;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.ui.FlxButton;

class TestGame extends App
{
    var playbutton:FlxButton;
    var isGame = false;
    var bg:FlxSprite;
    var window:ModernWindow;
    function addui() {

        bg = new FlxSprite(0,0);
        bg.makeGraphic(800,600,FlxColor.WHITE);
        bg.updateHitbox();
        add(bg);

        playbutton = new FlxButton(0,0,"play",function name() {
            PlayState();
        });
        playbutton.onOut.callback = function name() {
            playbutton.makeGraphic(200,200,FlxColor.BLACK);
        }
        add(playbutton);

        MenuState();
    }
    public function new() 
    {
        super();
        super.taskbar("testgame");

        window = new ModernWindow(800,"TestGame","assets/images/icons/null.png",function name() {
            addui();
        },function name() {
            App.listApplications.remove("testgame");
            TaskBar.isClear = true;
            this.kill();
        },function name() {
            this.visible = false;
            for (i in this)
            {
                i.active = false;
            }
            window.isDragging = false;
        },true);
        add(window);
    }
    function PlayState() 
    {
        playbutton.visible = false;
        bg.makeGraphic(800,600,FlxColor.BLUE);
    }
    function MenuState()
    {
        playbutton.visible = true;
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

        bg.x = window.x;
        bg.y = window.y;

        playbutton.x = window.x + 400;
        playbutton.y = window.y + 400;

    }
}