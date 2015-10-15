
package com.barbie.thumbelina.game2{
	/** Class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.geom.ColorTransform;
	
	public class Color_Thumb extends MovieClip {
		
		//private var colorInfo:ColorTransform;
		private var bodyArray:Array;
		private var wingsArray:Array;
		private var wings2Array:Array;
		private var hairArray:Array;
		
		public function Color_Thumb() {
			trace("Color_Thumb: "+this);
			init();
		}
		
		private function init():void{
			bodyArray = new Array();
			wingsArray = new Array();
			wings2Array = new Array();
			hairArray = new Array();
			this.addEventListener(ColoringMovieClip.ADD_BODYPART,handleBP_Group);
			this.addEventListener(ColoringMovieClip.COLOR_GROUP,handleColor_Group);
		}
		
		
		private function handleBP_Group(e:Event):void{
			if(e.target.cgroup=="body") {
				bodyArray.push(e.target);
			}
			else if(e.target.cgroup=="wings1") {
				wingsArray.push(e.target);
			}
			else if(e.target.cgroup=="wings2") {
				wings2Array.push(e.target);
			}
			else if(e.target.cgroup=="hair") {
				hairArray.push(e.target);
			}
		}
		
		private function handleColor_Group(e:Event):void{
			if(e.target.cgroup=="body"){
					for(var i:int=0;i<bodyArray.length;i++){
						bodyArray[i].groupColor(e.target.newColor);
					}
			}
			else if(e.target.cgroup=="wings1"){
					for(var j:int=0;j<wingsArray.length;j++){
						wingsArray[j].groupColor(e.target.newColor);
					}
			}
			else if(e.target.cgroup=="wings2"){
					for(var j:int=0;j<wings2Array.length;j++){
						wings2Array[j].groupColor(e.target.newColor);
					}
			}
			else if(e.target.cgroup=="hair"){
					for(var k:int=0;k<hairArray.length;k++){
						hairArray[k].groupColor(e.target.newColor);
					}
			}
			
		}
		
		
	}
}