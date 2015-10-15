
package com.barbie.thumbelina.game2{
	/** Class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	
	public class Color_Paint extends MovieClip {
		
		private var myColor:String;
		private var mc:MovieClip;
		
		public static const OVER_COLOR:String = "OVER_COLOR";
		public static const OUT_COLOR:String = "OUT_COLOR";
		public static const SELECT_COLOR:String = "SELECT_COLOR";
		
		public function get thisColor():String{
			return myColor;
		}
		
		public function Color_Paint(_mc:MovieClip,_color:String) {
			trace("hello from Color_Paint!"+_color);
			myColor = _color;
			mc = _mc;
			init();
		}
		
		private function init():void{
			mc.buttonMode = true;
			mc.useHandCursor = false;
			mc.addEventListener(MouseEvent.ROLL_OVER,doOverColor);
			mc.addEventListener(MouseEvent.ROLL_OUT,doOutColor);
			mc.addEventListener(MouseEvent.CLICK,doSelectColor);
		}
		
		private function doOverColor(event:MouseEvent):void{
			trace("over color!: "+myColor);
			dispatchEvent(new Event(OVER_COLOR,true));
		}
		
		private function doOutColor(event:MouseEvent):void{
			trace("out color!: "+myColor);
			dispatchEvent(new Event(OUT_COLOR,true));
		}
		
		private function doSelectColor(event:MouseEvent):void{
			trace("select color!: "+myColor);
			dispatchEvent(new Event(SELECT_COLOR,true));
		}
		
	}
}