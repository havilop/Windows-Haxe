import haxe.Timer;
import flixel.group.FlxGroup;
import applications.ConsoleApp;
class CommandFunction extends FlxGroup
{
    public function new(command:String) 
    {
        super();
        var console = new ConsoleApp();
        console.onConsoleCommandEntered(command,"enter");
        add(console);

        Timer.delay(function name() {
            App.listApplications.remove("console");
            this.kill();
        },5);
    }
}