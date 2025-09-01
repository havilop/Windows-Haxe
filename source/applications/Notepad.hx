package applications;

import flixel.util.FlxColor;
import haxe.Timer;
import sys.io.File;
import flixel.text.FlxText;
import states.WindowsState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import openfl.text.TextFormat;
import openfl.text.TextField;
import flixel.FlxSprite;

class Notepad extends App 
{
    var window:ModernWindow;
    var bg:FlxSprite;
    var textField:TextField;
    var buttonOpen:FlxButton;
    var buttonSave:FlxButton;
    var textCurrentPath:FlxText;
    var buttonClear:FlxButton;
    var textStatus:FlxText;
    var buttonRun:FlxButton;
    static public var curpath:String = 'assets';
    static public var isUpdate:Bool = false;
    static public var textinfo:String = '';

    function Appear() 
    {
        bg = new FlxSprite(0,0,'assets/images/setup/bg.png');
        bg.setGraphicSize(1200,800);
        bg.updateHitbox();
        bg.color = 0x111113;
        add(bg);

        buttonOpen = new FlxButton(0,0,"",function name() {
            WindowsState.openApp("explorer");
            Explorer.isCloseNotepad = true;
        });
        buttonOpen.loadGraphic("assets/images/apps/add.png");
        buttonOpen.updateHitbox();
        add(buttonOpen);

        buttonSave = new FlxButton(0,0,"",save);
        buttonSave.loadGraphic("assets/images/apps/save.png");
        buttonSave.updateHitbox();
        add(buttonSave);

        buttonClear = new FlxButton(0,0,"",function name() {
            textField.text = '';
        });
        buttonClear.loadGraphic("assets/images/apps/clear.png");
        buttonClear.updateHitbox();
        add(buttonClear);

        buttonRun = new FlxButton(0,0,'',function name() {
            Interpritator.main(curpath);
        });
        buttonRun.loadGraphic("assets/images/apps/run.png");
        buttonRun.updateHitbox();
        buttonRun.visible = false;
        add(buttonRun);

        textCurrentPath = new FlxText(0,0,0,'',16);
        textCurrentPath.font = BackendAssets.my;
        add(textCurrentPath);

        textStatus = new FlxText(0,0,0,'',20);
        textStatus.font = BackendAssets.my;
        add(textStatus);

        textField = new TextField();
        textField.text = "";
        textField.width = 1200;
        textField.height = 730;
        textField.background = true;
        textField.backgroundColor = 0x202022;
        textField.multiline = true;
        textField.wordWrap = true;
        textField.type = openfl.text.TextFieldType.INPUT;
        
        var format:TextFormat = new TextFormat(BackendAssets.my, 16, 0xFFFFFF);
        textField.defaultTextFormat = format;
        textField.setTextFormat(format);
        
        FlxG.stage.addChild(textField);
    }
    function save() {
            try {
            File.saveContent(textCurrentPath.text,textField.text);
            textStatus.text = "File Success Save!";
            textStatus.color = FlxColor.GREEN;
            Timer.delay(function name() {
                textStatus.text = '';
            },2000);
            } catch (e:Dynamic) {
                textStatus.text = 'Error: $e';
                textStatus.color = FlxColor.RED;
                Timer.delay(function name() {
                textStatus.text = '';
            },2000);
            }
    }
    public function new() 
    {
        super();
        super.taskbar("notepad");

        window = new ModernWindow(1200,"Notepad","assets/images/icons/notepad.png",
        function OnAppear()
        {
            Appear();
        },function name() 
        {
            FlxG.stage.removeChild(textField);
            App.listApplications.remove("notepad");
            TaskBar.isClear = true;
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
        
        if (BackendAssets.isFile(curpath,"hx"))
        {
            buttonRun.visible = true;
        } else {
            buttonRun.visible = false;
        }
        buttonOpen.x = window.x;
        buttonOpen.y = window.y + 25;

        buttonSave.x = window.x + 25;
        buttonSave.y = window.y + 25;

        buttonClear.x = window.x + 50;
        buttonClear.y = window.y + 25;

        buttonRun.x = window.x + 75;
        buttonRun.y = window.y + 25;

        textField.x = window.x;
        textField.y = window.y + 66;

        textCurrentPath.x = window.x;
        textCurrentPath.y = window.y + 47;

        textStatus.x = window.x + 600;
        textStatus.y = window.y + 40;

        if (Explorer.closeAlsoNotePad == true)
        {
            textField.text = textinfo;
            textCurrentPath.text = curpath;
        }
        if (isUpdate)
        {
        textField.text = textinfo;
        textCurrentPath.text = curpath;
        isUpdate = false;
        }

        if (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.S)
        {
            save();
        }
        if (ConsoleApp.isRestart)
        {
             FlxG.stage.removeChild(textField);
             Timer.delay(function name() {
                 ConsoleApp.isRestart = false;
             },100);
        }
    }
}