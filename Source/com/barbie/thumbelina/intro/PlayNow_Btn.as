
package com.barbie.thumbelina.intro{
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
	
	public class PlayNow_Btn extends MovieClip {
		
		private var channel:SoundChannel;
		private var click_snd:On_Click_Snd;
		
		public static const PLAY_NOW:String = "PLAY_NOW";
		private var pn:AnimatedBtn;
		
		public function PlayNow_Btn() {
			init();
		}
		
		private function init():void{
			click_snd = new On_Click_Snd();
			channel = new SoundChannel();
			pn = new AnimatedBtn(this,doPlayNow);
			addChild(pn);
			addEventListener(MouseEvent.CLICK,doClick);
		}
		
		private function doPlayNow(event:MouseEvent):void{
			trace("PlayNow_Btn: doPlayNow");
			dispatchEvent(new Event(PLAY_NOW,true));
		}
		
		
		private function doClick(event:MouseEvent):void{
			channel=click_snd.play();
		}
		
	}
}