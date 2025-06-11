package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.typeLimit.NextState;
import haxe.Timer;
import states.BIOState;
import states.LoadState;
import states.MBRstate;
import states.OOBEState;
import states.SetupState;
import states.WindowsState;

class LoadState extends FlxState
{

static public function setLoadingScreen(time:Int,state:NextState) {
    FlxG.switchState(LoadState.new);
    Timer.delay(function name() {
        FlxG.switchState(state);
      }, time);
}


    override function create() {
        super.create();
        FlxG.mouse.visible = false;
        App.isWindowsState = false;
    


    }
    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}