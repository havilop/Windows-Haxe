package states;

import flixel.FlxG;
import applications.Explorer;
import applications.ConsoleApp;
import flixel.FlxState;

class DebugState extends FlxState 
{
    var console:Explorer;

    override function create() 
    {
        super.create();
FlxG.mouse.visible = true;
        console = new Explorer();
        add(console);
    }   
    override function update(elapsed:Float) 
    {
        super.update(elapsed);
    }
}