package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Matt McFarland
	 */
	public class Enemy extends Entity 
	{
		//Our enemy speed will be random, we'll set the minimum speed and maximum speed.
		private const MIN_SPEED:Number = 30;
		private const MAX_SPEED:Number = 60;
		//Our Enemies will appear randomly on the right side of the screen, but anywhere vertically.
		//I don't want our enemies to appear at the very bottom or the very top, so I added a constant
		//called Y_PADDING, which will be used as a "buffer" between the bottom and top of the screen.
		private const Y_PADDING:Number = 100;
		//We'll need to track our enemies speed every frame, so the speed variable will be declared here.
		private var speed:int;
		private var image:Image;
		
		public function Enemy() 
		{
			//The enemy will appear 10 pixels above the width of the screen, which means it will be 
			//off to the right outside of view.
			x = FP.width + 10;
			//The enemy will appear randomly and have a random speed.
			y = Y_PADDING + Math.random() * FP.height - Y_PADDING;
			speed = MIN_SPEED + Math.random() * MAX_SPEED;;
			//The enemy's graphic will be a circle with a radius of 8 pixels, and it will be red in color.
			image = Image.createCircle(8, 0xFF0000);
			graphic = image;
			//The enemy will be using the setHitBox command, which is used for collision testing. We'll just use
			//the image's width and height to set the enemy's hitbox width and height.
			setHitbox(image.width, image.height);
			//The type is also used for collision testing, and we'll name the type 'enemy'
			type = "enemy";
		}
		
		override public function update():void
		{
			//the enemy will move to the left
			x -= speed * FP.elapsed;
			//if the enemy has travelled all the way to the left side we'll kill it.
			if (x < 0) die();
			//Here is a collision test used commonly with flashpunk
			//We are creating a variable called splash which is based off of our explosion class which we'll
			//be making later.  the explosion classes type will be "explosion", and so we're basically seeing 
			//if there is a collision with the explosion hit box at the location of the enemy's x and y coordinates.
			var splash:explosion = collide("explosion", x, y) as explosion;
			//if there is a collision, kill the enemy
			if (splash) die();
		}
		//the die method simply removes the enemy from the world.  It makes sure that the world property of
		//the enemy is not null first to avoid a possible error that occurs if the enemy's world property is
		//set to null.  
		public function die():void
		{
			if (this.world) this.world.remove(this)
		}
	}

}