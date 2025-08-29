package applications;

import states.WindowsState;
import haxe.Json;
import haxe.Timer;
import hscript.Interp;
import hscript.Parser;
import sys.io.File;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxBasic;
import sys.FileSystem;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.addons.ui.FlxUIInputText;
import flixel.FlxSprite;

class Explorer extends App 
{
    var window:ModernWindow;
    var bg:FlxSprite;
    var bgupItems:FlxSprite;
    var buttonBack:FlxButton;
    var buttonDelete:FlxButton;
    var buttonCreate:FlxButton;
    var fieldName:FlxUIInputText;
    var itemsExplorer:FlxTypedGroup<ItemExplorer>;
    var buttonBackRED:FlxButton;
    var isField:Bool = false;
    public static var isClose:Bool = false;
    public static var isUpdate:Bool = false;
    public static var currentPath:String;
    public static var closeAlso:Bool = false;

    function Appear() 
    {
        currentPath = "assets";

        bg = new FlxSprite(0,0,'assets/images/setup/bg.png');
        bg.setGraphicSize(1173,699);
        bg.updateHitbox();
        bg.color = 0x202022;
        add(bg);

        bgupItems = new FlxSprite(0,0,'assets/images/setup/bg.png');
        bgupItems.setGraphicSize(1173,90);
        bgupItems.color = 0x18181A;
        bgupItems.updateHitbox();
        add(bgupItems);

        buttonBackRED = new FlxButton(0,0,'');
        buttonBackRED.loadGraphic("assets/images/explorer/backRED.png");
        buttonBackRED.setGraphicSize(50,50);
        buttonBackRED.updateHitbox();
        add(buttonBackRED);

        buttonBack = new FlxButton(0,0,'',toParent);
        buttonBack.loadGraphic("assets/images/explorer/back.png");
        buttonBack.setGraphicSize(50,50);
        buttonBack.updateHitbox();
        add(buttonBack);

   /*     buttonDelete = new FlxButton(0,0,'',function name() {});
        buttonDelete.loadGraphic("assets/images/explorer/delete.png");
        buttonDelete.setGraphicSize(50,50);
        buttonDelete.updateHitbox();
        add(buttonDelete);*/

        fieldName = new FlxUIInputText(0,0,300,"",16);
        fieldName.font = BackendAssets.my;
        fieldName.visible = false;
        add(fieldName);

        buttonCreate = new FlxButton(0,0,'',function name() {
            fieldName.text = "";
            fieldName.visible = true;
            isField = true;
        });
        buttonCreate.loadGraphic("assets/images/explorer/create.png");
        buttonCreate.setGraphicSize(50,50);
        buttonCreate.updateHitbox();
        add(buttonCreate);

        itemsExplorer = new FlxTypedGroup<ItemExplorer>();
        add(itemsExplorer);

        updateFileList();
    }
    public function updateFileList() 
    {
        trace(currentPath);
        fieldName.text = "";
        fieldName.visible = false;
        isField = false;

        buttonBack.visible = true;
         if (currentPath == "assets")
        {
            buttonBack.visible = false;
            buttonBackRED.visible = true;
        }
        itemsExplorer.clear();

        var items:Array<String> = FileSystem.readDirectory(currentPath);
        items.sort(sortItems);

        trace(items);

        for (i in items)
        {
            var fullPath:String = currentPath + "/" + i;
            trace(fullPath);
            var isFolder:Bool = FileSystem.isDirectory(fullPath);
            trace(isFolder);
            var isHaxe:Bool = BackendAssets.isFile(fullPath,"hx");
            var isTxt:Bool = BackendAssets.isFile(fullPath,"txt");
            var isImage:Bool = BackendAssets.isFile(fullPath,"png");
            var isJson:Bool = BackendAssets.isFile(fullPath,"json");
            var selfPath = fullPath;

            var item = new ItemExplorer(0,0,i,isFolder,isHaxe,isTxt,isImage,selfPath,isJson);
            itemsExplorer.add(item);
        }

    }
    
