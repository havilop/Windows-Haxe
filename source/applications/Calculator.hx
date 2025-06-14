package applications;

import flixel.FlxSprite;

class Calculator extends App
{
    var window:ModernWindow;
    var bg:FlxSprite;
    public function addUI() 
    {
        bg = new FlxSprite(0,0,'assets/images/setup/bg.png');
        bg.setGraphicSize(322,501);
        bg.updateHitbox();
        bg.color = 0x272729;
        add(bg);
    }
    public function new() 
    {
        super();
        super.taskbar("calculator");

          window = new ModernWindow(322,'Calculator','assets/images/icons/calculator.png',
          function appear() 
          {
            addUI();
          }, function exit()
          {
            App.listApplications.remove("calculator");
            this.updateItems();
            this.kill();
          }, function minus() {
            
          },true);
          window.screenCenter(XY);
          window.y -= 50;
          add(window);
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

        bg.x = window.x;
        bg.y = window.y + 28;
    }
}