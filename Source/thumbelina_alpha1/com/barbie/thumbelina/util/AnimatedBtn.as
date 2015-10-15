//Written by Rebecca A. Krug
package com.barbie.thumbelina.util{
	/** Document class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	//import flash.events.EventDispatcher;
	
	public class AnimatedBtn extends MovieClip {
		
		private var mc:MovieClip;
		private var doFunction:Function;
		
		public function AnimatedBtn(_mc:MovieClip,_handler:Function) {
			mc = _mc;
			doFunction = _handler;
			init();
		}
		
		private function init():void{
			enableBtn();
		}
		
		private function doRollover(e:Event):void{
			mc.gotoAndPlay("over");
		}
		
		private function doRollout(e:Event):void{
			mc.gotoAndPlay("off");
		}
		
		public function disableBtn():void{
			mc.buttonMode = false;
			mc.useHandCursor = false;
			mc.mouseChildren = false;
			mc.removeEventListener(MouseEvent.ROLL_OVER,doRollover);
			mc.removeEventListener(MouseEvent.ROLL_OUT,doRollout);
			mc.removeEventListener(MouseEvent.CLICK,doFunction);
		}
		
		public function enableBtn():void{
			mc.gotoAndStop(1);
			mc.buttonMode = true;
			mc.useHandCursor = true;
			mc.addEventListener(MouseEvent.ROLL_OVER,doRollover);
			mc.addEventListener(MouseEvent.ROLL_OUT,doRollout);
			mc.addEventListener(MouseEvent.CLICK,doFunction);
		}
		
	}
}