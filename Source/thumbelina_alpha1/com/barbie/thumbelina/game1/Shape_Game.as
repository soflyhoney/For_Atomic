//Written by Rebecca A. Krug
package com.barbie.thumbelina.game1{
	/** Document class for Barbie Thumbelina Feb. 2009
	maybe not use this
	*/
	import flash.display.*;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.gs.TweenLite;
	import com.util.*;
	
	public class Shape_Game extends MovieClip {
		
		public static const CORRECT_FB:String = "CORRECT_FB";
		public static const INCORRECT_FB:String = "INCORRECT_FB";
		public static const GAME_NEWQ:String = "GAME_NEWQ";
		public static const GAME1_NEW:String = "GAME1_NEW";
		public static const GAME_OVER:String = "GAME_OVER";
		public static const FADE_SOUND:String = "FADE_SOUND";
		private var nu:NumberUtilites;
		private var qOrderArray:Array;
		private var game5_Array:Array
		private var numberToPass:int = 4;
		private var totalQ:int = 4;
		private var currentQ:int = 0;
		private var score:int = 0;
		private var correctAns:int;
		private var previousAns:int;
		private var timer:Timer;
		private var timer2:Timer;
		private var shapeArray:Array;
		private var shape0:Game_Piece;
		private var shape1:Game_Piece;
		private var shape2:Game_Piece;
		private var shape3:Game_Piece;
		private var shape4:Game_Piece;
		private var shape5:Game_Piece;
		private var shape6:Game_Piece;
		private var shape7:Game_Piece;
		private var shape8:Game_Piece;
		private var shape9:Game_Piece;
		private var shape10:Game_Piece;
		private var shape11:Game_Piece;
		private var shape12:Game_Piece;
		private var shape13:Game_Piece;
		private var shape14:Game_Piece;
		private var shape15:Game_Piece;
		private var vo:Shape_VO;
		
		public function Shape_Game() {
			trace("hello Shape_Game");
			init();
		}
		
		private function init():void{
			nu = new NumberUtilites();
			vo = new Shape_VO();
			addChild(vo);
			//addChild(nu);
			shape0 = new Game_Piece(0,gp0,"Click on the pink square!","pink_square");
			shape1 = new Game_Piece(1,gp1,"Click on the purple circle!","purple_circle");
			shape2 = new Game_Piece(2,gp2,"Click on the red circle!","red_circle");
			shape3 = new Game_Piece(3,gp3,"Click on the green diamond!","green_diamond");
			shape4 = new Game_Piece(4,gp4,"Click on the black diamond!","black_diamond");
			shape5 = new Game_Piece(5,gp5,"Click on the green triangle!","green_triangle");
			shape6 = new Game_Piece(6,gp6,"Click on the purple square!","purple_square");
			shape7 = new Game_Piece(7,gp7,"Click on the blue star!","blue_star");
			shape8 = new Game_Piece(8,gp8,"Click on the orange star!","orange_star");
			shape9 = new Game_Piece(9,gp9,"Click on the yellow triangle!","yellow_triangle");
			shape10 = new Game_Piece(10,gp10,"Click on the red rectangle!","red_rectangle");
			shape11 = new Game_Piece(11,gp11,"Click on the blue rectangle!","blue_rectangle");
			shape12 = new Game_Piece(12,gp12,"Click on the pink oval!","pink_oval");
			shape13 = new Game_Piece(13,gp13,"Click on the brown oval!","brown_oval");
			shape14 = new Game_Piece(14,gp14,"Click on the yellow heart!","yellow_heart");
			shape15 = new Game_Piece(15,gp15,"Click on the orange heart!","orange_heart");
			addChild(shape0);
			addChild(shape1);
			addChild(shape2);
			addChild(shape3);
			addChild(shape4);
			addChild(shape5);
			addChild(shape6);
			addChild(shape7);
			addChild(shape8);
			addChild(shape9);
			addChild(shape10);
			addChild(shape11);
			addChild(shape12);
			addChild(shape13);
			addChild(shape14);
			addChild(shape15);
			timer = new Timer(0, 60);
			timer2 = new Timer(0, 40);
      
			beginNewGame();
		}
		
		private function beginNewGame():void{
			currentQ = 0;
			score = 0;
			this.title.title_mc.title_txt.text = "Hello";
			//randomly select 5 out of 16, form an array
			game5_Array = nu.randomUniqueIntArray(0, 15, 5);
			qOrderArray = nu.randomUniqueIntArray(0, 5, 5);
			var n:Number = qOrderArray[currentQ];
			shapeArray = new Array();
			for(var j:int;j<game5_Array.length;j++){
				var m:int = game5_Array[j];
				var shape:MovieClip = this["gp"+m];
				shapeArray.push(shape);
			}
			
			correctAns = game5_Array[n];
			//place these 5 items in the game
			shapeArray[0].x = 26;
			shapeArray[0].y = 92;
			shapeArray[1].x = 120;
			shapeArray[1].y = 92;
			shapeArray[2].x = 217;
			shapeArray[2].y = 92;
			shapeArray[3].x = 77;
			shapeArray[3].y = 164;
			shapeArray[4].x = 167;
			shapeArray[4].y = 164;
			
			for(var i:int;i<shapeArray.length;i++){
				var myPiece:MovieClip = shapeArray[i];
				TweenLite.to(myPiece, .5, { alpha:1} );
			}
			//load new title
			var myGP:Game_Piece = this["shape"+correctAns];
			vo.gotoAndPlay(myGP.soundf)
			this.title.title_mc.title_txt.text = myGP.getTitle;
			this.title.gotoAndPlay("go");
			//wait for user selection
			addEventListener(Game_Piece.CHOSEN,itemSelected);
			dispatchEvent(new Event(GAME1_NEW,true));
			enableShapes();
		}
		
		private function beginNewTurn(){
			currentQ++;
			if(currentQ > totalQ) currentQ=0;
			var n:Number = qOrderArray[currentQ];
			correctAns = game5_Array[n];
			var myGP:Game_Piece = this["shape"+correctAns];
			trace("Shape_Game myGP: "+myGP.soundf);
			this.title.title_mc.title_txt.text = myGP.getTitle;
			vo.gotoAndPlay(myGP.soundf)
			this.title.gotoAndPlay("go");
			enableShapes();
		}
		
		private function itemSelected(e:Event):void{
			//check if id is correct id
			disableShapes();
			if(e.target.id == correctAns) {
				e.target.doNice();
				correctFB();
			}
			else {
				e.target.doOops();
				incorrectFB();
			}
		}
		
		private function correctFB():void{
			//add one to score
			score++;
			dispatchEvent(new Event(CORRECT_FB,true));
			setCloseTimer();
			//show Nice animation
			
		}
		
		private function incorrectFB():void{
			//play incorrect fb
			dispatchEvent(new Event(INCORRECT_FB,true));
			setCloseTimer();
			//show Oops animation
			
		}
		
		private function setCloseTimer():void{
			timer.reset();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, closeOutQuestion);
			timer.start();
		}
		
		private function closeOutQuestion(e:Event):void{
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, closeOutQuestion);
			this.title.gotoAndPlay("bye");
			timer.reset();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, nextQuestion);
			timer.start();
		}
		
		private function nextQuestion(e:Event):void{
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, nextQuestion);
			//dispatchEvent(new Event(GAME_NEWQ,true));
			proceedWithGame();
		}
		
		private function proceedWithGame():void{
			//if complete, go on to next game
			//if((score < numberToPass)&&(currentQ < totalQ)){
			if(score < numberToPass){
				dispatchEvent(new Event(GAME_NEWQ,true));
				beginNewTurn();
			}
			/*else if((score < numberToPass)&&(currentQ == totalQ)) {
				for(var i:int=0;i<shapeArray.length;i++){
					var myPiece:MovieClip = shapeArray[i];
					TweenLite.to(myPiece, .5, { alpha:0} );
				}
				//dispatchEvent(new Event(GAME_NEWQ,true));
				timer.reset();
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, newGame);
				timer.start();
				
			}*/
			else {
				dispatchEvent(new Event(FADE_SOUND,true));
				timer2.addEventListener(TimerEvent.TIMER_COMPLETE, gameOver);
				timer2.start();
			}
		}
		
		private function gameOver(e:Event):void{
			trace("game over");
			timer2.removeEventListener(TimerEvent.TIMER_COMPLETE, gameOver);
			dispatchEvent(new Event(GAME_OVER,true));
		}
		
		private function newGame(e:Event):void{
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, newGame);
			for(var j:int=0;j<shapeArray.length;j++){
					var myPiece2:MovieClip = shapeArray[j];
					TweenLite.to(myPiece2, .5, { x:-300, y:-300} );
			}
			beginNewGame();
		}
		
		private function disableShapes():void{
			for(var j:int;j<game5_Array.length;j++){
				var m:int = game5_Array[j];
				var shape:Game_Piece = this["shape"+m];
				shape.disable();
			}
			
		}
		
		private function enableShapes():void{
			for(var j:int;j<game5_Array.length;j++){
				var m:int = game5_Array[j];
				var shape:Game_Piece = this["shape"+m];
				shape.enable();
			}
			
		}
		
		
		
	}
}