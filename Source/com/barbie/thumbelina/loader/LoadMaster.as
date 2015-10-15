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
		private var mainLoader:LoaderMain_MC;
		private var loadbar:Loadbar;
		private var checking:Boolean = false;
		private var checking2:Boolean = false;
		private var counting:Boolean = false;
		private var timer:Timer;
		
		public static const DONE:String = "DONE";
		
		public function LoadMaster() 
		{
			trace("hello from LoadMaster");
			init();
		}
		
		private function init():void{
			mainLoader = new LoaderMain_MC();
			mainLoader.x = 161;
			mainLoader.y = 152;
			addChild(mainLoader);
			loadbar = new Loadbar();
			mainLoader.addChild(loadbar);
			
			addEventListener(Loadbar.ANIM_DONE,doAnimationComplete);
			//addEventListener(Preloader.LOADING_DONE,doFileLoaded);
			addEventListener(Loadlogo.LOGO_DONE,doAnimateOut);
		}
		
		
		public function doAnimationComplete(e:Event):void{
			removeEventListener(Loadbar.ANIM_DONE,doAnimationComplete);
			animationComplete =true;
			if(fileloaded) doContinueScreen2();
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
				doContinueScreen2();
				if(checking) {
					removeEventListener(Event.ENTER_FRAME, checkLoaded);
					checking = false;
				}
				if(checking2) {
					removeEventListener(Event.ENTER_FRAME, checkAnimation);
					checking2 = false;
				}
			}
		}
		
		private function checkAnimation(event:Event){
			if(animationComplete) {
				if(checking) {
					removeEventListener(Event.ENTER_FRAME, checkLoaded);
					checking = false;
				}
				if(checking2) {
					removeEventListener(Event.ENTER_FRAME, checkAnimation);
					checking2 = false;
				}
			}
		}
		
		public function doFileLoaded():void{
			fileloaded =true;
			//removeEventListener(Preloader.LOADING_DONE,doFileLoaded);
		}
		
		private function doContinueScreen2(){
			trace("doContinueScreen2");
			//tell all 3 "frozen" animations to "go"
			loadbar.gotoAndPlay("loaded");
			mainLoader.logo.gotoAndPlay("loaded");
			mainLoader.logo.bird.gotoAndPlay("loaded");
		}
		
		public function doAnimateOut(e:Event):void{
			trace("doAnimateOut");
			removeEventListener(Loadlogo.LOGO_DONE,doAnimateOut);
			TweenLite.to(mainLoader, .5, { x:-329, onComplete:doLoadingDone } );
		}
		
		private function doLoadingDone():void{
			dispatchEvent(new Event(DONE,true)); 
		}
	}
}