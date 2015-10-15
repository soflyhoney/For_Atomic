
package com.barbie.thumbelina{
	/** Class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	//import com.barbie.thumbelina.sound.*;
	
	public class Bird1 extends MovieClip {
		
		public static const CHANGE_GAME:String = "CHANGE_GAME";
		
		public function Bird1() {
			trace("hello from Brid1");
			//init();
		}
		
		public function doChangeScene():void{
			dispatchEvent(new Event(CHANGE_GAME,true));
		}
		
	}
}