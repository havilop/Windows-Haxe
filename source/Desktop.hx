import applications.Explorer.ItemExplorer;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

class Desktop extends FlxGroup
{
    var itemsDesktop:FlxTypedGroup<ItemExplorer>;
    var currentPath:String = "";

    public function new() 
    {
        super();

        itemsDesktop = new FlxTypedGroup<ItemExplorer>();
        add(itemsDesktop);

        currentPath = 'assets/Windows/Users/s/Desktop';

        updateItems();
    }
    function updateItems() {
        var items:Array<String> = FileSystem.readDirectory(currentPath);

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
            itemsDesktop.add(item);
        }
    }
}