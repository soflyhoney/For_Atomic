
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
		public static const REGISTER:String = "REGISTER";
		
		public function get displayObject():Preloader{
			
			return this;
		}
		
		public function Preloader() {
			init();
		}
		
		private function init():void{
			trace("Hello from Preloadermmmmm REGISTER");
			dispatchEvent(new Event(REGISTER,true)); 
			//this.addEventListener(Event.ENTER_FRAME, loading);
		}
		
		/*function loading(e:Event):void{
			this.removeEventListener(Event.ENTER_FRAME, loading);
			var total:Number = this.stage.loaderInfo.bytesTotal;
			trace("total: "+total);
			
			var loaded:Number = this.stage.loaderInfo.bytesLoaded;
			trace("loaded: "+loaded);
			var frame:Number = Math.floor((loaded/total)*100)/4;
			trace("frame: "+frame)
			this.gotoAndStop(frame);
			if (total == loaded){
				doLoadingComplete();
				this.removeEventListener(Event.ENTER_FRAME, loading);
			}
		}*/
		
		public function setBar(_int:Number){
			var frame:Number = Math.floor(_int/4);
			trace("frame: "+frame)
			this.gotoAndStop(frame);
		}

		
		public function doLoadingComplete():void{
			dispatchEvent(new Event(LOADING_DONE,true)); 
		}
		
	}
}