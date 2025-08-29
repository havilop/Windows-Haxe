package states;

import applications.Notepad;
import flixel.FlxG;
import applications.Explorer;
import applications.ConsoleApp;
import flixel.FlxState;

class DebugState extends FlxState 
{
    var console:Notepad;

    override function create() 
    {
        super.create();
FlxG.mouse.visible = true;
        console = new Notepad();
        add(console);
    }   
    override function update(elapsed:Float) 
    {
        super.update(elapsed);
    }
}