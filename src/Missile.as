package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Matt McFarland
	 */
	public class Missile extends Entity 
	{
		//We'll be setting our turn speed to 100 pixels per second, and our velocity to 200 missiles per second.
		private const TURN_SPEED:Number = 100;
		private const SPEED:Number = 200;
		//We'll be converting degrees to radians, and since we dont need to do that every frame we'll juse use
		//the RAD constant.  You can find this in FP.RAD as well, but FP.RAD is erronously set to -180 not 180.
		private const RAD:Number = Math.PI / 180;
		//We'll set the lifespan of the missle to 2 seconds, and we'll be using a timer to test it.
		private const LIFE:Number = 2;
		private var lifeTimer:Number=0;
		//To get the missiles to follow their trajectories and turn at angles we'll need some maths.
		//I do not understand the mathematics to a degree which I am comfortable with explaining.
		private var vx:Number;
		private var vy:Number;
		private var angle:Number;
		private var targetDir_x:Number;
		private var targetDir_y:Number;
		
		//We'll be storing the target entity as a variable within the missile.  This allows us to easily recognize
		//our missiles target.
		private var target:Entity;
		
		private var image:Image;
		
		//The Constructor will create a missile pointing at a 90 degree angle,
		//it's x and y parameters are set when the missile is created by the player
		//and it uses a white rectangle for it's graphic.
		public function Missile(x:Number,y:Number)
		{
			image = Image.createRect(8, 8);
			super (x, y, image);
			angle = 90;
		}
		
		//The update method runs every frame.  We'll be making sure we have a target, and propel the
		//missile forward.
		override public function update():void
		{
			//Find out if we need a target or not.  if the missiles target:entity is null then we'll run
			//the getNewTarget function. Otherwise, we'll run the chaseTarget function to do some maths
			//to adjust the angle of the missile.
			if (!target) getNewTarget();
			if (target) turnTowardsTarget();
			//Update the movement.
			//This code here moves the missile forward at the angle it is facing
			vx = SPEED * Math.sin(angle * RAD) * FP.elapsed;  
			vy = SPEED * Math.cos(angle * RAD) * FP.elapsed;
			x += vx;
			y += vy;
			//This code rotates the images angle to the angle property of the missile
			image.angle = angle;
			
			//When should the missile explode?
			//If the missile is 30 pixels away from any enemy!
			//var e is a temporary variable that will be the nearest enemy to the missile.
			//the "enemy" is accessing the type property.  This is why we defined the enemy's type property.
			//The world will get the nearest enemy to the missile, and then we'll calculate the distance
			//by using the distanceFrom method and see if it is 30 pixels or less.  If it is within blast range
			//The missile will detonate.
			var e:Entity = world.nearestToEntity("enemy", this);
			if (e) 
				{
					if (distanceFrom(e) < 30) detonate();
				}
			//If its life has run out.
			//here we test the timer and see if the missiles life has expended.
			lifeTimer += FP.elapsed;
			if (lifeTimer > LIFE) detonate();
		}
		
		/**
		 * Gets a new target and stores it as a variable
		 */
		private function getNewTarget():void
		{
			//the get new target function simply makes the target property of the missile = to the
			//nearest enemy.  Once the missile has a target, it will chase that one and avoid all other
			//enemies.  The missile essentially has locked on to a new target.
			target = world.nearestToEntity("enemy", this);
		}
		//The turnTowardsTarget method tells the missile to turn either left or right at its turnspeed.
		//we'll be using maths to determine which way the missile should turn, and the goal is to
		//make the missile turn toward its target.  
		private function turnTowardsTarget():void
		{
				//make vector pointing from missile to target
				targetDir_x = (target.x - x); 
				targetDir_y = (target.y - y);

				//rotate missile 90 deg from (x,y) to (y,-x)
				//then if the dot product says its perpendicular, it actually means its parallel
				//if the line from missile to target is parallel with the angle of the missile,
				//the missile is pointing at the target//

				if ( vy * targetDir_x - vx * targetDir_y > 0 )     
					angle += TURN_SPEED*FP.elapsed;
				else 
					angle -= TURN_SPEED*FP.elapsed;	
		}
		//The detonate function will create a new explosion object, and then remove the missile from the
		//world.
		private function detonate():void
		{
			if (this.world) {
				world.add(new explosion(x,y));
				world.remove(this);
			}
		}
		
		
	}

}