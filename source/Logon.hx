import flixel.FlxSprite;
import flixel.addons.ui.FlxUIInputText;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

typedef MbrSettings = {
    var userName:String;
    var password:String;
    var curLanguage:String;
} 

class Logon extends FlxGroup
{
    private var bg:FlxSprite;
    static public var logon:Bool;
    private var user:FlxSprite;
    private var inputPassword:FlxUIInputText;
    private var userNameText:FlxText;
    private var o:MbrSettings;
    private var is:Bool;
    private var Next:FlxButton;
    private var timeText:FlxText;

    public function new() {
        super();

        function click() {
            if (is == true)
            {
                if (o.password == inputPassword.text)
                {
                    logon = false;
             this.kill();
                }
            }
            if (is == false) 
            {
                logon = false;
                this.kill();
            }
        }
        if (FileSystem.exists("assets/Windows/mbr.json")) 
                        {
                            try 
                            {
                                var dat = File.getContent("assets/Windows/mbr.json");
                                o = Json.parse(dat);
                            }
                        }

        bg = new FlxSprite(0,0,"assets/images/wallpaperdark.png");
        bg.screenCenter(X);
        add(bg);

        user = new FlxSprite(0,0,"assets/images/user.png");
        user.screenCenter(XY);
        user.y -= 100;
        add(user);

        timeText = new FlxText(10, 10, 0, "", 32);
        timeText.font = "assets/fonts/my.ttf";
        timeText.color = FlxColor.WHITE;
        timeText.alignment = LEFT;
        add(timeText);

        userNameText = new FlxText(0,0,0,"",45);
                userNameText.color = 0xFFFFFF;
                userNameText.font =  "assets/fonts/my.ttf";
                userNameText.text = o.userName;
                userNameText.screenCenter(XY);
                userNameText.y += 50;
                add(userNameText);

                Next = new FlxButton(0,0,"Next",click);
                Next.label.setFormat(o.curLanguage == "en" ? "assets/fonts/my.ttf" : "assets/fonts/ots.ttf", 22, 0x000000, CENTER);
                Next.makeGraphic(100,28,FlxColor.WHITE);
				Next.updateHitbox();
                Next.visible = true;
                Next.text = o.curLanguage == "en" ? "Next" : "Далее";
                add(Next);

        if (o.password != "") {
             inputPassword = new FlxUIInputText(100,50,200,"",16);
                inputPassword.font = "assets/fonts/my.ttf";
                inputPassword.visible = true;
                inputPassword.screenCenter(XY);
                inputPassword.y += 100;
                add(inputPassword);
            Next.screenCenter(XY);
            Next.y += 150;
            is = true;

        }  
        if (o.password == "") {
            Next.screenCenter(XY);
            Next.y += 100;
            is = false;
        }
        
updateTime();
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        updateTime();
    }
     private function updateTime():Void
    {
        var now = Date.now();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var day = now.getDate();
        var month = now.getMonth() + 1;
        var year = now.getFullYear();
        
    
        var timeStr = StringTools.lpad(Std.string(hours), "0", 2) + ":" + 
                      StringTools.lpad(Std.string(minutes), "0", 2);
        
      
        var dateStr = StringTools.lpad(Std.string(day), "0", 2) + "." + 
                      StringTools.lpad(Std.string(month), "0", 2) + "." + 
                      Std.string(year);
        
      
        timeText.text = timeStr + "\n" + dateStr;
        
       
        timeText.width = timeText.textField.textWidth + 10;
    }
}
