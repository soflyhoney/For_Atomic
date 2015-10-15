
package com.barbie.thumbelina.intro{
	/** Document class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.*;
	import flash.events.*;
	import flash.events.EventDispatcher;
	//import com.gs.TweenLite;
	
	public class IntroMaster extends MovieClip {
		
		public static const PLAY_INTRO_MUSIC:String = "PLAY_INTRO_MUSIC";
		
		public function IntroMaster() {}
		
		public function beginIntroMusic():void{
			dispatchEvent(new Event(PLAY_INTRO_MUSIC,true));
		}
		
	}
}