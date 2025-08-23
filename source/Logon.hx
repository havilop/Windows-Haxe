import applications.ConsoleApp;
import haxe.Timer;
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
    var icon:String;
    var autologin:Bool;
} 

class Logon extends FlxGroup
{
    private var bg:FlxSprite;
    static public var logon:Bool;
    private var user:FlxSprite;
    var visionButton:FlxButton;
    private var inputPassword:FlxUIInputText;
    private var userNameText:FlxText;
    private var o:MbrSettings;
    private var is:Bool;
    var allow:Bool;
    var isVision:Bool = true;
    private var Next:FlxButton;
    private var timeText:FlxText;
    var wrongPassword:FlxText;

    public function new() {
        super();

        function name(s:String,s:String):Void {
            wrongPassword.visible = false;
        }
        function click() {
            if (is == true)
            {
                if (o.password == inputPassword.text)
                {
                    logon = false;
                    this.kill();
                }
                if (o.password != inputPassword.text)
                {
                    wrongPassword.font = BackendAssets.my;
                    wrongPassword.visible = true;
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
        if (o.password == "") {
            allow = true;
        }
        if (o.autologin == true)
        {
            if (allow == true)
            {
                logon = false;
                this.kill();
            }
        }
        bg = new FlxSprite(0,0,"assets/images/wallpaperdark.png");
        bg.screenCenter(X);
        add(bg);

        user = new FlxSprite(0,0,o.icon);
        user.setGraphicSize(200,200);
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
                inputPassword.passwordMode = true;
                inputPassword.callback = name;
                inputPassword.screenCenter(XY);
                inputPassword.y += 100;
                add(inputPassword);

                visionButton = new FlxButton(0,0,'',function name() {
                if (isVision == true) {
                inputPassword.passwordMode = false;
                visionButton.loadGraphic("assets/images/visionOn.png");
                 Timer.delay(function name() {
                isVision = false; 
                 },100);
                }
            
                 if (isVision == false) {
                inputPassword.passwordMode = true;
                visionButton.loadGraphic("assets/images/visionOff.png");
                isVision = true;
                }
                });
                visionButton.loadGraphic("assets/images/visionOff.png");
                visionButton.updateHitbox();
                visionButton.screenCenter(XY);
                visionButton.y = inputPassword.y;
                visionButton.x += 135;
                add(visionButton);

            Next.screenCenter(XY);
            Next.y += 150;
            is = true;
        }  
        if (o.password == "") {
            Next.screenCenter(XY);
            Next.y += 100;
            is = false;
        }
        wrongPassword = new FlxText(0,0,0,'Wrong Password', 21);
        wrongPassword.screenCenter(XY);
        wrongPassword.y += 125;
        wrongPassword.x += 40;
        wrongPassword.visible = false;
        add(wrongPassword);
        
updateTime();
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        updateTime();
        inputPassword;
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
