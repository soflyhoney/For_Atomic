//Written by Rebecca A. Krug
package com.barbie.thumbelina.game2{
	/** Class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.geom.ColorTransform;
	
	public class ColoringMovieClip extends MovieClip {
		
		private var colorInfo:ColorTransform;
		
		public static const COLOR_ME:String = "COLOR_ME";
		
		public function ColoringMovieClip() {
			trace("ColoringMC: "+this);
			init();
		}
		
		private function init():void{
			colorInfo = this.transform.colorTransform;
			addEventListener(MouseEvent.CLICK,doColorArea);
		}
		
		private function doColorArea(event:MouseEvent):void{
			dispatchEvent(new Event(COLOR_ME,true));
		}
		
		public function setColor(_color):void{
			colorInfo.color = _color;
			// apply the change to the display object
			this.transform.colorTransform = colorInfo;
		}
		
	}
}