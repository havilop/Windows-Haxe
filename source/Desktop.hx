import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

class Desktop extends FlxGroup
{
    var itemsDesktop:FlxTypedGroup<FlxSpriteGroup>;

    public function new() 
    {
        super();

        itemsDesktop = new FlxTypedGroup();
        add(itemsDesktop);
    }
}