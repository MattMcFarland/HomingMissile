package  
{
	//We'll be using World and FP
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Matt McFarland
	 */
	
	public class myWorld extends World 
	{
		//The spawn timer is used as a means to create new enemies 
		private const SPAWN_DELAY:Number = 0.8;
		private var spawnTimer:Number = 0;
		
		//myWorld runs first, and as you can see it's just used to add the player to the world!
		public function myWorld():void
		{
			add(new Player());			
		}
		// the update function runs every frame.
		override public function update():void
		{
			//Since myWorld extends World, the World class already has an update function
			//that handles all of the entities.  Since we'll be using entities, we'll want our
			//world to continue updating them!  The way to do this is to add super.update().
			super.update();
			//This line of code basically means spawnTimer = spawnTimer + the amount of time that
			//has elapsed between the previous frame and this frame.
			spawnTimer += FP.elapsed;
			//if the spawnTimer reaches the spawn delay we'll create a new enemy, and reset the spawn timer
			//to 0 so we can continue to add enemies every time!
			if (spawnTimer > SPAWN_DELAY) {
				add(new Enemy());
				spawnTimer = 0
			}
		}
	}

}