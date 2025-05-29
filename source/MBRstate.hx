import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import haxe.Json;
import haxe.Timer;
import sys.FileSystem;
import sys.io.File;

typedef Mbr = {
    var isWindowsInstalled:Bool;
    var OOBE:Bool;
    var bootloader:String;
} 

class MBRstate extends FlxState
{
    var o:Mbr;
    var textMBR:FlxText;
    var checkMBRstatus:Bool = false;
    var error:CustomWindow;
    var allow:Bool = false;

    override function create() {
        super.create();

        FlxG.mouse.visible = false;
        FlxG.autoPause = false;
        if (FileSystem.exists("assets/data/settings.json")) 
            {
                try 
                {
                    var data = File.getContent("assets/data/settings.json");
                    o = Json.parse(data);
                }
            }

            textMBR = new FlxText(0,FlxG.height - 60,0,"Checking... MBR File",42);
            add(textMBR);
            Timer.delay(function MBRSTATUS() {
                checkMBRstatus = true;
            }, 2000);

   
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

                  if (FlxG.keys.justPressed.F10)
                {
                     FlxG.switchState(Console.new);
                }
        if (o.isWindowsInstalled == false && checkMBRstatus == true && allow == false)
        {
            var folderPath = "assets/Windows"; // Путь к папке (можно изменить)
            var filePath = folderPath + "/mbr.json"; // Полный путь к файлу
    
            // Проверяем, существует ли папка, если нет — создаём
            if (!FileSystem.exists(filePath)) 
            {
                if (FlxG.keys.justPressed.ESCAPE)
                    {
                        FlxG.switchState(BIOState.new);            
                    }
                textMBR.text = "MBR File not Found or it corrupdet, Please Install/Reinstall Windows";
            } 
            if (FileSystem.exists(folderPath) && o.isWindowsInstalled == false) 
            {
                if (FlxG.keys.justPressed.ESCAPE)
                    {
                        FlxG.switchState(BIOState.new);            
                    }
                    textMBR.y = FlxG.height - 100;
                textMBR.text = "Windows Folder Find, Please Fix MBR\nPress F10 to Open Console";
            }      
      
          
            }
            if (o.isWindowsInstalled == true && checkMBRstatus == true && o.OOBE == true)
                {
                    LoadState.setLoadingScreen(2000,OOBE.new);
                }
                if (o.isWindowsInstalled == true && checkMBRstatus == true && o.OOBE == false)
                    {
                        var folderPat = "assets/Windows"; // Путь к папке (можно изменить)
                        var filePat = folderPat + "/mbr.json"; // Полный путь к файлу
                
                        // Проверяем, существует ли папка, если нет — создаём
                        if (FileSystem.exists(filePat)) 
                        {
                            try 
                            {
                                var dat = File.getContent("assets/Windows/mbr.json");
                                o = Json.parse(dat);

                                if (o.bootloader == "MBR")
                                {
                                    FlxG.switchState(Windows.new);
                                }
                                if (o.bootloader != "MBR")
                                    {
                                        if (FlxG.keys.justPressed.ESCAPE)
                                            {
                                                FlxG.switchState(BIOState.new);            
                                            }
                                        textMBR.text = "MBR File not Found or it corrupdet, Please Install/Reinstall Windows";
                                    }
                            }
                           
                        } 
                        if (!FileSystem.exists(filePat)) 
                            {
                                if (FlxG.keys.justPressed.ESCAPE)
                                    {
                                        FlxG.switchState(BIOState.new);            
                                    }
                                textMBR.text = "MBR File not Found or it corrupdet, Please Install/Reinstall Windows";
                            } 
                      

                    }
    }
    override function destroy() {
        super.destroy(); // Важно вызывать родительский destroy!
    }
}