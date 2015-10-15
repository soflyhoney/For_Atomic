//Written by Rebecca A. Krug
package com.barbie.thumbelina.game1{
	/** Document class for Barbie Thumbelina Feb. 2009
	maybe not use this
	*/
	import flash.display.*;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import com.barbie.thumbelina.util.*;
	//import com.gs.TweenLite;
	
	public class Close_Btn extends MovieClip {
		
		private var channel:SoundChannel;
		private var click_snd:On_Click_Snd;
		
		public static const CLOSE_HELP:String = "CLOSE_HELP";
		private var cb:AnimatedBtn;
		
		public function Close_Btn() {
			init();
		}
		
		private function init():void{
			click_snd = new On_Click_Snd();
			channel = new SoundChannel();
			cb = new AnimatedBtn(this,doCloseHelp);
			addChild(cb);
			addEventListener(MouseEvent.CLICK,doClick);
		}
		
		private function doCloseHelp(event:MouseEvent):void{
			trace("PlayNow_Btn: doPlayNow");
			dispatchEvent(new Event(CLOSE_HELP,true));
		}
		
		private function doClick(event:MouseEvent):void{
			channel=click_snd.play();
		}
	}
}