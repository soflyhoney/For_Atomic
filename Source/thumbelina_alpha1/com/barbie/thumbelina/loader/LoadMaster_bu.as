//Written by Rebecca A. Krug
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
		private var animationComplete:Boolean = false;
		private var mainLoader:LoaderMain;
		private var loadbar:Loadbar;
		private var checking:Boolean = false;
		private var checking2:Boolean = false;
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
			addEventListener(Loadbar.ANIM_DONE,doAnimationComplete);
			addEventListener(Preloader.LOADING_DONE,doContinueScreen2);
			
		}
		
		public function doAnimationComplete(e:Event):void{
			removeEventListener(Loadbar.ANIM_DONE,doAnimationComplete);
			animationComplete =true;
			if(fileloaded) doContinueScreen2(null);
			else waitForLoaded();
		}
		
		private function waitForLoaded():void{
			checking=true;
			addEventListener(Event.ENTER_FRAME, checkLoaded);
		}
		
		private function waitForAnimation():void{
			checking2=true;
			addEventListener(Event.ENTER_FRAME, checkAnimation);
		}
		
		private function checkLoaded(event:Event){
			if(fileloaded) {
				doContinueScreen2(null);
				if(checking) {
					removeEventListener(Event.ENTER_FRAME, checkLoaded);
					checking = false;
				}
			}
		}
		
		private function checkAnimation(event:Event){
			if(animationComplete) {
				doContinueScreen2(null);
				if(checking2) {
					removeEventListener(Event.ENTER_FRAME, checkAnimation);
					checking2 = false;
				}
			}
		}
		
		private function doFileLoaded(e:Event):void{
			fileloaded =true;
			//doContinueScreen2();
			//if(animationComplete) doContinueScreen2();
			//else waitForAnimation();
		}
		
		private function doContinueScreen2(e:Event){
			//tell all 3 "frozen" animations to "go"
			loadbar.gotoAndPlay("loaded");
			mainLoader.logo.gotoAndPlay("loaded");
			mainLoader.logo.bird.gotoAndPlay("loaded");
		}
		
		public function doAnimateOut(e:Event):void{
			removeEventListener(Preloader.LOADING_DONE,doAnimateOut);
			//this occurs after the data is loaded
			//TweenLite.to(mainLoader, .5, { x:-329, onComplete:doLoadingDone } );
		}
		
		private function doLoadingDone():void{
			dispatchEvent(new Event(LOADING_DONE,true)); 
		}
	}
}