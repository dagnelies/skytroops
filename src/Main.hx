package ;
import createjs.easeljs.Container;
import createjs.easeljs.Shape;
import createjs.easeljs.Stage;
import createjs.easeljs.Text;
import createjs.easeljs.Ticker;
import js.Browser;
import js.html.CanvasElement;
import js.html.Element;
import skytroops.defs.LevelDef;
import skytroops.InputCombined;
import skytroops.InputMobile;
import skytroops.InputMouse;
import skytroops.screens.LevelSelect;
import skytroops.screens.Loading;
import skytroops.screens.Menu;
import skytroops.Input;
import skytroops.InputDesktop;
import skytroops.Game;
import skytroops.Resources;
import skytroops.Sound;

/**
 * ...
 * @author dagnelies
 */
class Main
{
	static var canvas :Dynamic;
	static var stage :Stage;
	static var input :Input;
	
	static var loading :Loading;
	static var menu :Menu;
	static var levels :LevelSelect;
	static var game :Game;
	
	
	
	
	public static function main() 
	{
		//safe( init );
		init();
	}
	
	
	static function safe(fun :Void -> Void)
	{
		try
		{
			fun();
		}
		catch (e :Dynamic)
		{
			trace(e);
			trace(e.stack);
		}
	}
	
	static function init()
	{
		trace("Initializing...");
		
		canvas = cast Browser.document.getElementById("canvas");
		
		stage = new Stage(canvas);
		stage.enableMouseOver();
		/*
		Game.WIDTH = Lib.window.innerWidth;
		Game.HEIGHT = Lib.window.innerHeight;
		*/
		stage.canvas.width = Game.WIDTH;
		stage.canvas.height = Game.HEIGHT;
		
		Ticker.setFPS(60);
		Ticker.addEventListener("tick", update );
		
		loadResources();
	}
	
	static function loadResources()
	{
		trace("Load resources...");
		
		loading = new Loading();
		stage.addChild(loading);
		
		var error = null;
		Resources.onFinished = function() { 
			if (error != null)
				return;
			else
				buildMenu(); 
			};
		Resources.onProgress = function(value) { 
			if (error != null) 
				return;
			loading.setProgress(Math.floor(value * 100));
			};
		Resources.onError = function(e) { error = e; loading.setTitle(e); throw e; };
		
		Resources.load();
	}
	
	static function buildMenu()
	{
		trace("Starting...");
		
		Sound.init();
		
		//input = new InputMouse(stage);
		input = new InputCombined(stage);
		/*
		untyped
		{
			trace( Browser.window.DeviceMotionEvent );
			if( Browser.window.DeviceMotionEvent ) {
				input = new InputMobile();
			}
			else {
				input = new InputDesktop(stage);
			}
		}
		*/
		
		levels = new LevelSelect();
		levels.onSelect = onStartMission;
		menu = new Menu();
		menu.onPlay = function() {
			//goFullscreen(Browser.document.body);
			goTo(levels);
		}
		
		goTo(menu);
		
		trace("Ready");
	}
	
	static function onWin(coins)
	{
		canvas.style.cursor = "default";
		game = null;
		
		goTo(levels);
	}
	
	static function onDie(coins)
	{
		canvas.style.cursor = "default";
		game = null;
		goTo( levels );
	}
	
	static function goTo( c :Container )
	{
		if ( c == null )
			throw "Cannot go to null screen";
		
		if( loading != null )
			loading.visible = false;
			
		if( menu != null )
			menu.visible = false;
		
		if( levels != null )
			levels.visible = false;
		
		if ( game != null )
			game.visible = false;
			
		stage.removeAllChildren();
		stage.addChild(c);
		c.visible = true;
	}
	
	static function onStartMission( level :LevelDef )
	{
		game = new Game(input, level);
		game.onDie = onDie;
		game.onWin = onWin;
		game.init();
		canvas.style.cursor = "crosshair";
		
		goTo(game);
	}
	
	static function update(tick)
	{
		var dt :Float = tick.delta / 1000;
		if ( game != null && game.visible )
			game.update(dt);
			
		stage.update();
	}
	
	static function goFullscreen(el :Dynamic) {
		if(el.requestFullScreen)
			el.requestFullScreen();
		else if(el.webkitRequestFullScreen)
			el.webkitRequestFullScreen();
		else if(el.mozRequestFullScreen)
			el.mozRequestFullScreen();
	}
}