   private function sortItems(a:String, b:String):Int
    {
        var aPath:String = currentPath + "/" + a;
        var bPath:String = currentPath + "/" + b;
        
        var aIsDir:Bool = FileSystem.isDirectory(aPath);
        var bIsDir:Bool = FileSystem.isDirectory(bPath);
        
       
        if (aIsDir && !bIsDir) return -1;
        if (!aIsDir && bIsDir) return 1;
        
       
        return a.toLowerCase() < b.toLowerCase() ? -1 : 1;
    } 
    function toParent() 
    {
        var parts = currentPath.split("/");
        parts.pop();
        var finalvar = parts.join("/");
        currentPath = finalvar;
        updateFileList();
    }
    public function new() 
    {
        super();
        super.taskbar("explorer");

        window = new ModernWindow(1173,"Explorer","assets/images/icons/explorer.png",
        function OnAppear()
        {
            Appear();

        },function name() 
        {
            Explorer.isClose = false;
            App.listApplications.remove("explorer");
            this.updateItems();
            this.kill();
            
        },function name() 
        {
            
        }, true);
        window.screenCenter(XY);
        add(window);
    }
    override function update(elapsed:Float) 
    {
        super.update(elapsed);

        if (isUpdate == true)
        {
            updateFileList();
            isUpdate = false;
        }
        if (isClose == true && closeAlso)
        {
            App.listApplications.remove("explorer");
            this.updateItems();
            this.kill();
            Explorer.isClose = false;
            Explorer.closeAlso = false;
        }
        bg.x = window.x;
        bg.y = window.y;

        bgupItems.x = window.x;
        bgupItems.y = window.y;

        
        buttonBackRED.x = window.x + 15;
        buttonBackRED.y = window.y + 35;

        buttonBack.x = window.x + 15;
        buttonBack.y = window.y + 35;
        
        buttonCreate.x = window.x + 75;
        buttonCreate.y = window.y + 35;

    //    buttonDelete.x = window.x + 140;
    //    buttonDelete.y = window.y + 35;

        fieldName.x = window.x + 200;
        fieldName.y = window.y + 35;

        for (num => i in itemsExplorer)
        {
            var dopnummm = num <= 10 ? 0 : num <= 20 ? 0 : num <= 30 ? 0 : num <= 40 ? num - 31 : num - 31;
            var dopnumm = num <= 10 ? 0 : num <= 20 ? 0 : num <= 30 ? num - 21: num - 21;
            var dopnum = num <= 10 ? 0 : num <= 20 ? num - 11 : num - 11; 
            i.x = num <= 0 ? window.x + 35 : num <= 10 ? window.x + 35 : num <= 20 ? window.x + 150 : num <= 30 ? window.x + 250 : num <= 40 ? window.x + 365 : window.x + 365;
            i.y = num <= 0 ? (num * 50) +  100 + window.y : num <= 10 ? (num * 50) +  100 + window.y : num <= 20 ? (dopnum * 50) +  100 + window.y : num <= 30 ? (dopnumm * 50) +  100 + window.y : num <= 40 ? (dopnummm * 50) +  100 + window.y : (dopnummm * 50) +  100 + window.y;
            if (i is FlxSprite)
            {

            }
        }
        if (isField == true && fieldName.text != "" && FlxG.keys.justPressed.ENTER)
        {
            FileSystem.createDirectory(currentPath + "/" + fieldName.text);
            updateFileList();
        }
    }
}
class ItemExplorer extends FlxSpriteGroup
{
    var text:FlxText;
    var icon:FlxSprite;
    var button:FlxButton;
    var lastClickTime:Float = 0;
    var doubleClickDelay:Float = 0.3;
    var isFolder:Bool = false;
    var isHaxe:Bool = false;
    var isTxt:Bool = false;
    var isImage:Bool = false;
    var name:String;
    var isJson:Bool = false;
    var selfPath:String;
    var isPressed:Bool = false;
    var errorText:FlxText;
    var extramenu:FlxButton;

