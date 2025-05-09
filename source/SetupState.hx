package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.Json;
import haxe.Timer;
import sys.FileSystem;
import sys.io.File;


typedef Settings = {
	public var isWindowsInstalled:Bool;
	public var stepOne:Bool;
	public var stepTwo:Bool;
	var OOBE:Bool;
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
	public var confirmButtonOFF:FlxButton;
	public var alsoClick:Bool = true;
	public var start:Bool;
	public var allow:Bool = false;

	public var logoWindows:FlxSprite;
	public var background:FlxSprite;
	public var installButton:FlxButton;
	public var diskText:FlxText;
	public var disk:FlxSprite;
	public var diskChoose:FlxSprite;
	public var bar:FlxSprite;
	public var nextButton:FlxButton;
	public var barChoose:FlxButton;

	public var o:Settings;
	public var ready:Bool = false;
	public var allowText:Bool = false;
	public var text:FlxText;
	
	override public function create()
	{
		super.create();
		FlxG.autoPause = false;
		FlxG.mouse.useSystemCursor = isSystemCursor;


	
		



if (FileSystem.exists("assets/data/settings.json")) 
{
	try 
	{
		var data = File.getContent("assets/data/settings.json");
		o = Json.parse(data);

		function step() {
			o.stepOne = true;
			File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
			logoWindows.kill();
			installButton.kill();
			FlxG.switchState(SetupState.new);
		}
		function steptwo() {
			o.stepTwo = true;
			o.stepOne = false;
			File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
		background.kill();
		bar.kill();
		diskChoose.kill();
		diskText.kill();
		disk.kill();
		nextButton.kill();
		text.kill();
		barChoose.kill();
			FlxG.switchState(SetupState.new);
		}


        if (o.isWindowsInstalled == false) 
		{
			backgroundSetup = new FlxSprite(0,0,"assets/images/setup/bgsetup.png");
			backgroundSetup.setGraphicSize(2000,2000);
			backgroundSetup.screenCenter(X);
			add(backgroundSetup);	

          windowSetupWindow = new CustomWindow(1000,600,"Windows Setup","assets/images/icons/WindowsInstaller.png",
		  function name() 
			{
				logoWindows = new FlxSprite(0,0,"assets/images/setup/logo.png");
				logoWindows.screenCenter(XY);
				logoWindows.x += 200;
				logoWindows.y += 50;
				add(logoWindows);

				installButton = new FlxButton(0,0,null,step);
				installButton.screenCenter(XY);
				installButton.loadGraphic("assets/images/setup/installnow.png");
				installButton.x += -50;
				installButton.y += 150;
				add(installButton);

				start = true;

				if (o.stepOne == true)
					{
						logoWindows.kill();
			            installButton.kill();

						background = new FlxSprite(0,0,"assets/images/setup/bg.png");
						background.screenCenter(XY);
						add(background);

						bar = new FlxSprite(0,0,"assets/images/setup/bar.png");
						bar.screenCenter(XY);
						add(bar);

						diskText = new FlxText(0,0,0,"Where do you want to install Windows?",26);
						diskText.color = 0x35599C;
						diskText.font = "assets/fonts/my.ttf";
						diskText.screenCenter(XY);
						diskText.y -= 235;
						diskText.x -= 185;
						add(diskText);

						diskChoose = new FlxSprite(0,0,"assets/images/setup/diskChoose.png");
						diskChoose.screenCenter(XY);
						add(diskChoose);

						disk = new FlxSprite(0,0,"assets/images/disk.png");
						disk.screenCenter(XY);
						disk.setGraphicSize(60,30);
						disk.updateHitbox();
						disk.x -= 300;
						disk.y -= 120; 
						add(disk);

						text = new FlxText(0,0,0,"Please choose disk",16);
						text.color = 0x9C353E;
						text.font = "assets/fonts/my.ttf";
						text.screenCenter(XY);
						text.y += 200;
						text.x += 0;
						text.visible = false;
						add(text);


						nextButton = new FlxButton(0,0,"Next", function name() {
							if (ready == false && allowText == false) {
					text.visible = true;
							allowText = true;
							}
						
						
							if (ready == true)
							{
								steptwo();
							}
						});
						nextButton.screenCenter(XY);
						nextButton.setGraphicSize(60,30);
						nextButton.label.setFormat("assets/fonts/my.ttf", 18, FlxColor.BLACK, LEFT);
						nextButton.updateHitbox();
						nextButton.x += 450;
						nextButton.y += 250;
						add(nextButton);

						barChoose = new FlxButton(0,0,null,function name() {
							barChoose.loadGraphic("assets/images/setup/choose.png");
							barChoose.updateHitbox();
							ready = true;
						});
						barChoose.loadGraphic("assets/images/setup/none.png");
						barChoose.screenCenter(XY);
						barChoose.setGraphicSize(780,40);
						barChoose.updateHitbox();
						barChoose.x += 10;
						barChoose.y -= 140;
						add(barChoose);
					}
				 if (o.stepTwo == true)
				 {
					logoWindows.kill();
					installButton.kill();
			      

				   var barStep = new FlxSprite(0,0,"assets/images/setup/barStepTwo.png");
				   barStep.screenCenter(XY);
				   add(barStep);

				   Timer.delay(function name(){
					o.isWindowsInstalled = true;
					o.OOBE = true;
					o.stepOne = false;
					o.stepTwo = false;
					File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));
					FlxG.switchState(BIOState.new);
					var folderPath = "assets/Windows"; // Путь к папке (можно изменить)
					var filePath = folderPath + "/mbr.json"; // Полный путь к файлу
			
					// Проверяем, существует ли папка, если нет — создаём
					if (!FileSystem.exists(folderPath)) {
						FileSystem.createDirectory(folderPath);
					} else {
					}	
			
					// Создаём или перезаписываем файл mbr.json
					var content = "{ \"bootloader\": \"MBR\", \"curLanguage\": \"en\", \"wallpaper\": \"assets/images/wallpaper.png\" }"; // Содержимое JSON
					File.saveContent(filePath, content);
					trace('file: $filePath');
					
				   }, 5000);
				 }
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

				confirmButtonOK = new FlxButton(0,0,"OK",function name() {   o.stepOne = false;
					o.stepTwo = false;
					File.saveContent("assets/data/settings.json", Json.stringify(o, null,""));  Sys.exit(0);});
				confirmButtonOK.screenCenter(XY);
				confirmButtonOK.y += 100;
				confirmButtonOK.x -= 57;
				confirmButtonOK.label.setFormat("assets/fonts/my.ttf", 16, FlxColor.BLACK);
				confirmButtonOK.makeGraphic(60, 20, FlxColor.GRAY);
				add(confirmButtonOK);

				confirmButtonOFF = new FlxButton(0,0,"CANCEL",function name() { alsoClick = true;
					confirmMessageBox.kill();
					confirmMenu.kill();
					confirmButtonOFF.kill();
					confirmButtonOK.kill();
				 });
				confirmButtonOFF.screenCenter(XY);
				confirmButtonOFF.y += 100;
				confirmButtonOFF.x += 50;
				confirmButtonOFF.label.setFormat("assets/fonts/my.ttf", 16, FlxColor.BLACK);
				confirmButtonOFF.makeGraphic(80, 20, FlxColor.GRAY);
				add(confirmButtonOFF);


            alsoClick = false;
			  


			}, function name(){

				alsoClick = true;
			   confirmMessageBox.kill();
               confirmMenu.kill();
			   confirmButtonOK.kill();
			   confirmButtonOFF.kill();
			}, false);
           confirmMenu.x += 250;
		   confirmMenu.y += 150;
           add(confirmMenu);
		     }
		    }, false);
		  add(windowSetupWindow);
		

		}
		if (o.isWindowsInstalled == true)
			{
				FlxG.switchState(BIOState.new);	
			}
	}
}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (o.stepOne == true)
		{
			background.x = windowSetupWindow.x;
			background.y = windowSetupWindow.y;
if(FlxG.mouse.overlaps(barChoose) && allow == false){


			barChoose.loadGraphic("assets/images/setup/noneCover.png");
			barChoose.updateHitbox();
			allow = true;
}     
		}
	}
	override function destroy() {
		super.destroy(); // Важно вызывать родительский destroy!
		FlxG.bitmap.dumpCache();
	}
}
