package com.barbie.thumbelina{
	/** Document class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	import com.barbie.thumbelina.loader.*;
	
	
	public class LoaderMain extends MovieClip {
		public var mySwf:*;
		private var preshell:MovieClip;
		private var shell:MovieClip;
		private var loader:Loader;
		private var preloader:Preloader;
		private var loaders:LoadMaster
		
		public function LoaderMain() 
		{
			trace("hello from LoaderMain");
			init();
		}
		
		private function init():void{
			Security.allowDomain('*');
			displayLoader();
		}
		
		private function displayLoader():void{
			trace("displayLoader");
			preshell = new MovieClip();
			addChild(preshell);
			addEventListener(Loadbar.PRELOADER,doPreload);
			//this.addEventListener(Event.ENTER_FRAME, loading);
			loaders = new LoadMaster();
			loaders.x = -161;
			loaders.y = -151;
			
			preshell.addChild(loaders);
			//addSoundBtn();
		}
		
		
		private function doPreload(e:Event):void{
			preloader = new Preloader();
			preloader.x = 233;
			preloader.y = 375;
			preshell.addChild(preloader);
			//addEventListener(Preloader.LOADING_DONE,completeHandler);
			shell = new MovieClip();
			addChildAt(shell,0);
			shell.visible = false;
			var request:URLRequest = new URLRequest("_swf/thumbe.swf");
			//var request:URLRequest = new URLRequest("thumbe.swf");
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);

			loader.load(request);
			shell.addChild(loader);
			addEventListener(LoadMaster.DONE,doNext);
		}
		
		function onLoadProgress(event:ProgressEvent):void
		
			
			{
				//this.removeEventListener(Event.ENTER_FRAME, loading);
				var loadedPct:uint =         Math.round(100 * (event.bytesLoaded / event.bytesTotal));
				preloader.setBar(loadedPct);
				//trace("The mc is " + loadedPct + "% loaded.");
				//if(loadedPct >= 100) completeHandler(null)
			}
		
		private function doNext(e:Event):void{
			trace("do next");
			preshell.visible = false;
			shell.visible = true;
			mySwf = loader.content;
			mySwf.doIntroScreen(null);
			
			//preloader.doLoadingComplete();
			
		}
		
		private function completeHandler(event:Event){
			//when the swf is done loading, send it the pertinent data
			preloader.visible = false;
			
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			trace("done");
			//mySwf = loader.content;
			//mySwf.doIntroScreen(null);
			//doNext(null);
			loaders.doFileLoaded();
		}
	}
}