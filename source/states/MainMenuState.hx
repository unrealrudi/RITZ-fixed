package states;

import flixel.effects.FlxFlicker;
import flixel.math.FlxAngle;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.addons.display.FlxTiledSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxG;
import ui.MenuItem;

class MainMenuState extends flixel.FlxState
{
    public static var textMenuItems:Array<String> = [
        'Adventure Mode',
        'Race Mode',
        'Gallery',
        'Options',
        'Credits'
    ]; 
    
    var cheese:FlxTiledSprite;
    var menuItems:FlxTypedGroup<MenuItem>;
    var selectedMenuItemIndex:Int = -1;

    override function create()
    {
        FlxG.autoPause = false;
        FlxG.sound.playMusic('assets/music/ultracheddar' + BootState.soundEXT, OptionsSubState.masterVol * OptionsSubState.musicVol);

        var cheeseBG:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFf2a348);
        add(cheeseBG);

        cheese = new FlxTiledSprite("assets/images/ui/main_menu/cheese.png", FlxG.width, FlxG.height);
        cheese.scrollX = 10;
        cheese.scrollY = 10;
        add(cheese);

        menuItems = new FlxTypedGroup<MenuItem>();
        for (i in 0...textMenuItems.length) {
            var menuItem:MenuItem = new MenuItem(0, i * 60, textMenuItems[i], onMenuItemClicked, onMenuItemHovered);
            menuItems.add(menuItem);
        }
        add(menuItems);

        persistentDraw = persistentUpdate = true;
        
        super.create();
    }
    
    function onMenuItemClicked(index:Int) {
        FlxG.log("Menu item clicked: " + textMenuItems[index]);
    }
    
    function onMenuItemHovered(index:Int) {
        if (selectedMenuItemIndex != index) {
            if (selectedMenuItemIndex >= 0) {
                menuItems.members[selectedMenuItemIndex].text.color = FlxColor.WHITE;
            }
            menuItems.members[index].text.color = FlxColor.BLUE;
            selectedMenuItemIndex = index;
        }
    }
    
    override function onMouseUp(x:Int, y:Int, button:Int)
    {
        for (i in 0...menuItems.length) {
            var menuItem:MenuItem = menuItems.members[i];
            if (menuItem.overlapsPoint(x, y)) {
                menuItem.onClick();
            }
        }
    }

    override function update(elapsed:Float) {

        super.update(elapsed);

        var scrollShit:Float = FlxG.height * 0.3 * 0.25 * FlxG.elapsed;
        cheese.alpha = 0.1;
        cheese.scrollX -= scrollShit;
        cheese.scrollY += scrollShit;
    }
}
