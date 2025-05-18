import flixel.group.FlxGroup;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

typedef Des = 
{
    var folder_:String;
} 
class Desktop extends FlxGroup
{
    var o:Des;
    public function new() 
    {
        super();

        if (FileSystem.exists("assets/Windows/mbr.json"))
        {
            try 
            {
                var data = File.getContent("assets/Windows/mbr.json");
                o = Json.parse(data);
            }
        }
    }
}