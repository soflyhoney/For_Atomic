//Written by Rebecca A. Krug
package com.barbie.thumbelina.loader{
	/** Document class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Loadlogo extends MovieClip {
		
		public static const LOGO_DONE:String = "LOGO_DONE";
		
		public function Loadlogo() {}
		
		public function doLoaderComplete():void{
			dispatchEvent(new Event(LOGO_DONE,true)); 
			
		}
		
		
	}
}