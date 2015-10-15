
package com.barbie.thumbelina.loader{
	/** Document class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.gs.TweenLite;
	
	
	public class LoadMaster extends MovieClip {
		
		private var fileloaded:Boolean = false;
		private var mainLoader:LoaderMain;
		private var loadbar:Loadbar;
		private var checking:Boolean = false;
		private var counting:Boolean = false;
		
		public static const LOADING_DONE:String = "LOADING_DONE";
		
		public function LoadMaster() 
		{
			trace("hello from Loading");
			init();
		}
		
		private function init():void{
			mainLoader = new LoaderMain();
			mainLoader.x = 161;
			mainLoader.y = 152;
			addChild(mainLoader);
			loadbar = new Loadbar();
			mainLoader.addChild(loadbar);
			//listen for animation to be complete
			addEventListener(Loadbar.ANIM_DONE,doAnimationComplete);
			addEventListener(Loadlogo.LOADING_DONE,doAnimateOut);
			//listen for load bar to be complete
			//addEventListener()
		}
		
		public function doAnimationComplete(e:Event):void{
			removeEventListener(Loadbar.ANIM_DONE,doAnimationComplete);
			trace("Loading animationInComplete");
			//temp value
			//fileloaded =true;
			if(fileloaded) doContinueScreen2();
			else waitForLoaded();
			//this timer is temporary for testing and displaying
			//counting = true;
			//var timer:Timer = new Timer(0, 500);
        	//timer.addEventListener(TimerEvent.TIMER_COMPLETE, doFileLoaded);
			//timer.start();
		}
		
		private function waitForLoaded():void{
			checking=true;
			addEventListener(Event.ENTER_FRAME, checkLoaded);
		}
		
		private function checkLoaded(event:Event){
			//trace("checkLoaded: "+fileloaded);
			if(fileloaded) {
				doContinueScreen2();
				if(checking) {
					removeEventListener(Event.ENTER_FRAME, checkLoaded);
					checking = false;
				}
			}
		}
		
		private function doFileLoaded(e:Event):void{
			trace("times' up");
			fileloaded =true;
			if(counting){
				removeEventListener(TimerEvent.TIMER_COMPLETE, doFileLoaded);
				counting = false;
			}
		}
		
		private function doContinueScreen2(){
			trace("Loading doContinueScreen2");
			//tell all 3 "frozen" animations to "go"
			loadbar.gotoAndPlay("loaded");
			mainLoader.logo.gotoAndPlay("loaded");
			mainLoader.logo.bird.gotoAndPlay("loaded");
		}
		
		public function doAnimateOut(e:Event):void{
			removeEventListener(Loadlogo.LOADING_DONE,doAnimateOut);
			//this occurs after the data is loaded
			TweenLite.to(mainLoader, .5, { x:-329, onComplete:doLoadingDone } );
		}
		
		private function doLoadingDone():void{
			trace("start game");
			dispatchEvent(new Event(LOADING_DONE,true)); 
		}
	}
}