    public function new (X:Int,Y:Int,Name:String,IsFolder:Bool,IsHaxe:Bool,IsTxt:Bool,IsImage:Bool,SelfPath:String,IsJson:Bool) 
    {
        super(X,Y);

        this.isFolder = IsFolder;
        this.isHaxe = IsHaxe;
        this.isTxt = IsTxt;
        this.isImage = IsImage;
        this.name = Name;
        this.selfPath = SelfPath;
        this.isJson = IsJson;

        icon = new FlxSprite(isFolder == true ? - 25 : -30,0,null);
        icon.loadGraphic(iconSpriteLoad());
        icon.setGraphicSize(isFolder == true ? 22 : 30 ,30);
        icon.updateHitbox();
        add(icon);

        errorText = new FlxText(500,0,0,'',32);
        add(errorText);

        button = new FlxButton(0,0,name,onClick);
        button.label.setFormat(BackendAssets.my,12);
        button.color = FlxColor.BLACK;
        add(button);

        extramenu = new FlxButton(0,0,'Delete',function name() {
            try {
            if(isFolder)
            {
                FileSystem.deleteDirectory(selfPath);
                Explorer.isUpdate = true;
            } else {
            FileSystem.deleteFile(selfPath);
            Explorer.isUpdate = true;
            }
        } catch (e:Dynamic) {
            errorText.text = 'error: ' + e;
             Timer.delay(function name() {
                    errorText.text = "";
                },2000);
        }
        });
        extramenu.loadGraphic("assets/images/extramenu.png");
        extramenu.setGraphicSize(200,25);
        extramenu.label.setFormat(BackendAssets.my,14,FlxColor.WHITE,LEFT);
        extramenu.updateHitbox();
        extramenu.visible = false;
        add(extramenu);

    }
    function iconSpriteLoad() 
    {
        var pathImage:String = "";

        if (isFolder)
        {
            pathImage = "assets/images/icons/folder.png";
        }
        if (BackendAssets.isFile(name,"hx"))
        {
            pathImage = "assets/images/icons/haxe.png";
        }
        if (BackendAssets.isFile(name,"txt"))
        {
            pathImage = "assets/images/icons/notepad.png";
        }
        if (BackendAssets.isFile(name,"png"))
        {
            pathImage = "assets/images/icons/photos.png";
        }
        if (BackendAssets.isFile(name,"json"))
        {
            pathImage = "assets/images/icons/notepad.png";
        }
        return pathImage;
    }
function onClick():Void {
    var currentTime = Date.now().getTime() / 1000;
    
    if (currentTime - lastClickTime < doubleClickDelay) {
        onDoubleClick();
        lastClickTime = 0;
         } else {
        
        lastClickTime = currentTime;
    }
 }
 function onDoubleClick():Void {
    trace(isFolder);
    trace("Double click action!");

    if (isFolder)
    {
        Explorer.currentPath = Explorer.currentPath + "/" + name;
        Explorer.isUpdate = true;
    }
    if (isHaxe)
    {
        try {
        Interpritator.main(selfPath);
        } catch (e:Dynamic) {
            errorText.text = 'error: ' + e;
             Timer.delay(function name() {
                    errorText.text = "";
                },2000);
        }
    }
    if (isTxt)
    {

    }
    if (isImage)
    {
        if (Explorer.isClose == true)
        {
            Photos.pathFile = selfPath;
            Photos.updateFile();
            Explorer.closeAlso = true;
        }
        if (Explorer.isClose == false) {
        WindowsState.openApp("photos");
        Photos.pathFile = selfPath;
        }
    }
 }
 override function update(elapsed:Float) {
  super.update(elapsed);

  if(FlxG.mouse.overlaps(button) && FlxG.mouse.justPressedRight && isPressed == false)
  {
    isPressed = true;
    extramenu.x = FlxG.mouse.x;
    extramenu.y = FlxG.mouse.y;
    extramenu.visible = true;
  }
  if(FlxG.mouse.justPressed && isPressed == true)
  {
    Timer.delay(function name() {
    isPressed = false;
    extramenu.visible = false;
    },150);
   
  }
 }
}