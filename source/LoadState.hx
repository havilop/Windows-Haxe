import flixel.FlxG;
import flixel.FlxState;
import haxe.Timer;

class LoadState extends FlxState
{
    override function create() {
        super.create();
        FlxG.mouse.visible = false;
        Timer.delay(function name() {
          FlxG.switchState(SetupState.new);
        }, 2000);

    }
    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}