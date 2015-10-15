//Written by Rebecca A. Krug
package com.barbie.thumbelina.intro{
	/** Document class for Barbie Thumbelina Feb. 2009
	maybe not use this
	*/
	import flash.display.*;
	import flash.events.*;
	import flash.events.EventDispatcher;
	
	
	public class IntroPanel extends MovieClip {
		
		public static const INTRO_DONE:String = "INTRO_DONE";
		
		public function IntroPanel() {
			trace("hello from IntroPanel");
			init();
		}
		
		private function init():void{
			addEventListener(PlayNow_Btn.PLAY_NOW,doPanelBye);
		}
		
		private function doPanelBye(e:Event):void{
			this.gotoAndPlay("bye");
		}
		
		public function introDone():void{
			//gets called from the last frame in the IntroPanel
			dispatchEvent(new Event(INTRO_DONE,true));
		}
		
		
	}
}