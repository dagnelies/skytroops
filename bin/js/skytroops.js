(function (console) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); };
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	Main.init();
};
Main.safe = function(fun) {
	try {
		fun();
	} catch( e ) {
		if (e instanceof js__$Boot_HaxeError) e = e.val;
		console.log(e);
		console.log(e.stack);
	}
};
Main.init = function() {
	console.log("Initializing...");
	Main.canvas = window.document.getElementById("canvas");
	Main.stage = new createjs.Stage(Main.canvas);
	Main.stage.enableMouseOver();
	Main.stage.canvas.width = skytroops_Game.WIDTH;
	Main.stage.canvas.height = skytroops_Game.HEIGHT;
	createjs.Ticker.setFPS(60);
	createjs.Ticker.addEventListener("tick",Main.update);
	Main.loadResources();
};
Main.loadResources = function() {
	console.log("Load resources...");
	Main.loading = new skytroops_screens_Loading();
	Main.stage.addChild(Main.loading);
	var error = null;
	skytroops_Resources.onFinished = function() {
		if(error != null) return; else Main.buildMenu();
	};
	skytroops_Resources.onProgress = function(value) {
		if(error != null) return;
		Main.loading.setProgress(Math.floor(value * 100));
	};
	skytroops_Resources.onError = function(e) {
		error = e;
		Main.loading.setTitle(e);
		throw new js__$Boot_HaxeError(e);
	};
	skytroops_Resources.load();
};
Main.buildMenu = function() {
	console.log("Starting...");
	skytroops_Sound.init();
	if(window.DeviceMotionEvent) Main.input = new skytroops_InputMobile(); else Main.input = new skytroops_InputMouse(Main.stage);
	Main.levels = new skytroops_screens_LevelSelect();
	Main.levels.onSelect = Main.onStartMission;
	Main.menu = new skytroops_screens_Menu();
	Main.menu.onPlay = function() {
		Main.goTo(Main.levels);
	};
	Main.goTo(Main.menu);
	console.log("Ready");
};
Main.onWin = function(coins) {
	Main.canvas.style.cursor = "default";
	Main.game = null;
	Main.goTo(Main.levels);
};
Main.onDie = function(coins) {
	Main.canvas.style.cursor = "default";
	Main.game = null;
	Main.goTo(Main.levels);
};
Main.goTo = function(c) {
	if(c == null) throw new js__$Boot_HaxeError("Cannot go to null screen");
	if(Main.loading != null) Main.loading.visible = false;
	if(Main.menu != null) Main.menu.visible = false;
	if(Main.levels != null) Main.levels.visible = false;
	if(Main.game != null) Main.game.visible = false;
	Main.stage.removeAllChildren();
	Main.stage.addChild(c);
	c.visible = true;
};
Main.onStartMission = function(level) {
	Main.game = new skytroops_Game(Main.input,level);
	Main.game.onDie = Main.onDie;
	Main.game.onWin = Main.onWin;
	Main.game.init();
	Main.canvas.style.cursor = "crosshair";
	Main.goTo(Main.game);
};
Main.update = function(tick) {
	var dt = tick.delta / 1000;
	if(Main.game != null && Main.game.visible) Main.game.update(dt);
	Main.stage.update();
};
Main.goFullscreen = function(el) {
	if(el.requestFullScreen) el.requestFullScreen(); else if(el.webkitRequestFullScreen) el.webkitRequestFullScreen(); else if(el.mozRequestFullScreen) el.mozRequestFullScreen();
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.random = function(x) {
	if(x <= 0) return 0; else return Math.floor(Math.random() * x);
};
var haxe_Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe_Timer.__name__ = true;
haxe_Timer.delay = function(f,time_ms) {
	var t = new haxe_Timer(time_ms);
	t.run = function() {
		t.stop();
		f();
	};
	return t;
};
haxe_Timer.prototype = {
	stop: function() {
		if(this.id == null) return;
		clearInterval(this.id);
		this.id = null;
	}
	,run: function() {
	}
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) Error.captureStackTrace(this,js__$Boot_HaxeError);
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js_Boot.__string_rec(o[i1],s); else str2 += js_Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
var skytroops_Entity = function() { };
skytroops_Entity.__name__ = true;
var skytroops_Obj = function(radius) {
	this.vy = 0.0;
	this.vx = 0.0;
	this.damage = 10;
	this.armor = 1;
	this.radius = 10;
	var _g = this;
	createjs.Container.call(this);
	var ss = { images : ["img/boom.png"], frames : { width : 48, height : 48, count : 7}, animations : { run : [0,7,null,2]}};
	var spriteSheet = new createjs.SpriteSheet(ss);
	this.boom_sprite = new createjs.BitmapAnimation(spriteSheet);
	this.boom_sprite.onAnimationEnd = function() {
		_g.boom_sprite.stop();
		_g.destroy();
	};
	this.addChild(this.boom_sprite);
	this.state = skytroops_State.ACTIVE;
	if(radius != null && radius > 0) this.setRadius(radius);
};
skytroops_Obj.__name__ = true;
skytroops_Obj.__interfaces__ = [skytroops_Entity];
skytroops_Obj.__super__ = createjs.Container;
skytroops_Obj.prototype = $extend(createjs.Container.prototype,{
	setRadius: function(radius) {
		this.radius = radius;
		var explosion_radius = radius;
		if(explosion_radius < 10) explosion_radius = 10;
		this.boom_sprite.scaleX = explosion_radius / 13;
		this.boom_sprite.scaleY = explosion_radius / 13;
		this.boom_sprite.x = -24 * this.boom_sprite.scaleX;
		this.boom_sprite.y = -24 * this.boom_sprite.scaleY;
	}
	,hit: function(by) {
		this.armor -= by.damage;
		if(this.armor <= 0) this.explode(); else this.onHit(this);
	}
	,update: function(dt) {
		this.x += dt * this.vx;
		this.y += dt * this.vy;
	}
	,explode: function() {
		this.state = skytroops_State.EXPLODING;
		this.boom_sprite.gotoAndPlay("run");
		this.onExplode(this);
	}
	,destroy: function() {
		this.visible = false;
		this.state = skytroops_State.DEAD;
		this.onDestroyed(this);
	}
	,onHit: function(o) {
	}
	,onExplode: function(o) {
	}
	,onDestroyed: function(o) {
	}
});
var skytroops_Ship = function(def) {
	this.weapon_cooldown = 0.0;
	this.angle = 0.0;
	skytroops_Obj.call(this);
	this.def = def;
	var img = skytroops_Resources.get(def.image);
	this.image = new createjs.Bitmap(img);
	this.image.x = -img.width / 2;
	this.image.y = -img.height / 2;
	this.addChild(this.image);
	var r = (img.width + img.height) / 4;
	this.addChild(this.image);
	this.setRadius(r);
	this.armor = def.armor;
};
skytroops_Ship.__name__ = true;
skytroops_Ship.__super__ = skytroops_Obj;
skytroops_Ship.prototype = $extend(skytroops_Obj.prototype,{
	update: function(dt) {
		if(this.def.weapon != null) this.weapon_cooldown -= dt;
		skytroops_Obj.prototype.update.call(this,dt);
	}
	,explode: function() {
		skytroops_Sound.explode.play();
		this.image.visible = false;
		skytroops_Obj.prototype.explode.call(this);
	}
	,shoot: function(target) {
		if(this.state != skytroops_State.ACTIVE || this.def.weapon == null || this.weapon_cooldown > 0) return [];
		this.weapon_cooldown = 1.0 / this.def.weapon.fire_rate;
		var dir = Math.PI / 2;
		if(this.def.weapon.aim && target != null) dir = Math.atan2(target.y - this.y,target.x - this.x);
		return this.shootFrontal(dir);
	}
	,makeBullet: function(dx,dy,dir) {
		return new skytroops_Bullet(this.def.weapon.bullet,this.x + dx,this.y + dy,dir);
	}
	,shootFrontal: function(dir) {
		var bullets = [];
		var min = -(this.def.weapon.shots - 1) / 2;
		var _g1 = 0;
		var _g = this.def.weapon.shots;
		while(_g1 < _g) {
			var i = _g1++;
			bullets.push(this.makeBullet((min + i) * 15,0,dir));
		}
		return bullets;
	}
});
var skytroops_AIShip = function(def) {
	this.acc_y = 0.0;
	this.acc_x = 0.0;
	this.va = 0.0;
	skytroops_Ship.call(this,def);
};
skytroops_AIShip.__name__ = true;
skytroops_AIShip.__super__ = skytroops_Ship;
skytroops_AIShip.prototype = $extend(skytroops_Ship.prototype,{
	shoot: function(target) {
		if(this.isInside()) return skytroops_Ship.prototype.shoot.call(this,target); else return [];
	}
	,update: function(dt) {
		this.vx += this.acc_x * dt;
		this.vy += this.acc_y * dt;
		if(this.va != 0) {
			this.angle += this.va * dt;
			this.vx = Math.cos(this.angle) * this.def.speed;
			this.vy = Math.sin(this.angle) * this.def.speed;
			this.vy += skytroops_Game.SPEED;
		}
		skytroops_Ship.prototype.update.call(this,dt);
	}
	,isInside: function() {
		return 0 < this.x && this.x < skytroops_Game.WIDTH && 0 < this.y && this.y < skytroops_Game.HEIGHT;
	}
});
var skytroops_BackgroundScrolling = function(bg_img) {
	createjs.Container.call(this);
	var _g = 0;
	while(_g < 2) {
		var i = _g++;
		var tile = new createjs.Bitmap(bg_img);
		tile.y = -1525 * i;
		this.addChild(tile);
	}
};
skytroops_BackgroundScrolling.__name__ = true;
skytroops_BackgroundScrolling.__super__ = createjs.Container;
skytroops_BackgroundScrolling.prototype = $extend(createjs.Container.prototype,{
	update: function(dt) {
		var _g = 0;
		var _g1 = this.children;
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			c.y = c.y + skytroops_Game.SPEED * dt;
			if(c.y > skytroops_Game.HEIGHT) c.y -= 3050;
		}
	}
});
var skytroops_Bullet = function(def,x,y,angle) {
	skytroops_Obj.call(this);
	this.armor = 1;
	this.damage = def.damage;
	var img = skytroops_Resources.get(def.image);
	var r = img.height / 2;
	this.setRadius(r);
	this.image = new createjs.Bitmap(img);
	this.image.x = -(img.width - r);
	this.image.y = -r;
	this.addChild(this.image);
	this.x = x;
	this.y = y;
	this.rotation = 180 * angle / Math.PI;
	this.vx = Math.cos(angle) * def.speed;
	this.vy = Math.sin(angle) * def.speed;
	this.scaleX = 1.5;
	this.scaleY = 1.5;
};
skytroops_Bullet.__name__ = true;
skytroops_Bullet.__super__ = skytroops_Obj;
skytroops_Bullet.prototype = $extend(skytroops_Obj.prototype,{
	hit: function(by) {
		this.vx = by.vx;
		this.vy = by.vy;
		skytroops_Obj.prototype.hit.call(this,by);
	}
	,explode: function() {
		this.image.visible = false;
		skytroops_Obj.prototype.explode.call(this);
	}
	,toString: function() {
		return "bullet (" + Math.round(this.x) + "," + Math.round(this.y) + ")";
	}
});
var skytroops_Coin = function(value) {
	createjs.Container.call(this);
	value = 1;
	this.value = value;
	var img;
	switch(value) {
	case 1:
		img = "img/coin_silver.png";
		break;
	case 2:
		img = "img/coin_gold.png";
		break;
	case 3:
		img = "img/coin_red.png";
		break;
	case 4:
		img = "img/coin_green.png";
		break;
	default:
		return;
	}
	var ss = { images : [img], frames : { width : 12, height : 11, count : 6}, animations : { run : [0,5,null,4]}};
	this.sprite = new createjs.BitmapAnimation(new createjs.SpriteSheet(ss));
	this.sprite.x = -12;
	this.sprite.y = -12;
	this.sprite.scaleX = 2;
	this.sprite.scaleY = 2;
	this.sprite.gotoAndPlay("run");
	this.addChild(this.sprite);
};
skytroops_Coin.__name__ = true;
skytroops_Coin.__super__ = createjs.Container;
skytroops_Coin.prototype = $extend(createjs.Container.prototype,{
	update: function(dt) {
		this.y += dt * skytroops_Game.SPEED;
	}
});
var skytroops_Collisions = function() {
};
skytroops_Collisions.__name__ = true;
skytroops_Collisions.check = function(ia,ib) {
	var $it0 = $iterator(ia)();
	while( $it0.hasNext() ) {
		var a = $it0.next();
		if(a.state != skytroops_State.ACTIVE) continue;
		var $it1 = $iterator(ib)();
		while( $it1.hasNext() ) {
			var b = $it1.next();
			if(b.state != skytroops_State.ACTIVE) continue;
			if(a != b && skytroops_Collisions.dist(a,b) < a.radius + b.radius) {
				a.hit(b);
				b.hit(a);
				if(a.state != skytroops_State.ACTIVE) break;
			}
		}
	}
};
skytroops_Collisions.dist = function(a,b) {
	var dx = b.x - a.x;
	var dy = b.y - a.y;
	return Math.sqrt(dx * dx + dy * dy);
};
var skytroops_DebugLayer = function() {
	this.avg_fps = 0.0;
	createjs.Container.call(this);
	this.fps = new createjs.Text();
	this.fps.x = 10;
	this.fps.y = 30;
	this.fps.color = "white";
	this.fps.font = "12pt sans-serif";
	this.addChild(this.fps);
	this.msg = new createjs.Text();
	this.msg.x = 10;
	this.msg.y = 50;
	this.msg.color = "white";
	this.msg.font = "12pt sans-serif";
	this.addChild(this.msg);
	setInterval($bind(this,this.update),1000);
};
skytroops_DebugLayer.__name__ = true;
skytroops_DebugLayer.__super__ = createjs.Container;
skytroops_DebugLayer.prototype = $extend(createjs.Container.prototype,{
	update: function() {
		if(this.avg_fps == 0) this.avg_fps = createjs.Ticker.getMeasuredFPS(); else this.avg_fps = (this.avg_fps + createjs.Ticker.getMeasuredFPS()) / 2;
		this.fps.text = Math.round(this.avg_fps) + " FPS";
	}
	,setMessage: function(txt) {
		this.msg.text = txt;
	}
});
var skytroops_Game = function(input,level) {
	this.wave_index = 0;
	this.seconds = 0;
	createjs.Container.call(this);
	this.input = input;
	this.level = level;
};
skytroops_Game.__name__ = true;
skytroops_Game.__super__ = createjs.Container;
skytroops_Game.prototype = $extend(createjs.Container.prototype,{
	updateShip: function(def) {
		this.player.def = def;
	}
	,init: function() {
		var _g = this;
		this.bg = new skytroops_BackgroundScrolling(this.level.bg_img);
		this.addChild(this.bg);
		this.coins = new createjs.Container();
		this.addChild(this.coins);
		this.enemies = new skytroops_Layer();
		this.addChild(this.enemies.container);
		this.player = new skytroops_PlayerShip();
		this.player.onDestroyed = function(o) {
			_g.die();
		};
		this.addChild(this.player);
		this.p_bullets = new skytroops_Layer();
		this.addChild(this.p_bullets.container);
		this.e_bullets = new skytroops_Layer();
		this.addChild(this.e_bullets.container);
		this.life_bar = new skytroops_LifeBar(skytroops_Game.WIDTH - 40,30);
		this.life_bar.x = 20;
		this.life_bar.y = 20;
		this.addChild(this.life_bar);
		this.debug_layer = new skytroops_DebugLayer();
		this.addChild(this.debug_layer);
		this.spawner = new skytroops_waves_Spawner(this.level.spawns);
		this.spawner.onSpawn = $bind(this,this.onSpawn);
		this.timer = new haxe_Timer(1000);
		this.timer.run = $bind(this,this.oncePerSecond);
		skytroops_Sound.music.play();
	}
	,onSpawn: function(ship) {
		this.enemies.add(ship);
		ship.vy += skytroops_Game.SPEED;
		ship.onDestroyed = $bind(this,this.onDestroyed);
	}
	,oncePerSecond: function() {
		console.log(this.seconds);
		this.seconds++;
		if(this.spawner.isFinished() && this.enemies.size() == 0) this.win();
	}
	,onDestroyed: function(o) {
		var ship = o;
		if(ship.def.xp <= 0) return;
		var c = new skytroops_Coin(ship.def.xp);
		c.x = o.x;
		c.y = o.y;
		this.coins.addChild(c);
	}
	,updateDebugInfo: function() {
		var msg = "";
		if(this.seconds % 60 < 10) msg += Math.floor(this.seconds / 60) + ":0" + this.seconds % 60 + "\n"; else msg += Math.floor(this.seconds / 60) + ":" + this.seconds % 60 + "\n";
		msg += "Coins: " + this.player.collected_coins;
		this.debug_layer.setMessage(msg);
	}
	,update: function(dt) {
		this.updateDebugInfo();
		skytroops_Sound.update(dt);
		this.bg.update(dt);
		this.spawner.update(dt);
		this.enemies.update(dt);
		var has_shot = false;
		var $it0 = this.enemies.iterator();
		while( $it0.hasNext() ) {
			var e = $it0.next();
			var bullets1 = e.shoot(this.player);
			if(bullets1 != null && bullets1.length > 0) {
				has_shot = true;
				var _g = 0;
				while(_g < bullets1.length) {
					var b = bullets1[_g];
					++_g;
					this.e_bullets.add(b);
					b.vx += e.vx / 3;
					b.vy += e.vy / 3;
				}
			}
		}
		if(has_shot) skytroops_Sound.ball.play();
		this.input.update(this.player,dt);
		this.player.update(dt);
		var bullets = this.player.shoot(this.input.getShootTarget());
		if(bullets != null && bullets.length > 0) {
			skytroops_Sound.laser.play();
			var _g1 = 0;
			while(_g1 < bullets.length) {
				var b1 = bullets[_g1];
				++_g1;
				this.p_bullets.add(b1);
			}
		}
		this.p_bullets.update(dt);
		this.e_bullets.update(dt);
		skytroops_Collisions.check(this.p_bullets,this.enemies);
		skytroops_Collisions.check([this.player],this.e_bullets);
		skytroops_Collisions.check([this.player],this.enemies);
		this.life_bar.setValue(this.player.armor,this.player.def.armor);
		this.updateCoins(dt);
	}
	,updateCoins: function(dt) {
		var _g = 0;
		var _g1 = this.coins.children;
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			if(c.y > skytroops_Game.HEIGHT + 10) {
				this.coins.removeChild(c);
				continue;
			}
			var cc = c;
			var dx = this.player.x - cc.x;
			var dy = this.player.y - cc.y;
			var dist = Math.sqrt(dx * dx + dy * dy);
			var tractor = skytroops_Game.TRACTOR;
			if(dist < this.player.radius) {
				skytroops_Sound.coin.play();
				this.coins.removeChild(cc);
				this.player.collected_coins++;
			} else if(dist < tractor) {
				cc.x += dt * tractor * dx / dist;
				cc.y += dt * tractor * dy / dist;
			} else cc.update(dt);
		}
	}
	,win: function() {
		var _g = this;
		var $it0 = this.enemies.iterator();
		while( $it0.hasNext() ) {
			var e = $it0.next();
			e.explode();
		}
		this.debug_layer.setMessage("You won!");
		haxe_Timer.delay(function() {
			_g.timer.stop();
			_g.onWin(_g.player.collected_coins);
		},1000);
	}
	,onWin: function(coins) {
	}
	,die: function() {
		var _g = this;
		haxe_Timer.delay(function() {
			_g.timer.stop();
			_g.onDie(_g.player.collected_coins);
		},2000);
	}
	,onDie: function(coins) {
	}
});
var skytroops_Input = function() { };
skytroops_Input.__name__ = true;
var skytroops_InputDesktop = function(stage) {
	this.shoot_target = new createjs.Point();
	this.move_dir = new createjs.Point();
	this.right = false;
	this.down = false;
	this.left = false;
	this.up = false;
	stage.onMouseMove = $bind(this,this.onMouseMove);
	window.document.onkeydown = $bind(this,this.onKeyDown);
	window.document.onkeyup = $bind(this,this.onKeyUp);
};
skytroops_InputDesktop.__name__ = true;
skytroops_InputDesktop.__interfaces__ = [skytroops_Input];
skytroops_InputDesktop.prototype = {
	onKeyDown: function(e) {
		var _g = e.keyCode;
		switch(_g) {
		case 37:case 65:
			this.left = true;
			break;
		case 38:case 87:
			this.up = true;
			break;
		case 39:case 68:
			this.right = true;
			break;
		case 40:case 83:
			this.down = true;
			break;
		}
		this.updateDir();
	}
	,onKeyUp: function(e) {
		var _g = e.keyCode;
		switch(_g) {
		case 37:case 65:
			this.left = false;
			break;
		case 38:case 87:
			this.up = false;
			break;
		case 39:case 68:
			this.right = false;
			break;
		case 40:case 83:
			this.down = false;
			break;
		}
		this.updateDir();
	}
	,updateDir: function() {
		this.move_dir.x = 0;
		this.move_dir.y = 0;
		if(this.left) this.move_dir.x -= 1;
		if(this.up) this.move_dir.y -= 1;
		if(this.right) this.move_dir.x += 1;
		if(this.down) this.move_dir.y += 1;
		if(this.move_dir.x != 0 && this.move_dir.y != 0) {
			var dist = Math.sqrt(this.move_dir.x * this.move_dir.x + this.move_dir.y * this.move_dir.y);
			this.move_dir.x /= dist;
			this.move_dir.y /= dist;
		}
	}
	,onMouseMove: function(e) {
		this.shoot_target.x = e.rawX;
		this.shoot_target.y = e.rawY;
	}
	,getMoveDir: function() {
		return this.move_dir;
	}
	,getMoveTarget: function() {
		return null;
	}
	,getShootTarget: function() {
		return this.shoot_target;
	}
	,update: function(ship,dt) {
		var dir = this.getMoveDir();
		var trg = this.getShootTarget();
		ship.vx = dir.x * ship.def.speed;
		ship.vy = dir.y * ship.def.speed;
		var dy = trg.y - ship.y;
		var dx = trg.x - ship.x;
		var dist = Math.sqrt(dx * dx + dy * dy);
	}
};
var skytroops_InputMobile = function() {
	this.init = null;
	this.target = new createjs.Point(skytroops_Game.WIDTH / 2,skytroops_Game.HEIGHT / 2);
	this.pulled = new createjs.Point(skytroops_Game.WIDTH / 2,skytroops_Game.HEIGHT / 2);
	window.addEventListener("devicemotion",$bind(this,this.onDeviceMoved));
};
skytroops_InputMobile.__name__ = true;
skytroops_InputMobile.__interfaces__ = [skytroops_Input];
skytroops_InputMobile.prototype = {
	onDeviceMoved: function(evt) {
		if(this.init == null) this.init = evt.accelerationIncludingGravity;
		this.now = evt.accelerationIncludingGravity;
	}
	,getMoveDir: function() {
		return this.target;
	}
	,getMoveTarget: function() {
		return null;
	}
	,getShootTarget: function() {
		return this.pulled;
	}
	,update: function(ship,dt) {
		var dx = -(this.now.x - this.init.x);
		var dy = this.now.y - this.init.y;
		var dist = Math.sqrt(dx * dx + dy * dy);
		var thrust = dist / 3;
		if(thrust < 0.1) return;
		if(thrust > 1) thrust = 1;
		var speed = ship.def.speed * thrust;
		ship.x += speed * dt * dx / dist;
		ship.y += speed * dt * dy / dist;
		dx = this.pulled.x - ship.x;
		dy = this.pulled.y - ship.y;
		dist = Math.sqrt(dx * dx + dy * dy);
		this.pulled.x = ship.x + 30 * dx / dist;
		this.pulled.y = ship.y + 30 * dy / dist;
	}
};
var skytroops_InputMouse = function(stage) {
	this.target = new createjs.Point(skytroops_Game.WIDTH / 2,skytroops_Game.HEIGHT / 2);
	this.pulled = new createjs.Point(skytroops_Game.WIDTH / 2,skytroops_Game.HEIGHT / 2);
	stage.onMouseMove = $bind(this,this.onMouseMove);
};
skytroops_InputMouse.__name__ = true;
skytroops_InputMouse.__interfaces__ = [skytroops_Input];
skytroops_InputMouse.prototype = {
	onMouseMove: function(e) {
		this.target.x = e.rawX;
		this.target.y = e.rawY;
	}
	,getMoveDir: function() {
		return null;
	}
	,getMoveTarget: function() {
		return this.target;
	}
	,getShootTarget: function() {
		return this.pulled;
	}
	,update: function(ship,dt) {
		var trg = this.getMoveTarget();
		var dy = trg.y - ship.y;
		var dx = trg.x - ship.x;
		var dist = Math.sqrt(dx * dx + dy * dy);
		if(dist == 0) return;
		var speed = ship.def.speed;
		if(speed * dt >= dist) {
			ship.x = trg.x;
			ship.y = trg.y;
		} else {
			ship.x += speed * dt * dx / dist;
			ship.y += speed * dt * dy / dist;
		}
		dx = this.pulled.x - ship.x;
		dy = this.pulled.y - ship.y;
		dist = Math.sqrt(dx * dx + dy * dy);
		this.pulled.x = ship.x + 30 * dx / dist;
		this.pulled.y = ship.y + 30 * dy / dist;
	}
};
var skytroops_Layer = function(width,height) {
	if(height == null) height = 960;
	if(width == null) width = 640;
	this.container = new createjs.Container();
	this.width = width;
	this.height = height;
};
skytroops_Layer.__name__ = true;
skytroops_Layer.prototype = {
	clear: function() {
		this.container.removeAllChildren();
	}
	,add: function(item) {
		this.container.addChild(item);
	}
	,iterator: function() {
		return HxOverrides.iter(this.container.children);
	}
	,update: function(dt) {
		var dead = [];
		var $it0 = this.iterator();
		while( $it0.hasNext() ) {
			var o = $it0.next();
			if(o.state == skytroops_State.DEAD || this.isOutOfBounds(o)) dead.push(o); else o.update(dt);
		}
		var _g = 0;
		while(_g < dead.length) {
			var o1 = dead[_g];
			++_g;
			this.container.removeChild(o1);
		}
	}
	,isOutOfBounds: function(obj) {
		if(obj.vx < 0 && obj.x < -obj.radius) return true;
		if(obj.vx > 0 && obj.x > this.width + obj.radius) return true;
		if(obj.vy < 0 && obj.y < -obj.radius) return true;
		if(obj.vy > 0 && obj.y > this.height + obj.radius) return true;
		return false;
	}
	,size: function() {
		return this.container.children.length;
	}
};
var skytroops_LifeBar = function(w,h) {
	createjs.Container.call(this);
	this.w = w;
	this.h = h;
	this.shape = new createjs.Shape();
	this.addChild(this.shape);
};
skytroops_LifeBar.__name__ = true;
skytroops_LifeBar.__super__ = createjs.Container;
skytroops_LifeBar.prototype = $extend(createjs.Container.prototype,{
	setValue: function(value,max) {
		this.shape.graphics.clear();
		var bg_color = "orange";
		this.shape.graphics.beginFill(bg_color).rect(0,0,this.w,this.h);
		var fg_color = "red";
		if(value > 0) this.shape.graphics.beginFill(fg_color).rect(4,4,(this.w - 8) * value / max,this.h - 8);
	}
});
var skytroops_defs_WeaponSpread = { __ename__ : true, __constructs__ : ["FRONTAL","SMALL_SPREAD","LARGE_SPREAD","XXL_SPREAD","SIDES","CLOCKWISE","COUNTER_CLOCKWISE"] };
skytroops_defs_WeaponSpread.FRONTAL = ["FRONTAL",0];
skytroops_defs_WeaponSpread.FRONTAL.toString = $estr;
skytroops_defs_WeaponSpread.FRONTAL.__enum__ = skytroops_defs_WeaponSpread;
skytroops_defs_WeaponSpread.SMALL_SPREAD = ["SMALL_SPREAD",1];
skytroops_defs_WeaponSpread.SMALL_SPREAD.toString = $estr;
skytroops_defs_WeaponSpread.SMALL_SPREAD.__enum__ = skytroops_defs_WeaponSpread;
skytroops_defs_WeaponSpread.LARGE_SPREAD = ["LARGE_SPREAD",2];
skytroops_defs_WeaponSpread.LARGE_SPREAD.toString = $estr;
skytroops_defs_WeaponSpread.LARGE_SPREAD.__enum__ = skytroops_defs_WeaponSpread;
skytroops_defs_WeaponSpread.XXL_SPREAD = ["XXL_SPREAD",3];
skytroops_defs_WeaponSpread.XXL_SPREAD.toString = $estr;
skytroops_defs_WeaponSpread.XXL_SPREAD.__enum__ = skytroops_defs_WeaponSpread;
skytroops_defs_WeaponSpread.SIDES = ["SIDES",4];
skytroops_defs_WeaponSpread.SIDES.toString = $estr;
skytroops_defs_WeaponSpread.SIDES.__enum__ = skytroops_defs_WeaponSpread;
skytroops_defs_WeaponSpread.CLOCKWISE = ["CLOCKWISE",5];
skytroops_defs_WeaponSpread.CLOCKWISE.toString = $estr;
skytroops_defs_WeaponSpread.CLOCKWISE.__enum__ = skytroops_defs_WeaponSpread;
skytroops_defs_WeaponSpread.COUNTER_CLOCKWISE = ["COUNTER_CLOCKWISE",6];
skytroops_defs_WeaponSpread.COUNTER_CLOCKWISE.toString = $estr;
skytroops_defs_WeaponSpread.COUNTER_CLOCKWISE.__enum__ = skytroops_defs_WeaponSpread;
var skytroops_defs_Bullets = function() { };
skytroops_defs_Bullets.__name__ = true;
var skytroops_PlayerShip = function() {
	this.collected_coins = 0;
	skytroops_Ship.call(this,skytroops_PlayerShip.DEFAULT);
	this.x = skytroops_Game.WIDTH / 2;
	this.y = 2 * skytroops_Game.HEIGHT / 3;
	var blades_img = skytroops_Resources.get("img/ships/heli_blades.png");
	var blades_bmp = new createjs.Bitmap(blades_img);
	blades_bmp.x = -blades_img.width / 2;
	blades_bmp.y = -blades_img.height / 2;
	this.blades = new createjs.Container();
	this.blades.addChild(blades_bmp);
	this.blades.y = -blades_img.height / 3;
	this.addChild(this.blades);
	this.target = new createjs.Shape();
	this.target.graphics.beginFill("red").arc(0,0,6,0,2 * Math.PI,false);
	this.addChild(this.target);
	this.scaleX = 1.2;
	this.scaleY = 1.2;
};
skytroops_PlayerShip.__name__ = true;
skytroops_PlayerShip.__super__ = skytroops_Ship;
skytroops_PlayerShip.prototype = $extend(skytroops_Ship.prototype,{
	shoot: function(t) {
		this.target.x = 2 * (t.x - this.x);
		this.target.y = 2 * (t.y - this.y);
		return skytroops_Ship.prototype.shoot.call(this,t);
	}
	,update: function(dt) {
		if(this.state != skytroops_State.ACTIVE) return;
		skytroops_Ship.prototype.update.call(this,dt);
		this.blades.rotation += dt * 480;
		if(this.x < 2 * this.radius) this.x = 2 * this.radius;
		if(this.x > skytroops_Game.WIDTH - 2 * this.radius) this.x = skytroops_Game.WIDTH - 2 * this.radius;
		if(this.y < 2 * this.radius) this.y = 2 * this.radius;
		if(this.y > skytroops_Game.HEIGHT - 2 * this.radius) this.y = skytroops_Game.HEIGHT - 2 * this.radius;
	}
	,toString: function() {
		return "player (" + Math.round(this.x) + "," + Math.round(this.y) + ")";
	}
});
var skytroops_Resources = function() { };
skytroops_Resources.__name__ = true;
skytroops_Resources.load = function() {
	if(skytroops_Resources.queue != null) return;
	skytroops_Resources.queue = new createjs.LoadQueue(false);
	skytroops_Resources.queue.addEventListener("progress",function(e) {
		console.log(e);
		skytroops_Resources.onProgress(e.loaded);
	});
	skytroops_Resources.queue.addEventListener("complete",function(e1) {
		skytroops_Resources.onFinished();
	});
	skytroops_Resources.queue.addEventListener("error",function(e2) {
		console.log(e2);
		skytroops_Resources.onError("Failed to load " + e2.item.src);
	});
	skytroops_Resources.queue.loadFile("img/bg/grass.png");
	skytroops_Resources.queue.loadFile("img/bg/rocky.png");
	skytroops_Resources.queue.loadFile("img/bg/islands.png");
	skytroops_Resources.queue.loadFile("img/bg/snow.png");
	skytroops_Resources.queue.loadFile("img/bg/desert.png");
	skytroops_Resources.queue.loadFile("img/ships/heli.png");
	skytroops_Resources.queue.loadFile("img/ships/heli_blades.png");
	skytroops_Resources.queue.loadFile(skytroops_defs_Bullets.BALL.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Bullets.BUBBLES.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Bullets.BULLET.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Bullets.DISK.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Bullets.MISSILE.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Bullets.SLIME.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Bullets.WAVES.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Ships.GUNNER.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Ships.SNIPER.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Ships.TROOPER.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Ships.WEAKLING.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Ships.FOLLOWER.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Ships.MINE.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Ships.TANK_LIGHT.image);
	skytroops_Resources.queue.loadFile(skytroops_defs_Ships.TANK_HEAVY.image);
	skytroops_Resources.queue.loadFile("img/ships/ufo_grabber.png");
	skytroops_Resources.queue.loadFile("snd/coin.wav");
	skytroops_Resources.queue.loadFile("snd/ball.wav");
	skytroops_Resources.queue.loadFile("snd/boom.wav");
	skytroops_Resources.queue.loadFile("snd/hit.wav");
	skytroops_Resources.queue.loadFile("music/1.ogg");
};
skytroops_Resources.get = function(path) {
	var res = skytroops_Resources.queue.getResult(path);
	if(res == null) throw new js__$Boot_HaxeError("Resource missing: " + path);
	return res;
};
skytroops_Resources.onError = function(msg) {
	console.log(msg);
};
skytroops_Resources.onFinished = function() {
	console.log("Loading finished.");
};
skytroops_Resources.onProgress = function(value) {
	console.log("Loading... " + Math.floor(value * 100) + "%");
};
var skytroops_Sound = function(filename,n,volume) {
	if(volume == null) volume = 1;
	this.cooldown = 0.0;
	this.idx = 0;
	this.arr = [];
	var _g = 0;
	while(_g < n) {
		var i = _g++;
		this.arr.push(new Audio(filename));
		this.arr[i].volume = volume;
	}
};
skytroops_Sound.__name__ = true;
skytroops_Sound.init = function() {
	skytroops_Sound.coin = new skytroops_Sound("snd/coin.wav",11,0.5);
	skytroops_Sound.laser = new skytroops_Sound("snd/laser.wav",11,0.1);
	skytroops_Sound.ball = new skytroops_Sound("snd/ball.wav",11,0.5);
	skytroops_Sound.explode = new skytroops_Sound("snd/boom.wav",11,0.5);
	skytroops_Sound.hit = new skytroops_Sound("snd/hit.wav",11,0.8);
	skytroops_Sound.music = skytroops_Resources.get("music/1.ogg");
};
skytroops_Sound.update = function(dt) {
	skytroops_Sound.coin.cooldown -= dt;
	skytroops_Sound.laser.cooldown -= dt;
	skytroops_Sound.ball.cooldown -= dt;
	skytroops_Sound.explode.cooldown -= dt;
	skytroops_Sound.hit.cooldown -= dt;
};
skytroops_Sound.main = function() {
	skytroops_Sound.init();
	skytroops_Sound.go();
};
skytroops_Sound.go = function() {
	skytroops_Sound.explode.play();
	haxe_Timer.delay(skytroops_Sound.go,10);
};
skytroops_Sound.prototype = {
	play: function() {
		if(this.cooldown > 0) return;
		this.idx = (this.idx + 1) % this.arr.length;
		this.arr[this.idx].play();
		this.cooldown = 0.1;
	}
};
var skytroops_State = { __ename__ : true, __constructs__ : ["ACTIVE","EXPLODING","DEAD"] };
skytroops_State.ACTIVE = ["ACTIVE",0];
skytroops_State.ACTIVE.toString = $estr;
skytroops_State.ACTIVE.__enum__ = skytroops_State;
skytroops_State.EXPLODING = ["EXPLODING",1];
skytroops_State.EXPLODING.toString = $estr;
skytroops_State.EXPLODING.__enum__ = skytroops_State;
skytroops_State.DEAD = ["DEAD",2];
skytroops_State.DEAD.toString = $estr;
skytroops_State.DEAD.__enum__ = skytroops_State;
var skytroops_defs_Direction = { __ename__ : true, __constructs__ : ["TOP","TOP_LEFT","TOP_RIGHT","LEFT","RIGHT","BOTTOM","BOTTOM_LEFT","BOTTOM_RIGHT"] };
skytroops_defs_Direction.TOP = ["TOP",0];
skytroops_defs_Direction.TOP.toString = $estr;
skytroops_defs_Direction.TOP.__enum__ = skytroops_defs_Direction;
skytroops_defs_Direction.TOP_LEFT = ["TOP_LEFT",1];
skytroops_defs_Direction.TOP_LEFT.toString = $estr;
skytroops_defs_Direction.TOP_LEFT.__enum__ = skytroops_defs_Direction;
skytroops_defs_Direction.TOP_RIGHT = ["TOP_RIGHT",2];
skytroops_defs_Direction.TOP_RIGHT.toString = $estr;
skytroops_defs_Direction.TOP_RIGHT.__enum__ = skytroops_defs_Direction;
skytroops_defs_Direction.LEFT = ["LEFT",3];
skytroops_defs_Direction.LEFT.toString = $estr;
skytroops_defs_Direction.LEFT.__enum__ = skytroops_defs_Direction;
skytroops_defs_Direction.RIGHT = ["RIGHT",4];
skytroops_defs_Direction.RIGHT.toString = $estr;
skytroops_defs_Direction.RIGHT.__enum__ = skytroops_defs_Direction;
skytroops_defs_Direction.BOTTOM = ["BOTTOM",5];
skytroops_defs_Direction.BOTTOM.toString = $estr;
skytroops_defs_Direction.BOTTOM.__enum__ = skytroops_defs_Direction;
skytroops_defs_Direction.BOTTOM_LEFT = ["BOTTOM_LEFT",6];
skytroops_defs_Direction.BOTTOM_LEFT.toString = $estr;
skytroops_defs_Direction.BOTTOM_LEFT.__enum__ = skytroops_defs_Direction;
skytroops_defs_Direction.BOTTOM_RIGHT = ["BOTTOM_RIGHT",7];
skytroops_defs_Direction.BOTTOM_RIGHT.toString = $estr;
skytroops_defs_Direction.BOTTOM_RIGHT.__enum__ = skytroops_defs_Direction;
var skytroops_defs_Formation = { __ename__ : true, __constructs__ : ["HORIZONTAL","VERTICAL","SLASH","BSLASH","DOWN","UP","LEFT","RIGHT","RANDOM"] };
skytroops_defs_Formation.HORIZONTAL = ["HORIZONTAL",0];
skytroops_defs_Formation.HORIZONTAL.toString = $estr;
skytroops_defs_Formation.HORIZONTAL.__enum__ = skytroops_defs_Formation;
skytroops_defs_Formation.VERTICAL = ["VERTICAL",1];
skytroops_defs_Formation.VERTICAL.toString = $estr;
skytroops_defs_Formation.VERTICAL.__enum__ = skytroops_defs_Formation;
skytroops_defs_Formation.SLASH = ["SLASH",2];
skytroops_defs_Formation.SLASH.toString = $estr;
skytroops_defs_Formation.SLASH.__enum__ = skytroops_defs_Formation;
skytroops_defs_Formation.BSLASH = ["BSLASH",3];
skytroops_defs_Formation.BSLASH.toString = $estr;
skytroops_defs_Formation.BSLASH.__enum__ = skytroops_defs_Formation;
skytroops_defs_Formation.DOWN = ["DOWN",4];
skytroops_defs_Formation.DOWN.toString = $estr;
skytroops_defs_Formation.DOWN.__enum__ = skytroops_defs_Formation;
skytroops_defs_Formation.UP = ["UP",5];
skytroops_defs_Formation.UP.toString = $estr;
skytroops_defs_Formation.UP.__enum__ = skytroops_defs_Formation;
skytroops_defs_Formation.LEFT = ["LEFT",6];
skytroops_defs_Formation.LEFT.toString = $estr;
skytroops_defs_Formation.LEFT.__enum__ = skytroops_defs_Formation;
skytroops_defs_Formation.RIGHT = ["RIGHT",7];
skytroops_defs_Formation.RIGHT.toString = $estr;
skytroops_defs_Formation.RIGHT.__enum__ = skytroops_defs_Formation;
skytroops_defs_Formation.RANDOM = ["RANDOM",8];
skytroops_defs_Formation.RANDOM.toString = $estr;
skytroops_defs_Formation.RANDOM.__enum__ = skytroops_defs_Formation;
var skytroops_defs_Weapons = function() { };
skytroops_defs_Weapons.__name__ = true;
var skytroops_defs_Ships = function() { };
skytroops_defs_Ships.__name__ = true;
var skytroops_defs_Motion = { __ename__ : true, __constructs__ : ["SPREAD","GO_AND_BACK","TURN_LEFT","TURN_RIGHT"] };
skytroops_defs_Motion.SPREAD = ["SPREAD",0];
skytroops_defs_Motion.SPREAD.toString = $estr;
skytroops_defs_Motion.SPREAD.__enum__ = skytroops_defs_Motion;
skytroops_defs_Motion.GO_AND_BACK = ["GO_AND_BACK",1];
skytroops_defs_Motion.GO_AND_BACK.toString = $estr;
skytroops_defs_Motion.GO_AND_BACK.__enum__ = skytroops_defs_Motion;
skytroops_defs_Motion.TURN_LEFT = ["TURN_LEFT",2];
skytroops_defs_Motion.TURN_LEFT.toString = $estr;
skytroops_defs_Motion.TURN_LEFT.__enum__ = skytroops_defs_Motion;
skytroops_defs_Motion.TURN_RIGHT = ["TURN_RIGHT",3];
skytroops_defs_Motion.TURN_RIGHT.toString = $estr;
skytroops_defs_Motion.TURN_RIGHT.__enum__ = skytroops_defs_Motion;
var skytroops_defs_Waves = function() { };
skytroops_defs_Waves.__name__ = true;
var skytroops_defs_Levels = function() { };
skytroops_defs_Levels.__name__ = true;
skytroops_defs_Levels.buildGrassLevel = function(n,diff) {
	return skytroops_defs_Levels.buildCustomLevel(skytroops_defs_Levels.BG_GRASS,skytroops_defs_Levels.WAVES_GRASS[n],diff,60);
};
skytroops_defs_Levels.buildCustomLevel = function(bg_img,waves,diff,duration) {
	var t = 3.0;
	var level = { bg_img : bg_img, spawns : []};
	while(t < duration) {
		var i = Std.random(waves.length);
		var w = waves[i];
		level.spawns.push({ t : t, wave : w});
		var dt = w.n * w.ship.xp / diff;
		t += dt;
	}
	return level;
};
var skytroops_gui_Button = function(label) {
	this.h = 89;
	this.w = 247;
	var _g = this;
	createjs.Container.call(this);
	var bg = new createjs.Bitmap("img/btn.png");
	this.addChild(bg);
	var txt = new createjs.Text(label,2 * this.h / 3 + "px Luckiest Guy","white");
	this.addChild(txt);
	txt.textAlign = "center";
	txt.y = -this.h / 2 + this.h / 6;
	bg.x = -this.w / 2;
	bg.y = -this.h / 2;
	this.addEventListener("mouseover",function(e) {
		txt.color = "yellow";
	});
	this.addEventListener("mouseout",function(e1) {
		txt.color = "white";
	});
	this.addEventListener("click",function(e2) {
		console.log("Button '" + label + "' clicked");
		_g.onBtnClicked();
	});
};
skytroops_gui_Button.__name__ = true;
skytroops_gui_Button.__super__ = createjs.Container;
skytroops_gui_Button.prototype = $extend(createjs.Container.prototype,{
	onBtnClicked: function() {
	}
});
var skytroops_gui_Label = function(label,fontsize) {
	if(fontsize == null) fontsize = 24;
	createjs.Text.call(this,label,fontsize + "px Luckiest Guy","white");
	this.textAlign = "center";
};
skytroops_gui_Label.__name__ = true;
skytroops_gui_Label.__super__ = createjs.Text;
skytroops_gui_Label.prototype = $extend(createjs.Text.prototype,{
});
var skytroops_levels_Level = function() {
};
skytroops_levels_Level.__name__ = true;
var skytroops_levels_Grass = function() {
	skytroops_levels_Level.call(this);
};
skytroops_levels_Grass.__name__ = true;
skytroops_levels_Grass.buildWave = function(difficulty) {
	skytroops_levels_Grass.cooldown += difficulty + 15;
	while(true) {
		var i = Std.random(skytroops_levels_Grass.WAVES.length);
		var w = skytroops_levels_Grass.WAVES[i];
		var xp = w.n * w.ship.xp * 3;
		if(xp <= skytroops_levels_Grass.cooldown) {
			skytroops_levels_Grass.cooldown -= xp;
			return w;
		}
		if(Std.random(10) == 0) return null;
	}
};
skytroops_levels_Grass.buildLevel = function(diff) {
	return skytroops_levels_Grass.buildCustomLevel(skytroops_levels_Grass.WAVES,diff,60);
};
skytroops_levels_Grass.buildCustomLevel = function(waves,diff,duration) {
	var t = 3.0;
	var level = { bg_img : skytroops_levels_Grass.BG, spawns : []};
	while(t < duration) {
		var i = Std.random(waves.length);
		var w = waves[i];
		level.spawns.push({ t : t, wave : w});
		var dt = w.n * w.ship.xp / diff;
		t += dt;
	}
	return level;
};
skytroops_levels_Grass.__super__ = skytroops_levels_Level;
skytroops_levels_Grass.prototype = $extend(skytroops_levels_Level.prototype,{
});
var skytroops_screens_LevelSelect = function() {
	var _g2 = this;
	createjs.Container.call(this);
	var bmp = new createjs.Bitmap("img/bg/map.png");
	this.addChild(bmp);
	var _g = 0;
	var _g1 = skytroops_screens_LevelSelect.DOTS;
	while(_g < _g1.length) {
		var d = [_g1[_g]];
		++_g;
		var icon = new createjs.Bitmap("img/gui/dot_empty.png");
		icon.x = d[0].x - icon.image.width / 2;
		icon.y = d[0].y - icon.image.height / 2;
		icon.onClick = (function(d) {
			return function() {
				var lvl = d[0].level();
				_g2.onSelect(lvl);
			};
		})(d);
		this.addChild(icon);
	}
};
skytroops_screens_LevelSelect.__name__ = true;
skytroops_screens_LevelSelect.__super__ = createjs.Container;
skytroops_screens_LevelSelect.prototype = $extend(createjs.Container.prototype,{
	onSelect: function(level) {
		console.log("Level selected");
	}
});
var skytroops_screens_Loading = function() {
	createjs.Container.call(this);
	var bg = new createjs.Bitmap("img/gui/splash.png");
	this.addChild(bg);
	this.title = new skytroops_gui_Label("Loading...");
	this.title.x = skytroops_Game.WIDTH / 2;
	this.title.y = 600;
	this.title.color = "black";
	this.addChild(this.title);
	this.progress = new skytroops_gui_Label("");
	this.progress.x = skytroops_Game.WIDTH / 2;
	this.progress.y = 520;
	this.progress.color = "black";
	this.addChild(this.progress);
};
skytroops_screens_Loading.__name__ = true;
skytroops_screens_Loading.__super__ = createjs.Container;
skytroops_screens_Loading.prototype = $extend(createjs.Container.prototype,{
	setTitle: function(text) {
		this.title.text = text;
	}
	,setProgress: function(percents) {
		if(percents < 0) this.progress.text = ""; else this.progress.text = percents + " %";
	}
});
var skytroops_screens_Menu = function() {
	var _g = this;
	createjs.Container.call(this);
	var bg = new createjs.Bitmap("img/gui/menu.png");
	this.addChild(bg);
	var easy = new skytroops_gui_Button("Play !");
	easy.x = skytroops_Game.WIDTH / 2;
	easy.y = 450;
	easy.onBtnClicked = function() {
		_g.onPlay();
	};
	this.addChild(easy);
	var github = new createjs.Bitmap("img/github.png");
	github.x = skytroops_Game.WIDTH - 20 - 64;
	github.y = 20;
	github.onClick = function() {
		window.open("https://github.com/dagnelies/skytroops","_blank");
	};
	this.addChild(github);
};
skytroops_screens_Menu.__name__ = true;
skytroops_screens_Menu.__super__ = createjs.Container;
skytroops_screens_Menu.prototype = $extend(createjs.Container.prototype,{
	onPlay: function() {
		console.log("Play! clicked");
	}
});
var skytroops_waves_Spawner = function(spawns) {
	this.spawns_index = 0;
	this.t = 0.0;
	this.spawns = spawns;
};
skytroops_waves_Spawner.__name__ = true;
skytroops_waves_Spawner.prototype = {
	update: function(dt) {
		this.t += dt;
		while(!this.isFinished() && this.t > this.spawns[this.spawns_index].t) {
			this.launch(this.spawns[this.spawns_index].wave);
			this.spawns_index++;
		}
	}
	,isFinished: function() {
		return this.spawns_index >= this.spawns.length;
	}
	,getRadius: function(image) {
		var img = skytroops_Resources.get(image);
		return (img.width + img.height) / 2;
	}
	,launch: function(wave) {
		var radius = this.getRadius(wave.ship.image);
		var points = this.getFormation(wave.formation,wave.n,radius);
		this.translate(points,wave.from,radius);
		var rot = this.getRotation(wave.from);
		var ships = [];
		var _g = 0;
		while(_g < points.length) {
			var p = points[_g];
			++_g;
			var s = this.makeShip(wave.ship,p,rot);
			ships.push(s);
		}
		this.applyMotion(ships,wave.motion);
		var _g1 = 0;
		while(_g1 < ships.length) {
			var s1 = ships[_g1];
			++_g1;
			this.onSpawn(s1);
		}
	}
	,applyMotion: function(ships,motion) {
		if(motion == null) return;
		switch(motion[1]) {
		case 1:
			var _g = 0;
			while(_g < ships.length) {
				var s = ships[_g];
				++_g;
				s.acc_x = -s.vx / 2.5;
				s.acc_y = -s.vy / 2.5;
			}
			break;
		case 0:
			var mid = (ships.length - 1) / 2;
			var _g1 = 0;
			var _g2 = ships.length;
			while(_g1 < _g2) {
				var i = _g1++;
				ships[i].va = (mid - i) * Math.PI / 10;
			}
			break;
		case 2:
			var _g3 = 0;
			while(_g3 < ships.length) {
				var s1 = ships[_g3];
				++_g3;
				s1.va = -Math.PI / 4;
			}
			break;
		case 3:
			var _g4 = 0;
			while(_g4 < ships.length) {
				var s2 = ships[_g4];
				++_g4;
				s2.va = Math.PI / 4;
			}
			break;
		}
	}
	,makeShip: function(def,pos,rotation) {
		var angle = Math.PI * rotation / 180;
		var ship = new skytroops_AIShip(def);
		ship.x = pos.x;
		ship.y = pos.y;
		ship.angle = angle;
		ship.vx = Math.cos(angle) * def.speed;
		ship.vy = Math.sin(angle) * def.speed;
		return ship;
	}
	,getRotation: function(from) {
		switch(from[1]) {
		case 0:
			return 90;
		case 5:
			return -90;
		case 3:
			return 0;
		case 4:
			return 180;
		case 1:
			return 45;
		case 2:
			return 135;
		case 6:
			return -45;
		case 7:
			return -135;
		}
	}
	,getFormation: function(formation,n,r) {
		var points = [];
		var _g = 0;
		while(_g < n) {
			var i = _g++;
			var p = new createjs.Point();
			points.push(p);
			var j = n - 1 - i;
			var m = Math.min(i,j);
			switch(formation[1]) {
			case 0:
				p.x = i * r;
				p.y = 0;
				break;
			case 1:
				p.x = 0;
				p.y = i * r;
				break;
			case 2:
				p.x = i * r;
				p.y = j * r;
				break;
			case 3:
				p.x = i * r;
				p.y = i * r;
				break;
			case 4:
				p.x = i * r;
				p.y = m * r;
				break;
			case 5:
				p.x = i * r;
				p.y = (Math.floor(n / 2 - 0.5) - m) * r;
				break;
			case 6:
				p.x = (Math.floor(n / 2 - 0.5) - m) * r;
				p.y = i * r;
				break;
			case 7:
				p.x = m * r;
				p.y = i * r;
				break;
			case 8:
				p.x = Math.random() * (skytroops_Game.WIDTH - 2 * r);
				p.y = Math.random() * (skytroops_Game.WIDTH - 2 * r);
				break;
			}
		}
		return points;
	}
	,translate: function(points,from,radius) {
		var max = new createjs.Point();
		var _g = 0;
		while(_g < points.length) {
			var p = points[_g];
			++_g;
			max.x = Math.max(max.x,p.x);
			max.y = Math.max(max.y,p.y);
		}
		var dx = Math.random() * (skytroops_Game.WIDTH - max.x - 2 * radius);
		var dy = Math.random() * (skytroops_Game.HEIGHT - max.y - 2 * radius);
		var rnd = Math.random();
		var _g1 = 0;
		while(_g1 < points.length) {
			var p1 = points[_g1];
			++_g1;
			switch(from[1]) {
			case 0:
				p1.x += radius + dx;
				p1.y -= max.y + radius;
				break;
			case 5:
				p1.x += radius + dx;
				p1.y += skytroops_Game.HEIGHT + radius;
				break;
			case 3:
				p1.x -= radius + max.x;
				p1.y += radius + dy;
				break;
			case 4:
				p1.x += skytroops_Game.WIDTH + radius;
				p1.y += radius + dy;
				break;
			case 1:
				p1.x -= max.x + radius;
				p1.y -= max.y + radius;
				if(rnd < 0.5) p1.x += dx / 2; else p1.y += dy / 2;
				break;
			case 2:
				p1.x += skytroops_Game.WIDTH + radius;
				p1.y -= max.y + radius;
				if(rnd < 0.5) p1.x -= dx / 2; else p1.y += dy / 2;
				break;
			case 6:
				p1.x -= max.x + radius;
				p1.y += skytroops_Game.HEIGHT + radius;
				if(rnd < 0.5) p1.x += dx / 2; else p1.y -= dy / 2;
				break;
			case 7:
				p1.x += skytroops_Game.WIDTH + radius;
				p1.y += skytroops_Game.HEIGHT + radius;
				if(rnd < 0.5) p1.x -= dx / 2; else p1.y -= dy / 2;
				break;
			}
		}
	}
	,onSpawn: function(ship) {
	}
};
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = true;
Array.__name__ = true;
skytroops_Game.SPEED = 50.0;
skytroops_Game.WIDTH = 640;
skytroops_Game.HEIGHT = 960;
skytroops_Game.TRACTOR = 100;
skytroops_defs_Bullets.BULLET = { image : "img/bullets/bullet.png", sound : "snd/ball.wav", damage : 1, speed : 500};
skytroops_defs_Bullets.BALL = { image : "img/bullets/ball.png", sound : "snd/ball.wav", damage : 2, speed : 400};
skytroops_defs_Bullets.BUBBLES = { image : "img/bullets/bubbles.png", sound : "snd/ball.wav", damage : 3, speed : 600};
skytroops_defs_Bullets.DISK = { image : "img/bullets/disk.png", sound : "snd/ball.wav", damage : 4, speed : 500};
skytroops_defs_Bullets.WAVES = { image : "img/bullets/waves.png", sound : "snd/ball.wav", damage : 6, speed : 500};
skytroops_defs_Bullets.MISSILE = { image : "img/bullets/missile.png", sound : "snd/ball.wav", damage : 10, speed : 400};
skytroops_defs_Bullets.SLIME = { image : "img/bullets/slime.png", sound : "snd/ball.wav", damage : 1, speed : 600};
skytroops_PlayerShip.DEFAULT = { image : "img/ships/heli.png", shadow : null, speed : 500, armor : 10, xp : 0, weapon : { spread : skytroops_defs_WeaponSpread.FRONTAL, bullet : skytroops_defs_Bullets.BULLET, shots : 1, fire_rate : 2, aim : true}};
skytroops_Sound.sfx_volume = 0.3;
skytroops_Sound.music_volume = 0.8;
skytroops_defs_Weapons.BASIC_GUN = { spread : skytroops_defs_WeaponSpread.FRONTAL, bullet : skytroops_defs_Bullets.BALL, shots : 1, fire_rate : 0.4, aim : false};
skytroops_defs_Weapons.MACHINE_GUN = { spread : skytroops_defs_WeaponSpread.FRONTAL, bullet : skytroops_defs_Bullets.BALL, shots : 1, fire_rate : 1.2, aim : false};
skytroops_defs_Weapons.AIMED_GUN = { spread : skytroops_defs_WeaponSpread.FRONTAL, bullet : skytroops_defs_Bullets.BALL, shots : 1, fire_rate : 0.4, aim : true};
skytroops_defs_Weapons.DOUBLE_GUN = { spread : skytroops_defs_WeaponSpread.FRONTAL, bullet : skytroops_defs_Bullets.BALL, shots : 2, fire_rate : 0.6, aim : false};
skytroops_defs_Weapons.FLOWER_GUN = { spread : skytroops_defs_WeaponSpread.SIDES, bullet : skytroops_defs_Bullets.BALL, shots : 8, fire_rate : 0.3, aim : false};
skytroops_defs_Weapons.MISSILE_LAUNCHER = { spread : skytroops_defs_WeaponSpread.FRONTAL, bullet : skytroops_defs_Bullets.MISSILE, shots : 1, fire_rate : 0.4, aim : false};
skytroops_defs_Ships.WEAKLING = { image : "img/ships/weakling.png", shadow : null, speed : 100, armor : 1, xp : 1, weapon : null};
skytroops_defs_Ships.TROOPER = { image : "img/ships/trooper.png", shadow : null, speed : 200, armor : 3, xp : 3, weapon : null};
skytroops_defs_Ships.GUNNER = { image : "img/ships/gunner.png", shadow : null, speed : 100, armor : 2, xp : 4, weapon : skytroops_defs_Weapons.MACHINE_GUN};
skytroops_defs_Ships.SNIPER = { image : "img/ships/sniper.png", shadow : null, speed : 100, armor : 2, xp : 6, weapon : skytroops_defs_Weapons.AIMED_GUN};
skytroops_defs_Ships.FOLLOWER = { image : "img/ships/uplane.png", shadow : null, speed : 100, armor : 1, xp : 1, weapon : null};
skytroops_defs_Ships.MINE = { image : "img/ships/mine.png", shadow : null, speed : 0, armor : 10, xp : 1, weapon : null};
skytroops_defs_Ships.TANK_LIGHT = { image : "img/ships/tank_1.png", shadow : null, speed : 0, armor : 3, xp : 2, weapon : skytroops_defs_Weapons.MACHINE_GUN};
skytroops_defs_Ships.TANK_HEAVY = { image : "img/ships/tank_2.png", shadow : null, speed : 0, armor : 5, xp : 3, weapon : skytroops_defs_Weapons.MISSILE_LAUNCHER};
skytroops_defs_Waves.WEAKLING_I = { n : 1, ship : skytroops_defs_Ships.WEAKLING, formation : skytroops_defs_Formation.DOWN, from : skytroops_defs_Direction.TOP};
skytroops_defs_Waves.WEAKLING_II = { n : 3, ship : skytroops_defs_Ships.WEAKLING, formation : skytroops_defs_Formation.DOWN, from : skytroops_defs_Direction.TOP};
skytroops_defs_Waves.WEAKLING_III = { n : 5, ship : skytroops_defs_Ships.WEAKLING, formation : skytroops_defs_Formation.DOWN, from : skytroops_defs_Direction.TOP};
skytroops_defs_Waves.WEAKLING_TL_I = { n : 2, ship : skytroops_defs_Ships.WEAKLING, formation : skytroops_defs_Formation.SLASH, from : skytroops_defs_Direction.TOP_LEFT};
skytroops_defs_Waves.WEAKLING_TR_I = { n : 2, ship : skytroops_defs_Ships.WEAKLING, formation : skytroops_defs_Formation.BSLASH, from : skytroops_defs_Direction.TOP_RIGHT};
skytroops_defs_Waves.WEAKLING_TL_II = { n : 4, ship : skytroops_defs_Ships.WEAKLING, formation : skytroops_defs_Formation.SLASH, from : skytroops_defs_Direction.TOP_LEFT};
skytroops_defs_Waves.WEAKLING_TR_II = { n : 4, ship : skytroops_defs_Ships.WEAKLING, formation : skytroops_defs_Formation.BSLASH, from : skytroops_defs_Direction.TOP_RIGHT};
skytroops_defs_Waves.UPLANE_I = { n : 1, ship : skytroops_defs_Ships.FOLLOWER, formation : skytroops_defs_Formation.HORIZONTAL, from : skytroops_defs_Direction.BOTTOM};
skytroops_defs_Waves.UPLANE_II = { n : 3, ship : skytroops_defs_Ships.FOLLOWER, formation : skytroops_defs_Formation.RANDOM, from : skytroops_defs_Direction.BOTTOM};
skytroops_defs_Waves.UPLANE_III = { n : 5, ship : skytroops_defs_Ships.FOLLOWER, formation : skytroops_defs_Formation.RANDOM, from : skytroops_defs_Direction.BOTTOM};
skytroops_defs_Waves.SHOOTER_I = { n : 1, ship : skytroops_defs_Ships.GUNNER, formation : skytroops_defs_Formation.HORIZONTAL, from : skytroops_defs_Direction.TOP};
skytroops_defs_Waves.SHOOTER_II = { n : 2, ship : skytroops_defs_Ships.GUNNER, formation : skytroops_defs_Formation.HORIZONTAL, from : skytroops_defs_Direction.TOP, motion : skytroops_defs_Motion.SPREAD};
skytroops_defs_Waves.SHOOTER_III = { n : 3, ship : skytroops_defs_Ships.GUNNER, formation : skytroops_defs_Formation.DOWN, from : skytroops_defs_Direction.TOP, motion : skytroops_defs_Motion.SPREAD};
skytroops_defs_Waves.MINES = { n : 4, ship : skytroops_defs_Ships.MINE, formation : skytroops_defs_Formation.HORIZONTAL, from : skytroops_defs_Direction.TOP};
skytroops_defs_Waves.TANK_L_I = { n : 1, ship : skytroops_defs_Ships.TANK_LIGHT, formation : skytroops_defs_Formation.HORIZONTAL, from : skytroops_defs_Direction.TOP};
skytroops_defs_Waves.TANK_H_I = { n : 1, ship : skytroops_defs_Ships.TANK_HEAVY, formation : skytroops_defs_Formation.HORIZONTAL, from : skytroops_defs_Direction.TOP};
skytroops_defs_Levels.BG_GRASS = "img/bg/grass.png";
skytroops_defs_Levels.BG_ROCKY = "img/bg/rocky.png";
skytroops_defs_Levels.BG_SNOW = "img/bg/snow.png";
skytroops_defs_Levels.BG_DESERT = "img/bg/desert.png";
skytroops_defs_Levels.BG_ISLANDS = "img/bg/islands.png";
skytroops_defs_Levels.WAVES_GRASS = [[skytroops_defs_Waves.WEAKLING_I,skytroops_defs_Waves.WEAKLING_TL_I,skytroops_defs_Waves.WEAKLING_TR_I,skytroops_defs_Waves.UPLANE_I],[skytroops_defs_Waves.WEAKLING_II,skytroops_defs_Waves.WEAKLING_TL_II,skytroops_defs_Waves.WEAKLING_TR_II,skytroops_defs_Waves.UPLANE_II],[skytroops_defs_Waves.SHOOTER_I,skytroops_defs_Waves.WEAKLING_TL_I,skytroops_defs_Waves.WEAKLING_TR_I,skytroops_defs_Waves.UPLANE_I]];
skytroops_defs_Levels.WAVES_ROCKY = [];
skytroops_defs_Levels.WAVES_SNOW = [];
skytroops_defs_Levels.WAVES_DESERT = [];
skytroops_defs_Levels.WAVES_ISLANDS = [];
skytroops_levels_Grass.cooldown = 0;
skytroops_levels_Grass.WAVES = [skytroops_defs_Waves.MINES,skytroops_defs_Waves.TANK_L_I,skytroops_defs_Waves.TANK_H_I];
skytroops_levels_Grass.BG = "img/bg/grass.png";
skytroops_screens_LevelSelect.DOTS = [{ x : 340, y : 176, level : function() {
	return skytroops_defs_Levels.buildGrassLevel(0,1);
}},{ x : 259, y : 310, level : function() {
	return skytroops_defs_Levels.buildGrassLevel(1,1.5);
}},{ x : 346, y : 410, level : function() {
	return skytroops_defs_Levels.buildGrassLevel(2,2);
}},{ x : 492, y : 471, level : function() {
	return skytroops_defs_Levels.buildGrassLevel(2,5);
}}];
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
