package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;


typedef Settings = {
	public var isWindowsInstalled:Bool;
} 


class SetupState extends FlxState
{
	public var cursor:FlxSprite;
    public var isSystemCursor:Bool = true;
	public var backgroundSetup:FlxSprite;

	public var windowSetupWindow:CustomWindow;
    public var confirmMenu:CustomWindow;
    public var confirmMessageBox:FlxSprite;
    public var confirmButtonOK:FlxButton;
	public var alsoClick:Bool = true;


	override public function create()
	{
		super.create();
		FlxG.mouse.useSystemCursor = isSystemCursor;

if (FileSystem.exists("assets/data/settings.json")) 
{
	try 
	{
		var data = File.getContent("assets/data/settings.json");
		var o:Settings = Json.parse(data);

        if (o.isWindowsInstalled == false) 
		{
			backgroundSetup = new FlxSprite(0,0,"assets/images/setup/bgsetup.png");
			backgroundSetup.screenCenter(X);
			add(backgroundSetup);	

          windowSetupWindow = new CustomWindow(1000,600,"Windows Setup","assets/images/icons/WindowsInstaller.png",
		  function name() 
			{
			trace("Success");
		    }, 
			function name() 
			{

            if (alsoClick == true) {
              confirmMenu = new CustomWindow(600,300,"Attention","assets/images/icons/WindowsInstaller.png",function name() {
				trace("AppearConfirmMenu");

				confirmMessageBox = new FlxSprite(350,150,"assets/images/setup/confirm.png");
				confirmMessageBox.screenCenter(XY);
				confirmMessageBox.x += 50;
				add(confirmMessageBox);

				confirmButtonOK = new FlxButton(0,0,"OK",function name() {Sys.exit(0);});
				confirmButtonOK.screenCenter(XY);
				confirmButtonOK.y += 100;
				confirmButtonOK.x -= 57;
				confirmButtonOK.label.setFormat("assets/fonts/my.ttf", 16, FlxColor.BLACK);
				confirmButtonOK.makeGraphic(60, 20, FlxColor.GRAY);
				add(confirmButtonOK);
            alsoClick = false;
			  


			}, function name(){

				alsoClick = true;
			   confirmMessageBox.kill();
               confirmMenu.kill();
			   confirmButtonOK.kill();
			}, false);
           confirmMenu.x += 250;
		   confirmMenu.y += 150;
           add(confirmMenu);
		     }
		    }, true);
		  add(windowSetupWindow);

		}
		if (o.isWindowsInstalled == true)
			{
				FlxG.switchState(MBRstate.new);	
			}
	}
}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);



	}
}
