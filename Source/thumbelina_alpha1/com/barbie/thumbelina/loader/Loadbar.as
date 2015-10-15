//Written by Rebecca A. Krug
package com.barbie.thumbelina.loader{
	/** Class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Loadbar extends MovieClip {
		
		public static const ANIM_DONE:String = "ANIM_DONE";
		
		public function Loadbar() {}
		
		public function doAnimationComplete():void{
			dispatchEvent(new Event(ANIM_DONE,true)); 
		}
		
	}
}