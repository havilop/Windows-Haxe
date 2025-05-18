import flixel.FlxSprite;
import flixel.group.FlxGroup;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

typedef FolderData = {
    var x:Float;
    var y:Float;
    var path:String;
}

class TestDesktop extends FlxGroup
{
    var folders:Map<String, FolderData> = new Map();
    
    public function new() 
    {
        super();
        
        if (FileSystem.exists("assets/Windows/mbr.json"))
        {
            try 
            {
                var data = File.getContent("assets/Windows/mbr.json");
                var jsonData:Dynamic = Json.parse(data);
                
                // Перебираем все поля в JSON
                for (field in Reflect.fields(jsonData))
                {
                    if (StringTools.startsWith(field, "folder_"))
                    {
                        var fieldValue = Reflect.field(jsonData, field);
                        
                        if (StringTools.endsWith(field, ".x") || StringTools.endsWith(field, ".y"))
                        {
                            // Это поле с координатой, пропускаем - обработаем в основном поле
                            continue;
                        }
                        
                        // Получаем имя папки (часть после folder_)
                        var folderName = field.substr("folder_".length);
                        
                        // Создаем объект с данными
                        var folderData:FolderData = {
                            path: fieldValue,
                            x: Reflect.field(jsonData, '${field}.x') ?? 0,
                            y: Reflect.field(jsonData, '${field}.y') ?? 0
                        };
                        
                        folders.set(folderName, folderData);
                    }
                }
                
                // Создаем спрайты для каждой папки
                createFolderSprites();
            }
            catch (e:Dynamic)
            {
                trace("Error parsing JSON: " + e);
            }
        }
    }
    
    function createFolderSprites()
    {
        for (folderName => data in folders)
        {
            var sprite = new FlxSprite(data.x, data.y);
            sprite.loadGraphic("assets/images/icons/folder.png"); // Или другой метод создания спрайта
            add(sprite);
            
            // Здесь можно добавить другие свойства спрайта
            trace('Created folder sprite: $folderName at (${data.x}, ${data.y})');
        }
    }
}