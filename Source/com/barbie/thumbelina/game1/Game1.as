﻿
package com.barbie.thumbelina.game1{
	/** Document class for Barbie Thumbelina Feb. 2009
	maybe not use this
	*/
	import flash.display.*;
	import flash.events.*;
	import flash.events.EventDispatcher;
	
	public class Game1 extends MovieClip {
		
		//public static const CLOSE_HELP:String = "CLOSE_HELP";
		
		
		public function Game1() {
			trace("hello Game1");
			init();
		}
		
		private function init():void{
			addEventListener(Shape_Game.GAME_OVER, doGameOver)
		}
		
		private function doGameOver(e:Event):void{
			trace("Game 1 over");
			panel.gotoAndPlay("bye");
		}
		
		
		
		
		
	}
}