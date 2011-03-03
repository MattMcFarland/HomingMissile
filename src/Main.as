package 
{
	//The Main class will be an extension of the Engine class, and will be using the FP class
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Matt McFarland
	 */
	//as you can see, the Main class 'extends' Engine!
	public class Main extends Engine
	{	
		public function Main()
		{
			//640x480, 60 FPS, variable timestep
			super(640, 480, 60, false);
			//Make the myWorld class, at the end of this script, flash punk will activate myWorld and
			//myWorld class will begin.
			FP.world = new myWorld;
			//enable the flashpunk console, a really cool feature.
			FP.console.enable();

		}
		
	}
	
}