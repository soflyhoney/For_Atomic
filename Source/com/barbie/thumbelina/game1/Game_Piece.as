
package com.barbie.thumbelina.game1{
	/** Document class for Barbie Thumbelina Feb. 2009
	maybe not use this
	*/
	import flash.display.*;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import com.barbie.thumbelina.util.*;
	
	public class Game_Piece extends MovieClip {
		
		public static const CHOSEN:String = "CHOSEN";
		private var nice:Nice_Anim;
		private var oops:Oops_Anim;
		private var gid:int;
		private var mc:MovieClip;
		private var question:String;
		private var gp:AnimatedBtn;
		private var sf:String;
		
		public function get soundf():String{
			return sf;
		}
		public function get id():int{
			return gid;
		}
		public function get getTitle():String{
			return question;
		}
		
		public function Game_Piece(_gid:int,_mc:MovieClip,_q:String,_soundframe:String) {
			trace("hello Shape_Game");
			sf = _soundframe;
			gid = _gid;
			mc = _mc;
			mc.x = -300;
			mc.y = -300;
			question = _q;
			init();
		}
		
		private function init():void{
			nice = new Nice_Anim();
			mc.addChild(nice);
			oops = new Oops_Anim();
			mc.addChild(oops);
			gp = new AnimatedBtn(mc,doSelectMe);
			addChild(gp);
		}
		
		private function doSelectMe(event:MouseEvent):void{
			trace("Game_Piece: i was selected: "+gid);
			dispatchEvent(new Event(CHOSEN,true));
		}
		
		public function disable():void{
			gp.disableBtn();
		}
		
		public function enable():void{
			gp.enableBtn();
		}
		 public function doNice():void{
			nice.play(); 
		 }
		 
		 public function doOops():void{
			oops.play(); 
		 }
		
		
	}
}