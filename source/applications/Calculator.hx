package applications;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.FlxSprite;

class Calculator extends App
{
    var window:ModernWindow;
    var bg:FlxSprite;
    var oneButton:FlxButton;
    var twoButton:FlxButton;
    var threeButton:FlxButton;
    var fourButton:FlxButton;
    var fiveButton:FlxButton;
    var sixButton:FlxButton;
    var sevenButton:FlxButton;
    var eightButton:FlxButton;
    var nineButton:FlxButton;
    var zeroButton:FlxButton;
    var plusButton:FlxButton;
    var minusButton:FlxButton;
    var equalButton:FlxButton;
    var cButton:FlxButton;
    var isplus:Bool;
    var outputText:FlxText;
    var storedText:String = '';
    function number(Int:Int) 
    {
      storedText += Std.string(Int);
    }
    function sumFromString(input:String):Int {
    var parts = isplus == true ? input.split("+") : input.split("-");
  
    var sum = 0;
    for (part in parts) {
      if (isplus == true)
      {
         sum += Std.parseInt(part);
      }
      if (isplus == false)
      {
    var num1 = Std.parseInt(parts[0]);
    var num2 = Std.parseInt(parts[1]);
    var x = num1 - num2;
    var n = Std.string(x);
        sum = Std.parseInt(n);
      }
       
    }
    
    return sum;
}
    function equal() {
      var e = sumFromString(storedText);
      var n = Std.string(e);
      storedText = n;
    }
    public function addUI() 
    {
        bg = new FlxSprite(0,0,'assets/images/setup/bg.png');
        bg.setGraphicSize(322,501);
        bg.updateHitbox();
        bg.color = 0x272729;
        add(bg);

        outputText = new FlxText(0,0,0,"",36);
        outputText.alignment = RIGHT;
        outputText.font = 'assets/fonts/my.ttf';
        add(outputText);


        oneButton = new FlxButton(0,0,"1",function name() {
          number(1);
        });
        oneButton.makeGraphic(65,65,FlxColor.GRAY);
        oneButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        oneButton.updateHitbox();
        add(oneButton);

        twoButton = new FlxButton(0,0,"2",function name() {
          number(2);
        });
        twoButton.makeGraphic(65,65,FlxColor.GRAY);
        twoButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        twoButton.updateHitbox();
        add(twoButton);

        threeButton = new FlxButton(0,0,"3",function name() {
          number(3);
        });
        threeButton.makeGraphic(65,65,FlxColor.GRAY);
        threeButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        threeButton.updateHitbox();
        add(threeButton);

        fourButton = new FlxButton(0,0,"4",function name() {
          number(4);
        });
        fourButton.makeGraphic(65,65,FlxColor.GRAY);
        fourButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        fourButton.updateHitbox();
        add(fourButton);

        fiveButton = new FlxButton(0,0,"5",function name() {
          number(5);
        });
        fiveButton.makeGraphic(65,65,FlxColor.GRAY);
        fiveButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        fiveButton.updateHitbox();
        add(fiveButton);

        sixButton = new FlxButton(0,0,"6",function name() {
          number(6);
        });
        sixButton.makeGraphic(65,65,FlxColor.GRAY);
        sixButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        sixButton.updateHitbox();
        add(sixButton);

        sevenButton = new FlxButton(0,0,"7",function name() {
          number(7);
        });
        sevenButton.makeGraphic(65,65,FlxColor.GRAY);
        sevenButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        sevenButton.updateHitbox();
        add(sevenButton);

        eightButton = new FlxButton(0,0,"8",function name() {
          number(8);
        });
        eightButton.makeGraphic(65,65,FlxColor.GRAY);
        eightButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        eightButton.updateHitbox();
        add(eightButton);

        nineButton = new FlxButton(0,0,"9",function name() {
          number(9);
        });
        nineButton.makeGraphic(65,65,FlxColor.GRAY);
        nineButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        nineButton.updateHitbox();
        add(nineButton);

        zeroButton = new FlxButton(0,0,"0",function name() {
          number(0);
        });
        zeroButton.makeGraphic(65,65,FlxColor.GRAY);
        zeroButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        zeroButton.updateHitbox();
        add(zeroButton);

        plusButton = new FlxButton(0,0,"+",function name() {
          storedText += Std.string("+");
          isplus = true;
        });
        plusButton.makeGraphic(65,65,FlxColor.GRAY);
        plusButton.label.setFormat('assets/fonts/my.ttf',32,FlxColor.WHITE,CENTER);
        plusButton.updateHitbox();
        add(plusButton);

        minusButton = new FlxButton(0,0,"-",function name() {
          storedText += Std.string("-");
          isplus = false;
        });
        minusButton.makeGraphic(65,65,FlxColor.GRAY);
        minusButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        minusButton.updateHitbox();
        add(minusButton);

        equalButton = new FlxButton(0,0,"=",function name() {
         equal();
        });
        equalButton.makeGraphic(65,65,FlxColor.fromRGB(16,156,238));
        equalButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.BLACK,CENTER);
        equalButton.updateHitbox();
        add(equalButton);

        cButton = new FlxButton(0,0,"C",function name() {
          storedText = '';
        });
        cButton.makeGraphic(65,65,FlxColor.GRAY);
        cButton.label.setFormat('assets/fonts/my.ttf',25,FlxColor.WHITE,CENTER);
        cButton.updateHitbox();
        add(cButton);
    }
    public function new() 
    {
        super();
        super.taskbar("calc");

          window = new ModernWindow(322,'Calculator','assets/images/icons/calc.png',
          function appear() 
          {
            addUI();
          }, function exit()
          {
            App.listApplications.remove("calc");
            TaskBar.isClear = true;
            this.kill();
          }, function minus() {
            this.visible = false;
             for (i in this)
            {
                i.active = false;
            }
            window.isDragging = false;
          },true);
          window.screenCenter(XY);
          window.y -= 50;
          add(window);
    }
    override function update(elapsed:Float) {
        super.update(elapsed);

        bg.x = window.x;
        bg.y = window.y + 28;

        outputText.x = window.x + 10;
        outputText.y = window.y + 40;
        outputText.text = storedText;

        oneButton.x = window.x + 5;
        oneButton.y = window.y + 150;

        twoButton.x = oneButton.x + 70;
        twoButton.y = oneButton.y;

        threeButton.x = twoButton.x + 70;
        threeButton.y = twoButton.y;

        plusButton.x = threeButton.x + 70;
        plusButton.y = threeButton.y;

        fourButton.x = window.x + 5;
        fourButton.y = window.y + 225;

        fiveButton.x = fourButton.x + 70;
        fiveButton.y = fourButton.y;

        sixButton.x = fiveButton.x + 70;

        sixButton.y = fiveButton.y;

        minusButton.x = sixButton.x + 70;
        minusButton.y = sixButton.y;

        sevenButton.x = window.x + 5;
        sevenButton.y = window.y + 300;

        eightButton.x = sevenButton.x + 70;
        eightButton.y = sevenButton.y;

        nineButton.x = eightButton.x + 70;
        nineButton.y = eightButton.y;

        equalButton.x = nineButton.x + 70;
        equalButton.y = nineButton.y;

        zeroButton.x = window.x + 75;
        zeroButton.y = window.y + 375;

        cButton.x = window.x + 215;
        cButton.y = zeroButton.y;
    }
}