﻿//Written by Rebecca A. Krug
package com.barbie.thumbelina.game2{
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
	
	public class Done_Btn extends MovieClip {
		
		private var channel:SoundChannel;
		private var click_snd:On_Click_Snd;
		
		public static const DONE_PAINTING:String = "DONE_PAINTING";
		private var cb:AnimatedBtn;
		
		public function Done_Btn() {
			init();
		}
		
		private function init():void{
			click_snd = new On_Click_Snd();
			channel = new SoundChannel();
			cb = new AnimatedBtn(this,doDone);
			addChild(cb);
			addEventListener(MouseEvent.CLICK,doClick);
		}
		
		private function doDone(event:MouseEvent):void{
			trace("DoneNow_Btn: doDone");
			dispatchEvent(new Event(DONE_PAINTING,true));
		}
		
		
		private function doClick(event:MouseEvent):void{
			channel=click_snd.play();
		}
		
		
	}
}