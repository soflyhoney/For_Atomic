
package com.barbie.thumbelina{
	/** Class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	//import com.barbie.thumbelina.sound.*;
	
	public class Mouth extends MovieClip {
		
		private var mouth_mc:MovieClip;
		private var n:int = 0;
		public function Mouth(_mc:MovieClip) {
			mouth_mc = _mc;
			init();
		}
		
		private function init():void{
			addEventListener(TalkClip.TALK_DONE,doIdle);
		}
		
		public function goIdle():void{
			mouth_mc.gotoAndPlay("idle");
		}
		
		public function doIntro():void{
			mouth_mc.gotoAndPlay("intro");
		}
		
		public function doGame1():void{
			mouth_mc.gotoAndPlay("game1");
		}
		
		public function doCorrect():void{
			trace("Mouth correct");
			mouth_mc.gotoAndPlay("correct"+n);
			n++;
			if(n>3) n = 0;
		}
		
		public function doIncorrect():void{
			trace("Mouth doIncorrect");
			mouth_mc.gotoAndPlay("incorrect0");
			//mouth_mc.mouth.play();
		}
		
		public function doIdle(e:Event):void{
			trace("Mouth doIdle");
			mouth_mc.gotoAndPlay("idle");
		}
		
		public function resetFB():void{
			n=0;
		}
		
		
	}
}