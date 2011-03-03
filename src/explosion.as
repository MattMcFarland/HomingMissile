package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Matt McFarland
	 */
	public class explosion extends Entity 
	{
		//Our explosion will have a blast radius of 50 pixels
		private const BLAST_RADIUS:Number = 50;
		//The duration of its explosion effect.
		private const BLAST_SPEED:Number = .5;
		//the duration of it's fade out.
		private const FADE_TIME:Number = .3;
		
		private var image:Image;
		//Our colorTween will be used to fade the circle after it explodes.
		private var colorShift:ColorTween;
		
		public function explosion(x:Number,y:Number) 
		{
			//Create a yellow circle the size of the blast radius
			image = Image.createCircle(BLAST_RADIUS, 0xFFFF00);
			//set the scale of the circle to 0 since we'l be expanding it with a tweener
			image.scale = 0;
			//Use the centerOO so the circle expands instead of grows off the upperleft corner 
			image.centerOO();
			super (x, y, image);			
			//We'll set the hitbox to twice the size of the radius
			//and we'll use the offset arguments of the setHitbox function to encapsulate it perfectly.
			setHitbox(BLAST_RADIUS*2, BLAST_RADIUS*2, BLAST_RADIUS, BLAST_RADIUS);
			type = "explosion";
			//We'll create a new VarTween and when it finishes it will run (fadeOut)
			var explode:VarTween = new VarTween(fadeOut);
			//we'll definte it's tween property which basically tells it what to to tween.
			//We're telling it to tween the image's scale property to 1.2.
			//We're using the BLAST_SPEED as the duration variable, and we'll be using flashpunk's
			//Easing class to make the explosion explode out!
			explode.tween(image, "scale", 1.2, BLAST_SPEED, Ease.expoOut)
			//We'll now add the tween and run it's start method immediately.  If we wanted to run the tween later
			//we could do addTween(explode) and then to explode.start(); later.
			addTween(explode, true);
			
		}
		//The fadeout metho runs when the explode tween finishes.
		private function fadeOut():void
		{
			//We'll define our colortween and activate it.  Colortweens are different from VarTweens, and
			//our image's color and alpha must be told to update to the colortween to be used (more later)
			
			//We're telling the colorShift:ColorTween that when it finishes to run the (remove) method.
			colorShift = new ColorTween(remove);
			//Create the tween, this will last the duration of the fadetime, it will tween from the images
			//present color to red, and also we'l tween the alpha from 1 to 0.  
			colorShift.tween(FADE_TIME, image.color, 0xFF0000, 1, 0, Ease.expoOut);
			//addtween and start immediately.
			addTween(colorShift, true);
		}

		override public function update():void
		{
			//if colorShift is not null, that means that we've activated the colortween so we want to update
			//the image's color and alpha to the tweener.
			if (colorShift) {
				image.color = colorShift.color;
				image.alpha = colorShift.alpha;
			}
		}
		//remove the explosion
		private function remove():void
		{
			if (this.world) world.remove(this);
		}
		
	}

}