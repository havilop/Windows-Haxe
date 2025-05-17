import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class ModernWindow extends FlxSprite
{
    
    private var titleText:FlxText;
    private var iconWindow:FlxSprite;
    public var exitWindow:FlxButton;
    var minusWindow:FlxButton;
  
    private var isDragging:Bool = false;
    private var dragOffsetX:Float = 0;
    private var dragOffsetY:Float = 0;
 
    public var canTouch:Bool;



    public function new(X:Int,title:String,?icon:String, ?OnAppear:Void->Void, DefaultExit:Null<() -> Void>,DefaultMinus:Null<() -> Void>,CanTouch:Bool)
    {
        

    

        super(0,0,"assets/images/modernWindow.png");

        super.screenCenter(XY);
        super.setGraphicSize(X,30);
        super.updateHitbox();
        
        // Создаем текстовое поле для заголовка
        titleText = new FlxText(this.x + 30, this.y - 3, this.width - 40, title);
        titleText.setFormat(null, 16, FlxColor.WHITE, LEFT);
        titleText.font = "assets/fonts/my.ttf";
     
        iconWindow = new FlxSprite(this.x, this.y,icon);
    
        exitWindow = new FlxButton(this.x + this.width - 30,this.y,"", DefaultExit);
        exitWindow.label.setFormat(null, 16, FlxColor.WHITE);
        exitWindow.makeGraphic(30, 20, FlxColor.RED);
        exitWindow.label.offset.y = -2;
        exitWindow.loadGraphic("assets/images/modernexit.png");
        exitWindow.updateHitbox();

        
        minusWindow = new FlxButton(this.x + this.width - 30,this.y,"", DefaultMinus);
        minusWindow.label.setFormat(null, 16, FlxColor.WHITE);
        minusWindow.makeGraphic(30, 20, FlxColor.RED);
        minusWindow.label.offset.y = -2;
        minusWindow.loadGraphic("assets/images/modernminus.png");
        minusWindow.updateHitbox();

        canTouch = CanTouch;

        OnAppear();
     


    }
    override public function draw():Void
        {
            super.draw(); // Рисуем окно
            iconWindow.draw();
            exitWindow.draw();
            minusWindow.draw();
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
                exitWindow.x = this.x + this.width - 48;
                exitWindow.y = this.y;

                minusWindow.x = this.x + this.width - 90;
                minusWindow.y = this.y;

                titleText.x = this.x + 30;
                titleText.y = this.y;

                iconWindow.x = this.x;
                iconWindow.y = this.y;

            }


}