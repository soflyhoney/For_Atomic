
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
		private var iGroup:Boolean = false;
		private var iColor:String;
		private var myGroup:String;
		
		public function get hasG():Boolean{
			return iGroup;
		}
		public function get cgroup():String{
			return myGroup;
		}
		public function get newColor():*{
			return iColor;
		}
		
		public static const COLOR_ME:String = "COLOR_ME";
		public static const COLOR_GROUP:String = "COLOR_GROUP";
		public static const ADD_BODYPART:String = "ADD_BODYPART";
		public function ColoringMovieClip() {
			//trace("ColoringMC: "+this);
			init();
		}
		
		private function init():void{
			colorInfo = this.transform.colorTransform;
			addEventListener(MouseEvent.CLICK,doColorArea);
		}
		
		private function doColorArea(event:MouseEvent):void{
			trace("ColoringMC i was clicked: "+this);
			dispatchEvent(new Event(COLOR_ME,true));
		}
		
		public function groupColor(_color):void{
			colorInfo.color = _color;
			iColor = _color;
			// apply the change to the display object
			this.transform.colorTransform = colorInfo;
		}
		
		public function setColor(_color):void{
			colorInfo.color = _color;
			iColor = _color;
			// apply the change to the display object
			this.transform.colorTransform = colorInfo;
			if(iGroup) dispatchEvent(new Event(COLOR_GROUP,true));
		}
		
		public function registerPart(_group:String){
			trace("Coloring MC: registerPart"+_group);
			iGroup = true;
			myGroup = _group;
			dispatchEvent(new Event(ADD_BODYPART,true));
			//else if(_group == "hair") dispatchEvent(new Event(ADD_HAIRPART,true));
			//else if(_group == "wings") dispatchEvent(new Event(ADD_WINGSPART,true));
		}
		
	}
}