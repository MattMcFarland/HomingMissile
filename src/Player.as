package  
{
	//Our Player is basically an Entity, so we'll be importing Entity.
	import net.flashpunk.Entity;
	//Our player will be a green circle, so we'll need to import Image.
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	//Our player will be controlled with the keyboard, so we'll need to import Key and Input.
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Matt McFarland
	 */
	//Since our player is an Entity, we'll say that it extends Entity!
	public class Player extends Entity
	{
		//Our player can shoot missiles every 7th of a second
		private const COOLDOWN:Number = .7;
		//Our player can move 200 pixels per second
		private const SPEED:Number = 200;
		//Our weaponTimer will be used with COOLDOWN to so that we can add a delay between firing missiles.
		private var weaponTimer:Number = 0;
		//As soon as we add(new Player()) from myWorld this code runs first.  This is also known as
		//the constructor.
		public function Player() 
		{
			//Here's that super again.  This is because Player extends Entity, so we are giving the 
			//Entity's contructor information.  Basically we are setting the X, Y, and graphic properties.
			//x = 20
			//y = FP.halfHeight, which means the center!
			//graphic = Image.createCircle(20,0x00FF00) which means the graphic is a circle
			//with the radius of 20 pixels, and it is green.(hex color code)
			super(20, FP.halfHeight, Image.createCircle(20, 0x00FF00));
		}
		
		//The update function runs every frame.
		override public function update():void
		{
			//Update our weapon!
			//if our weapontimer is greater than 0, then subtract it by the amount of time elapsed since
			//the lastframe
			if (weaponTimer > 0) {
				weaponTimer -= FP.elapsed;
			}
			
			//Check for Keyboard Input.  SEEED is set to 200, so if you do SPEED*FP.elapsed
			//it means 200 pixels per second!
			//We're using Input.Cceck which sees if a key is being held down at the time of this frame.
			if (Input.check(Key.W)) y -= SPEED*FP.elapsed;
			if (Input.check(Key.A)) x -= SPEED*FP.elapsed;
			if (Input.check(Key.S)) y += SPEED*FP.elapsed;
			if (Input.check(Key.D)) x += SPEED * FP.elapsed;
			//If the SPACEBAR is down and the weapon timer is less than or equal to 0 then run the FireMissle
			//function.
			if (Input.check(Key.SPACE) &&
				weaponTimer <= 0) FireMissile();
		}
		//FireMissile basically resets our weapontimer, and adds a new missile to the world at the player's
		//location, with an x and y offset so the missile shows up in front of the circle to the right.
		private function FireMissile():void
		{
			weaponTimer += COOLDOWN;
			world.add(new Missile(x+40, y+10));
		}
		
	}

}