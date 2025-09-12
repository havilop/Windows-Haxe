package applications;

import flixel.FlxBasic;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;

class CustomApp extends App 
{
    var window:ModernWindow;
    public var itemsCustomApp:FlxTypedGroup<FlxSpriteGroup>;

    public function new(X:Int,title:String,icon:String)
    {
        super();
        super.taskbar(title);
        window = new ModernWindow(X,title,icon,function name() {

            itemsCustomApp = new FlxTypedGroup<FlxSpriteGroup>();
            add(itemsCustomApp);

        },function name() {
            App.listApplications.remove('$title');
            TaskBar.isClear = true;
            this.kill();
        },function name() {
            
        },true);
        add(window); 
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}