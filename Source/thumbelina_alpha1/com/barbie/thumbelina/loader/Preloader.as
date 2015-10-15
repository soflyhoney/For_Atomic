//Written by Rebecca A. Krug
package com.barbie.thumbelina.loader{
	/** Class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Preloader extends MovieClip {
		
		private var timer:Timer;
		public static const LOADING_DONE:String = "LOADING_DONE";
		
		
		public function Preloader() {
			init();
		}
		
		private function init():void{
			trace("Hello from Preloader");
			this.addEventListener(Event.ENTER_FRAME, loading);
		}
		
		function loading(e:Event):void{
			this.removeEventListener(Event.ENTER_FRAME, loading);
			var total:Number = this.stage.loaderInfo.bytesTotal;
			var loaded:Number = this.stage.loaderInfo.bytesLoaded;
			var frame:Number = Math.floor((loaded/total)*100)/4;
			this.gotoAndStop(frame);
			doLoadingComplete();
			/*if (total == loaded){
				timer = new Timer(0, 300);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, doLoadingComplete);
				timer.start();
				this.removeEventListener(Event.ENTER_FRAME, loading);
			}*/
		}

		
		public function doLoadingComplete():void{
			//timer.removeEventListener(TimerEvent.TIMER_COMPLETE, doLoadingComplete);
			dispatchEvent(new Event(LOADING_DONE,true)); 
		}
		
	}
}