
package com.barbie.thumbelina.game2{
	/** Document class for Barbie Thumbelina Feb. 2009
	maybe not use this
	*/
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import com.barbie.thumbelina.util.*;
	
	public class Print_Btn extends MovieClip {
		
		private var channel:SoundChannel;
		private var click_snd:On_Click_Snd;
		
		public static const PRINT:String = "PRINT";
		private var cb:AnimatedBtn;
		
		public function Print_Btn() {
			init();
		}
		
		private function init():void{
			click_snd = new On_Click_Snd();
			channel = new SoundChannel();
			cb = new AnimatedBtn(this,doPrint);
			addChild(cb);
			addEventListener(MouseEvent.CLICK,doClick);
		}
		
		private function doPrint(event:MouseEvent):void{
			dispatchEvent(new Event(PRINT,true));
		}
		
		
		private function doClick(event:MouseEvent):void{
			channel=click_snd.play();
		}
		
	}
}