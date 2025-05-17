import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

typedef Mes = {
    var curLanguage:String;
} 
class MessageBox extends FlxGroup
{
    var bg:FlxSprite;
    var mainMessage:FlxSprite;
  public  var textMessage:FlxText;
    var l:Mes;
    var wasOverlapping:Bool = false;
    var inm:Bool = false;
    var okBUTTON:FlxButton;
    var cancelBUTTON:FlxButton;

    public function new(text:String, ?ok, ?can)
    {
        super();
        if (FileSystem.exists("assets/Windows/mbr.json")) 
        {
            try 
            {
                var data = File.getContent("assets/Windows/mbr.json");
                l = Json.parse(data);
            }
        }

        bg = new FlxSprite(0,0,"assets/images/setup/bg.png");
        bg.setGraphicSize(FlxG.width,FlxG.height);
        bg.updateHitbox();
        bg.color = FlxColor.BLACK;
        bg.alpha = 0.5;
        add(bg);

        mainMessage = new FlxSprite(0,0,"assets/images/setup/bg.png");
        mainMessage.setGraphicSize(625,188);
        mainMessage.updateHitbox();
        mainMessage.screenCenter(XY);
        mainMessage.color = 0x1489E9;
        add(mainMessage);

        textMessage = new FlxText(0,0,0,"",26);
        textMessage.text = text;
        textMessage.font = l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf";
        textMessage.screenCenter(XY);
        textMessage.x = mainMessage.x + 10;
        textMessage.y = mainMessage.y;
        add(textMessage);

        okBUTTON = new FlxButton(0,0,"",ok);
        okBUTTON.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots/ttf",16,FlxColor.WHITE,CENTER);
        okBUTTON.makeGraphic(81,25,FlxColor.BLUE);
        okBUTTON.setGraphicSize(81,25);
        okBUTTON.updateHitbox();
        okBUTTON.text = l.curLanguage == "en" ? "OK" : "OK";
        okBUTTON.x = mainMessage.x + mainMessage.width - 195;
        okBUTTON.y = mainMessage.y + 150;
        add(okBUTTON);

        cancelBUTTON = new FlxButton(0,0,"",can);
        cancelBUTTON.label.setFormat(l.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf",16,FlxColor.WHITE,CENTER);
        cancelBUTTON.makeGraphic(81,25,FlxColor.BLUE);
        cancelBUTTON.setGraphicSize(81,25);
        cancelBUTTON.updateHitbox();
        cancelBUTTON.text = l.curLanguage == "en" ? "CANCEL" : "ОТМЕНА";
        cancelBUTTON.x = mainMessage.x + mainMessage.width - 95;
        cancelBUTTON.y = mainMessage.y + 150;
        add(cancelBUTTON);
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

    var isOverlapping = mainMessage.overlapsPoint(FlxG.mouse.getWorldPosition());
    
    if (wasOverlapping && isOverlapping) 
    {
       inm = true;
    }

    if (wasOverlapping && !isOverlapping) 
    {
        inm = false;
    }
    
    wasOverlapping = isOverlapping;

    if (FlxG.mouse.justPressed)
    {
        if (inm == false)
        {
            this.kill();
        }
    }
    }
}
