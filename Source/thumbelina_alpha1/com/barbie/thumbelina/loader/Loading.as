//Written by Rebecca A. Krug
package com.barbie.thumbelina.loader{
	/** Document class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import com.gs.TweenLite;
	import flash.text.TextField;
	
	
	public class Loading extends MovieClip {
		
		private var fileloaded:Boolean = false;
		private var mainLoader:LoaderMain;
		private var loadbar:Loadbar;
		
		public static const LOADING_DONE:String = "LOADING_DONE";
		
		public function Loading() 
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
			trace("Loading animationInComplete");
			//temp value
			fileloaded =true;
			if(fileloaded) doContinueScreen2();
		}
		
		
		private function doContinueScreen2(){
			//tell all 3 "frozen" animations to "go"
			loadbar.gotoAndPlay("loaded");
			mainLoader.logo.gotoAndPlay("loaded");
			mainLoader.logo.bird.gotoAndPlay("loaded");
		}
		
		public function doAnimateOut(e:Event):void{
			//this occurs after the data is loaded
			TweenLite.to(mainLoader, .5, { x:-329, onComplete:doLoadingDone } );
		}
		
		private function doLoadingDone():void{
			trace("start game");
			dispatchEvent(new Event(LOADING_DONE,true)); 
		}
	}
}