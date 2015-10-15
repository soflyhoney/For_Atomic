
package com.barbie.thumbelina{
	/** Class for Barbie Thumbelina Feb. 2009
	it turns out i can probably remove this from everywhere
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class TalkClip extends MovieClip {
		
		public static const TALK_DONE:String = "TALK_DONE";
		private var mouth_mc:MovieClip;
		
		public function TalkClip() {
			
		}
		
		
		public function doMouthComplete():void{
			dispatchEvent(new Event(TALK_DONE,true)); 
			trace("TalkClip complete ");
		}
		
	}
}