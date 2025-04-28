import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.macro.Expr.Function;

class CustomWindow extends FlxSprite
{
    
    private var titleText:FlxText;
    private var iconWindow:FlxSprite;
    public var exitWindow:FlxButton;
  
    private var isDragging:Bool = false;
    private var dragOffsetX:Float = 0;
    private var dragOffsetY:Float = 0;
 
    public var canTouch:Bool;



    public function new(X:Int,Y:Int,title:String,icon:String, ?OnAppear:Void->Void, DefaultExit:Null<() -> Void>, CanTouch:Bool)
    {
        

    

        super(0,0,"assets/images/window.png");

        super.screenCenter(XY);
        super.setGraphicSize(X,Y);
        super.updateHitbox();
        
        // Создаем текстовое поле для заголовка
        titleText = new FlxText(this.x + 30, this.y, this.width - 40, title);
        titleText.setFormat(null, 16, FlxColor.BLACK, LEFT);
        titleText.font = "assets/fonts/my.ttf";
     
        iconWindow = new FlxSprite(this.x, this.y,icon);
    
        exitWindow = new FlxButton(this.x + this.width - 30,this.y,"", DefaultExit);
        exitWindow.label.setFormat(null, 16, FlxColor.WHITE);
        exitWindow.makeGraphic(30, 20, FlxColor.RED);
        exitWindow.label.offset.y = -2;
        exitWindow.loadGraphic("assets/images/exit.png");
        exitWindow.updateHitbox();

        canTouch = CanTouch;

        OnAppear();
     


    }
    override public function draw():Void
        {
            super.draw(); // Рисуем окно
            iconWindow.draw();
            exitWindow.draw();
            titleText.draw(); // Рисуем текст поверх окна
        }
        override public function update(elapsed:Float):Void
            {
                super.update(elapsed);

                if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(this) && canTouch == true)
                    {
                        isDragging = true;
                        dragOffsetX = FlxG.mouse.x - this.x;
                        dragOffsetY = FlxG.mouse.y - this.y;
                    }
                    
                    if (FlxG.mouse.justReleased)
                    {
                        isDragging = false;
                    }
                    
                    if (isDragging)
                    {
                        this.x = FlxG.mouse.x - dragOffsetX;
                        this.y = FlxG.mouse.y - dragOffsetY;
                    }
                




                exitWindow.update(elapsed);
                
                // Обновляем позицию кнопки при изменении позиции окна
                exitWindow.x = this.x + this.width - 30;
                exitWindow.y = this.y;

                titleText.x = this.x + 30;
                titleText.y = this.y;

                iconWindow.x = this.x;
                iconWindow.y = this.y;

            }


}