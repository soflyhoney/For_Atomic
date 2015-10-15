//Written by Rebecca A. Krug
package com.barbie.thumbelina{
	/** Document class for Barbie Thumbelina Feb. 2009
	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import fl.motion.easing.Elastic;
	import flash.utils.Timer;
	import com.gs.TweenLite;
	
	import com.barbie.thumbelina.loader.*;
	import com.barbie.thumbelina.intro.*;
	import com.barbie.thumbelina.util.*;
	import com.barbie.thumbelina.game1.*;
	import com.barbie.thumbelina.game2.*;
	import com.barbie.thumbelina.sound.*;
	
	public class Main extends MovieClip {
		
		private var bg:Background;
		private var soundbtn:Sound_Btn;
		private var helpbtn:Help_Btn;
		private var sbOn:AnimatedBtn;
		private var sbOff:AnimatedBtn;
		private var hb:AnimatedBtn;
		private var playNow:PlayNow_Btn;
		private var flowers:Flowers;
		private var loader:LoadMaster;
		private var intro:IntroMaster;
		private var trees:Trees;
		private var game1:Game1;
		private var channel:SoundChannel;
		private var channel2:SoundChannel;
		private var channel3:SoundChannel;
		private var mouth:Mouth;
		private var game2:Coloring_Game;
		private var help2:Help2_MC;
		private var g2_Btns:Game2_btns;
		private var game2_music:Game2_Music;
		private var wow_pretty:Wow_Pretty;
		private var end_song:End_Song;
		private var intro_music:Intro_Music;
		private var bird1:Bird1;
		private var game_old:Coloring_Game;
		private var fadeInIncr:Number = 0;
		private var masterInIncr:Number = 0;
		private var soundFadeInTimer:Timer;
		private var soundFadeOutTimer:Timer;
		private var masterSoundFadeInTimer:Timer;
		private var masterSoundFadeOutTimer:Timer;
		private var printer:Printer;
		private var soundPlaying:Boolean = false;
		public function Main() 
		{
			trace("hello from Main");
			init();
		}
		
		private function init():void{
			//load background
			channel = new SoundChannel();
			channel2 = new SoundChannel();
			channel3 = new SoundChannel();
			end_song = new End_Song();
			bg = new Background();
			bg.x = -143;
			bg.y = -34;
			addChild(bg);
			trees = new Trees();
			trees.x = -161;
			trees.y = -151;
			trees.visible = false;
			addChild(trees);
			displayLoader();
			addEventListener(LoadMaster.DONE,doIntroScreen);
			masterSoundFadeOutTimer = new Timer(100,15);
			masterSoundFadeOutTimer.addEventListener("timer", masterFadeOut);
			masterSoundFadeInTimer = new Timer(100,30);
			masterSoundFadeInTimer.addEventListener("timer", masterFadeIn);
		}
		
		private function displayLoader():void{
			loader = new LoadMaster();
			loader.x = -161;
			loader.y = -151;
			addChild(loader);
			//addSoundBtn();
		}
		
		private function addSoundBtn(){
			soundbtn = new Sound_Btn();
			//soundbtn.x = 663;
			soundbtn.x = 700;
			soundbtn.y = 8;
			soundbtn.onToOff_btn.visible = true;
			soundbtn.offToOn_btn.visible = false;
			addChild(soundbtn);
			TweenLite.to(soundbtn, .5, { x:663} );
			sbOn = new AnimatedBtn(soundbtn.onToOff_btn,doSoundOff);
			addChild(sbOn);
			sbOff = new AnimatedBtn(soundbtn.offToOn_btn,doSoundOn);
			addChild(sbOff);
		}
		
		private function doIntroScreen(e:Event):void{
			addEventListener(IntroMaster.PLAY_INTRO_MUSIC,playIntroMusic);
			
			
			addEventListener(TalkClip.TALK_DONE,doShowPlayBtn);
			removeEventListener(LoadMaster.DONE,doIntroScreen);
			displayIntroScreen();
		}
		
		private function playIntroMusic(e:Event):void{
			var intro_music = new Intro_Music();
			var sAmbienceVol:SoundTransform = new SoundTransform(0, 0);
			channel = intro_music.play();
			trace("main doIntroScreen 2");
			channel.soundTransform = sAmbienceVol;
			
			soundFadeInTimer = new Timer(100,30);
			soundFadeInTimer.addEventListener("timer", soundFadeIn);
			soundFadeInTimer.start();
			soundFadeOutTimer = new Timer(100,15);
			soundFadeOutTimer.addEventListener("timer", soundFadeOut);
		}
		
		private function doShowPlayBtn(e:Event):void{
			trace("show play button");
			removeEventListener(TalkClip.TALK_DONE,doShowPlayBtn);
			playNow = new PlayNow_Btn();
			playNow.x = 102;
			playNow.y = 223;
			intro.panel.addChild(playNow);
			TweenLite.from(playNow, 2, { y:423,ease:Elastic.easeInOut} );
			
		}
		
		private function doSoundOff(event:MouseEvent):void{
			trace("Main: doSoundOff");
			//SoundMixer.soundTransform = new SoundTransform(0);
			masterInIncr = 1;
			masterSoundFadeOutTimer.reset();
			masterSoundFadeOutTimer.start();
			soundbtn.onToOff_btn.visible = false;
			soundbtn.offToOn_btn.visible = true;
		}
		
		private function doSoundOn(event:MouseEvent):void{
			trace("Main: doSoundOn");
			masterInIncr = 0;
			masterSoundFadeInTimer.reset();
			masterSoundFadeInTimer.start();
			//SoundMixer.soundTransform = new SoundTransform(1);
			soundbtn.onToOff_btn.visible = true;
			soundbtn.offToOn_btn.visible = false;
		}
		
		private function displayIntroScreen():void{
			//add and play tree and flowers here, frame 2
			addSoundBtn();
			trees.visible = true;
			trees.gotoAndPlay("step2");
			mouth = new Mouth(trees.thumbelina.body.head.mouth);
			//trees.thumbelina.body.head.mouth.gotoAndPlay("hi");
			mouth.doIntro();
			intro = new IntroMaster();
			intro.x = -161;
			intro.y = -151;
			addChild(intro);
			flowers = new Flowers();
			flowers.x = -161;
			flowers.y = -151;
			addChild(flowers);
			removeChild(loader);
			flowers.gotoAndPlay("step2");
			addEventListener(PlayNow_Btn.PLAY_NOW,endIntro);
		}
		
		private function endIntro(e:Event):void{
			channel.stop();
			
			fadeInIncr = 0;
			//soundFadeInTimer.addEventListener("timer", soundFadeIn);
			var game1_music:Game1_Music = new Game1_Music();
			var sAmbienceVol:SoundTransform = new SoundTransform(0, 0);         
			channel = game1_music.play(0,1000);
			channel.soundTransform = sAmbienceVol;
			soundFadeInTimer.reset();
			soundFadeInTimer.start();
			TweenLite.to(playNow, 2, { y:423,ease:Elastic.easeInOut} );
			//trees.thumbelina.body.head.mouth.gotoAndPlay("game1");
			mouth.doGame1();
			removeEventListener(PlayNow_Btn.PLAY_NOW,endIntro);
			trees.gotoAndPlay("step3");
			flowers.gotoAndPlay("step3");
			//addEventListener(IntroPanel.INTRO_DONE,startGame1);
			addEventListener(TalkClip.TALK_DONE,startGame1);
		}
		
		private function startGame1(e:Event):void{
			
			removeEventListener(TalkClip.TALK_DONE,startGame1);
			helpbtn = new Help_Btn();
			helpbtn.x = 863;
			helpbtn.y = 44;
			TweenLite.to(helpbtn, .5, { x:663} );
			addChild(helpbtn);
			hb = new AnimatedBtn(helpbtn,doHelp);
			removeChild(intro);
			game1 = new Game1();
			game1.x = -161;
			game1.y = -151;
			addChild(game1);
			addEventListener(Shape_Game.CORRECT_FB,doCorrectFB);
			addEventListener(Shape_Game.INCORRECT_FB,doIncorrectFB);
			addEventListener(Shape_Game.GAME_NEWQ,doNewQ);
			addEventListener(Shape_Game.GAME1_NEW,doNewGame);
			addEventListener(Shape_Game.GAME_OVER,doGame1_Over);
			addEventListener(Shape_Game.FADE_SOUND,doFadeSound);
		}
		
		private function doHelp(event:MouseEvent):void{
			game1.help.gotoAndPlay("see");
			hb.disableBtn();
			addEventListener(Close_Btn.CLOSE_HELP,closeHelp);
		}
		
		private function closeHelp(e:Event):void{
			hb.enableBtn();
			removeEventListener(Close_Btn.CLOSE_HELP,closeHelp);
			game1.help.gotoAndPlay("bye");
		}
		
		private function doCorrectFB(e:Event):void{
			trace("Main: Correct");
			mouth.doCorrect();
		}
		
		private function doIncorrectFB(e:Event):void{
			trace("Main: InCorrect");
			mouth.doIncorrect();
		}
		
		private function doNewQ(e:Event):void{
			trace("Main: doNewQs");
			mouth.goIdle();
		}
		
		private function doNewGame(e:Event):void{
			trace("Main: doNewQs");
			mouth.resetFB();
		}
		
		private function doGame1_Over(e:Event):void{
			trace("Main: doGame1_Over");
			channel.stop();
			trace("Main: doGame1_Over 1");
			game2_music = new Game2_Music();
			wow_pretty = new Wow_Pretty();
			
			removeEventListener(Shape_Game.CORRECT_FB,doCorrectFB);
			removeEventListener(Shape_Game.INCORRECT_FB,doIncorrectFB);
			removeEventListener(Shape_Game.GAME_NEWQ,doNewQ);
			
			removeEventListener(Shape_Game.GAME_OVER,doGame1_Over);
			removeEventListener(Close_Btn.CLOSE_HELP,closeHelp);
			var gmask:Trans2_mask = new Trans2_mask();
			game1.mask = gmask;
			trace("Main: doGame1_Over2");
			trees.gotoAndPlay("bye");
			flowers.gotoAndPlay("bye");
			
			printer = new Printer();
			//soundFadeInTimer.addEventListener("timer", soundFadeIn);
			//fadeInIncr = 0;
			
			//var sAmbienceVol:SoundTransform = new SoundTransform(0, 0);         
			//channel = game2_music.play(0,1000);
			//channel.soundTransform = sAmbienceVol;
			//soundFadeInTimer.reset();
			//soundFadeInTimer.start();
			
			bird1 = new Bird1();
			addEventListener(Bird1.CHANGE_GAME,startGame2);
			addChild(bird1);
			//startGame2();
		}
		
		private function startGame2(e:Event):void{
			//var bird1:Bird1 = new Bird1();
			//addChild(bird1);
			//channel = game2_music.play(0,1000);
			hb = new AnimatedBtn(helpbtn,doHelp2);
			game2 = new Coloring_Game();
			game2.x = -243;
			game2.y = -74;
			help2 = new Help2_MC();
			help2.x = 107;
			help2.y = 100;
			addChild(help2);
			addChildAt(game2,2);
			showGameBtns();
			addEventListener(Print_Btn.PRINT,doPrint);
			if(!soundPlaying){
				var sAmbienceVol:SoundTransform = new SoundTransform(1, 0);
				channel = game2_music.play(0,1000);
				channel.soundTransform = sAmbienceVol;
				soundPlaying = true;
			}
			//var pLogos = new Print_logos();
			//addChild(pLogos);
			//TweenLite.to(game2, .5, { x:-243, delay:1.9, onComplete:showGameBtns} );
		}
		
		private function showGameBtns():void
		{
			g2_Btns = new Game2_btns();
			g2_Btns.x = 270;
			g2_Btns.y = 212;
			addChild(g2_Btns);
			g2_Btns.gotoAndPlay("f1");
			addEventListener(Done_Btn.DONE_PAINTING,doDone);
		}
		
		private function doHelp2(event:MouseEvent):void{
			help2.gotoAndPlay("see");
			hb.disableBtn();
			addEventListener(Close_Btn.CLOSE_HELP,closeHelp2);
		}
		
		private function closeHelp2(e:Event):void{
			removeEventListener(Close_Btn.CLOSE_HELP,closeHelp2);
			hb.enableBtn();
			help2.gotoAndPlay("bye");
		}
		
		private function doDone(e:Event):void{
			TweenLite.to(helpbtn, .5, { x:773} );
			removeEventListener(Done_Btn.DONE_PAINTING,doDone);
			addEventListener(PlayAgain_Btn.PLAY_AGAIN,doPlayAgain);
			game2.dropPaintbrush();
			channel.stop();
			channel3 = end_song.play(0,1000);
			channel2 = wow_pretty.play();
			g2_Btns.gotoAndPlay("byef");
		}
		
		private function doPlayAgain(e:Event):void{
			//game2.stopAnimation();
			TweenLite.to(helpbtn, .5, { x:663} );
			removeEventListener(PlayAgain_Btn.PLAY_AGAIN,doPlayAgain);
			game_old = new Coloring_Game();
			game_old = game2;
			removeChild(g2_Btns);
			bird1.gotoAndPlay(1);
			channel3.stop();
			channel = game2_music.play(0,1000);
			//TweenLite.to(game_old, .5, { x:473, delay:1.9} );
			addEventListener(Bird1.CHANGE_GAME,removeGame2);
			//startGame2();
		}
		
		private function removeGame2(e:Event):void{
			removeEventListener(Bird1.CHANGE_GAME,removeGame2);
			removeChild(game_old);
		}
		
		private function doFadeSound(e:Event){
			soundFadeOutTimer.reset();
			fadeInIncr = 1;
			soundFadeOutTimer.start();
		}
		
		private function soundFadeOut(e:TimerEvent){     
			fadeInIncr -= 1/15;         
			var sAmbienceVol:SoundTransform = new SoundTransform(fadeInIncr, 0);         
			channel.soundTransform = sAmbienceVol;     
			//trace("fade out: "+fadeInIncr); 
		}
		
		private function soundFadeIn(e:TimerEvent){     
			fadeInIncr += 1/30;         
			var sAmbienceVol:SoundTransform = new SoundTransform(fadeInIncr, 0);         
			channel.soundTransform = sAmbienceVol;     
			//trace(fadeInIncr); 
		}
		
		private function masterFadeIn(e:TimerEvent){     
			masterInIncr += 1/30;         
			//var sAmbienceVol:SoundTransform = new SoundTransform(fadeInIncr, 0);         
			//channel.soundTransform = sAmbienceVol;
			SoundMixer.soundTransform = new SoundTransform(masterInIncr);
			trace("master in: "+masterInIncr); 
		}
		
		private function masterFadeOut(e:TimerEvent){     
			masterInIncr -= 1/15;          
			//var sAmbienceVol:SoundTransform = new SoundTransform(fadeInIncr, 0);         
			//channel.soundTransform = sAmbienceVol;
			SoundMixer.soundTransform = new SoundTransform(masterInIncr);
			trace("master out: "+masterInIncr); 
		}
		
		private function doPrint(e:Event):void{
			trace("Main: "+doPrint);
			addEventListener(Printer.PRINT_DONE,doDonePrint);
			g2_Btns.visible = false;
			//printer.setPrint();
			addChild(printer);
			printer.printJob(this);
		}
		
		private function doDonePrint(e:Event){
			removeEventListener(Printer.PRINT_DONE,doDonePrint);
			if(e.target.orient == "p") 
			{	
				this.rotation = 0;
				this.x -=450;
			}
			//this.y = 0;
			trace("print done: "+e.target.orient);
			g2_Btns.visible = true;
		}
		
	}
}