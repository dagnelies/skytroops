package skytroops;
import haxe.Timer;
import js.html.Audio;
import js.Lib;

/**
 * ...
 * @author arnaud
 */
class Sound
{
	public static var coin :Sound;
	public static var laser :Sound;
	public static var ball :Sound;
	public static var hit :Sound;
	public static var shield :Sound;
	public static var explode :Sound;
	
	public static var music :Audio;
	
	public static var sfx_volume = 0.3;
	public static var music_volume = 0.8;
	
	public static function init()
	{
		coin = new Sound("snd/coin.wav", 11, 0.5);
		laser = new Sound("snd/laser.wav", 11, 0.1);
		ball = new Sound("snd/ball.wav", 11, 0.5);
		explode = new Sound("snd/boom.wav", 11, 0.5);
		hit = new Sound("snd/hit.wav", 11, 0.8);
		
		music = cast Resources.get("music/1.ogg");
	}
	
	public static function update(dt :Float)
	{
		coin.cooldown -= dt;
		laser.cooldown -= dt;
		ball.cooldown -= dt;
		explode.cooldown -= dt;
		hit.cooldown -= dt;
	}
	
	var arr :Array<Audio>;
	var idx = 0;
	var cooldown = 0.0;
	
	public function new(filename, n, ?volume :Float = 1) 
	{
		arr = [];
		for ( i in 0...n )
		{
			arr.push( new Audio(filename) );
			arr[i].volume = volume;
		}
	}
	
	public function play()
	{
		if ( cooldown > 0 )
			return;
		idx = (idx + 1 ) % arr.length;
		arr[idx].play();
		cooldown = 0.1;
	}
	
	
	public static function main() 
	{
		init();
		go();
	}
	public static function go() 
	{
		explode.play();
		Timer.delay(go, 10);
	}
}