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
	import flash.ui.Mouse;
	
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
		private var hb1:AnimatedBtn;
		private var hb2:AnimatedBtn;
		private var playNow:PlayNow_Btn;
		private var flowers:Flowers;
		private var intro:IntroMaster;
		private var trees:Trees;
		private var game1:Game1;
		private var channel:SoundChannel;
		private var channel2:SoundChannel;
		private var channel3:SoundChannel;
		private var mouth:Mouth;
		private var game2:Coloring_Game;
		private var help2:Help2_MC;
		private var helpShowing:Boolean;
		private var g2_Btns:Game2_btns;
		private var game2_music:Game2_Music;
		private var endGame2_Snd:EndGame2_Snd;
		private var creative:Get_Creative;
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
		private var nowPrinting:NowPrinting_MC;
		private var content_mc:MovieClip;
		
		
		public function Main() 
		{
			trace("hello from Main");
			init();
		}
		
		private function init():void{
			//load backgroundClip();
			this.stop();
			
			nowPrinting = new NowPrinting_MC();
			nowPrinting.visible = false;
			content_mc = new MovieClip();
			addChildAt(content_mc,0);
			addChildAt(nowPrinting,1);
			channel = new SoundChannel();
			channel2 = new SoundChannel();
			channel3 = new SoundChannel();
			end_song = new End_Song();
			bg = new Background();
			bg.x = -143;
			bg.y = -34;
			content_mc.addChild(bg);
			trees = new Trees();
			trees.x = -161;
			trees.y = -151;
			trees.visible = false;
			content_mc.addChild(trees);
			masterSoundFadeOutTimer = new Timer(100,15);
			masterSoundFadeOutTimer.addEventListener("timer", masterFadeOut);
			masterSoundFadeInTimer = new Timer(100,30);
			masterSoundFadeInTimer.addEventListener("timer", masterFadeIn);
		}
		
		private function addSoundBtn(){
			soundbtn = new Sound_Btn();
			//soundbtn.x = 663;
			soundbtn.x = 700;
			soundbtn.y = 8;
			soundbtn.onToOff_btn.visible = true;
			soundbtn.offToOn_btn.visible = false;
			content_mc.addChild(soundbtn);
			TweenLite.to(soundbtn, .5, { x:663} );
			sbOn = new AnimatedBtn(soundbtn.onToOff_btn,doSoundOff);
			content_mc.addChild(sbOn);
			sbOff = new AnimatedBtn(soundbtn.offToOn_btn,doSoundOn);
			content_mc.addChild(sbOff);
		}
		
		public function doIntroScreen(e:Event):void{
			addEventListener(IntroMaster.PLAY_INTRO_MUSIC,playIntroMusic);
			addEventListener(TalkClip.TALK_DONE,doShowPlayBtn);
			displayIntroScreen();
		}
		
		private function playIntroMusic(e:Event):void{
			var intro_music = new Intro_Music();
			var sAmbienceVol:SoundTransform = new SoundTransform(0, 0);
			channel = intro_music.play();
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
			masterInIncr = 1;
			masterSoundFadeOutTimer.reset();
			masterSoundFadeOutTimer.start();
			soundbtn.onToOff_btn.visible = false;
			soundbtn.offToOn_btn.visible = true;
		}
		
		private function doSoundOn(event:MouseEvent):void{
			masterInIncr = 0;
			masterSoundFadeInTimer.reset();
			masterSoundFadeInTimer.start();
			soundbtn.onToOff_btn.visible = true;
			soundbtn.offToOn_btn.visible = false;
		}
		
		private function displayIntroScreen():void{
			addSoundBtn();
			trees.visible = true;
			trees.gotoAndPlay("step2");
			mouth = new Mouth(trees.thumbelina.body.head.mouth);
			addChild(mouth);
			mouth.doIntro();
			intro = new IntroMaster();
			intro.x = -161;
			intro.y = -151;
			content_mc.addChild(intro);
			flowers = new Flowers();
			flowers.x = -161;
			flowers.y = -151;
			content_mc.addChild(flowers);
			flowers.gotoAndPlay("step2");
			addEventListener(PlayNow_Btn.PLAY_NOW,endIntro);
			game2_music = new Game2_Music();
			creative = new Get_Creative();
			endGame2_Snd = new EndGame2_Snd();
			addChild(endGame2_Snd);
		}
		
		private function endIntro(e:Event):void{
			channel.stop();
			fadeInIncr = 0;
			var game1_music:Game1_Music = new Game1_Music();
			var sAmbienceVol:SoundTransform = new SoundTransform(0, 0);         
			channel = game1_music.play(0,1000);
			channel.soundTransform = sAmbienceVol;
			soundFadeInTimer.reset();
			soundFadeInTimer.start();
			TweenLite.to(playNow, 2, { y:423,ease:Elastic.easeInOut} );
			mouth.doGame1();
			removeEventListener(PlayNow_Btn.PLAY_NOW,endIntro);
			trees.gotoAndPlay("step3");
			flowers.gotoAndPlay("step3");
			addEventListener(TalkClip.TALK_DONE,startGame1);
		}
		
		private function startGame1(e:Event):void{
			removeEventListener(TalkClip.TALK_DONE,startGame1);
			helpbtn = new Help_Btn();
			helpbtn.x = 863;
			helpbtn.y = 44;
			TweenLite.to(helpbtn, .5, { x:663} );
			content_mc.addChild(helpbtn);
			hb1 = new AnimatedBtn(helpbtn,doHelp);
			content_mc.removeChild(intro);
			game1 = new Game1();
			game1.x = -161;
			game1.y = -151;
			content_mc.addChild(game1);
			addEventListener(Shape_Game.CORRECT_FB,doCorrectFB);
			addEventListener(Shape_Game.INCORRECT_FB,doIncorrectFB);
			addEventListener(Shape_Game.GAME_NEWQ,doNewQ);
			addEventListener(Shape_Game.GAME1_NEW,doNewGame);
			addEventListener(Shape_Game.GAME_OVER,doGame1_Over);
			addEventListener(Shape_Game.FADE_SOUND,doFadeSound);
		}
		
		private function startGame1_again(e:Event):void{
			hb2.disableBtn();
			hb2.visible = false;
			soundPlaying = false;
			channel.stop();
			channel2.stop();
			channel3.stop();
			fadeInIncr = 0;
			var game1_music:Game1_Music = new Game1_Music();
			var sAmbienceVol:SoundTransform = new SoundTransform(0, 0);         
			channel = game1_music.play(0,1000);
			channel.soundTransform = sAmbienceVol;
			soundFadeInTimer.reset();
			soundFadeInTimer.start();
			content_mc.removeChild(game1);
			trees.gotoAndPlay("step3");
			flowers.gotoAndPlay("step3");
			Mouse.show();
			removeEventListener(Bird1.CHANGE_GAME,startGame1_again);
			addEventListener(Bird1.CHANGE_GAME,removeGame2);
			helpbtn = new Help_Btn();
			helpbtn.x = 863;
			helpbtn.y = 44;
			TweenLite.to(helpbtn, .5, { x:663} );
			content_mc.addChild(helpbtn);
			hb1 = new AnimatedBtn(helpbtn,doHelp);
			game1 = new Game1();
			game1.x = -161;
			game1.y = -151;
			content_mc.addChildAt(game1,2);
			addEventListener(Shape_Game.CORRECT_FB,doCorrectFB);
			addEventListener(Shape_Game.INCORRECT_FB,doIncorrectFB);
			addEventListener(Shape_Game.GAME_NEWQ,doNewQ);
			addEventListener(Shape_Game.GAME1_NEW,doNewGame);
			addEventListener(Shape_Game.GAME_OVER,doGame1_Over);
			addEventListener(Shape_Game.FADE_SOUND,doFadeSound);
		}
		
		private function doHelp(event:MouseEvent):void{
			game1.help.gotoAndPlay("see");
			hb1.disableBtn();
			addEventListener(Close_Btn.CLOSE_HELP,closeHelp);
		}
		
		private function closeHelp(e:Event):void{
			hb1.enableBtn();
			removeEventListener(Close_Btn.CLOSE_HELP,closeHelp);
			game1.help.gotoAndPlay("bye");
		}
		
		private function doCorrectFB(e:Event):void{
			mouth.doCorrect();
		}
		
		private function doIncorrectFB(e:Event):void{
			//addEventListener(TalkClip.TALK_DONE,doEnableShapes)
			mouth.doIncorrect();
		}
		
		private function doEnableShapes(e:Event):void{
			//removeEventListener(TalkClip.TALK_DONE,doEnableShapes)
			//game1.panel.shapeGame.enableShapes();
		}
		
		private function doNewQ(e:Event):void{
			mouth.goIdle();
		}
		
		private function doNewGame(e:Event):void{
			mouth.resetFB();
		}
		
		private function doGame1_Over(e:Event):void{
			channel.stop();
			addChild(endGame2_Snd);
			removeEventListener(Shape_Game.CORRECT_FB,doCorrectFB);
			removeEventListener(Shape_Game.INCORRECT_FB,doIncorrectFB);
			removeEventListener(Shape_Game.GAME_NEWQ,doNewQ);
			removeEventListener(Shape_Game.GAME_OVER,doGame1_Over);
			removeEventListener(Close_Btn.CLOSE_HELP,closeHelp);
			trees.gotoAndPlay("bye");
			flowers.gotoAndPlay("bye");
			printer = new Printer();
			bird1 = new Bird1();
			addEventListener(Bird1.CHANGE_GAME,startGame2);
			content_mc.addChild(bird1);
		}
		
		private function startGame2(e:Event):void{
			game1.visible = false;
			hb1.disableBtn();
			hb2 = new AnimatedBtn(helpbtn,doHelp2);
			hb2.visible = true;
			game2 = new Coloring_Game();
			game2.x = -243;
			game2.y = -74;
			helpShowing = false;
			help2 = new Help2_MC();
			help2.x = 107;
			help2.y = 100;
			content_mc.addChild(help2);
			content_mc.addChildAt(game2,2);
			showGameBtns();
			channel2.stop();
			channel2 = creative.play();
			addEventListener(Print_Btn.PRINT,doPrint);
			if(!soundPlaying){
				var sAmbienceVol:SoundTransform = new SoundTransform(1, 0);
				channel = game2_music.play(0,1000);
				channel.soundTransform = sAmbienceVol;
				soundPlaying = true;
			}
		}
		
		private function showGameBtns():void
		{
			g2_Btns = new Game2_btns();
			g2_Btns.x = 270;
			g2_Btns.y = 212;
			content_mc.addChild(g2_Btns);
			g2_Btns.gotoAndPlay("f1");
			addEventListener(Done_Btn.DONE_PAINTING,doDone);
		}
		
		private function doHelp2(event:MouseEvent):void{
			hb2.disableBtn();
			help2.gotoAndPlay("see");
			helpShowing = true;
			addEventListener(Close_Btn.CLOSE_HELP,closeHelp2);
		}
		
		private function closeHelp2(e:Event):void{
			removeEventListener(Close_Btn.CLOSE_HELP,closeHelp2);
			helpShowing = false;
			hb2.enableBtn();
			help2.gotoAndPlay("bye");
		}
		
		private function doDone(e:Event):void{
			if(helpShowing) closeHelp2(null);
			TweenLite.to(helpbtn, .5, { x:773} );
			removeEventListener(Done_Btn.DONE_PAINTING,doDone);
			addEventListener(ColorAgain_Btn.COLOR_AGAIN,doColorAgain);
			addEventListener(PlayAgain_Btn.PLAY_AGAIN,doPlayAgain);
			game2.dropPaintbrush();
			channel.stop();
			channel3 = end_song.play(0,1000);
			channel2.stop();
			endGame2_Snd.play();
			g2_Btns.gotoAndPlay("byef");
		}
		
		private function doPlayAgain(e:Event):void{
			SoundMixer.stopAll();
			TweenLite.to(helpbtn, .5, { x:663} );
			removeEventListener(PlayAgain_Btn.PLAY_AGAIN,doColorAgain);
			game_old = new Coloring_Game();
			game_old = game2;
			content_mc.removeChild(g2_Btns);
			bird1.gotoAndPlay(1);
			endGame2_Snd.gotoAndStop(1);
			removeEventListener(Bird1.CHANGE_GAME,startGame2);
			addEventListener(Bird1.CHANGE_GAME,startGame1_again);
			addEventListener(Bird1.CHANGE_GAME,removeGame2);
		}
		
		private function doColorAgain(e:Event):void{
			TweenLite.to(helpbtn, .5, { x:663} );
			removeEventListener(ColorAgain_Btn.COLOR_AGAIN,doColorAgain);
			game_old = new Coloring_Game();
			game_old = game2;
			content_mc.removeChild(g2_Btns);
			bird1.gotoAndPlay(1);
			SoundMixer.stopAll();
			endGame2_Snd.gotoAndStop(1);
			channel = game2_music.play(0,1000);
			addEventListener(Bird1.CHANGE_GAME,removeGame2);
		}
		
		private function removeGame2(e:Event):void{
			removeEventListener(Bird1.CHANGE_GAME,removeGame2);
			content_mc.removeChild(game_old);
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
		}
		
		private function soundFadeIn(e:TimerEvent){     
			fadeInIncr += 1/30;         
			var sAmbienceVol:SoundTransform = new SoundTransform(fadeInIncr, 0);         
			channel.soundTransform = sAmbienceVol; 
		}
		
		private function masterFadeIn(e:TimerEvent){     
			masterInIncr += 1/30;         
			SoundMixer.soundTransform = new SoundTransform(masterInIncr);
		}
		
		private function masterFadeOut(e:TimerEvent){     
			masterInIncr -= 1/15;          
			SoundMixer.soundTransform = new SoundTransform(masterInIncr);
		}
		
		private function doPrint(e:Event):void{
			soundbtn.visible = false;
			flowers.logo.visible = false;
			nowPrinting.visible = true;
			nowPrinting.x = 350;
			nowPrinting.y = 225;
			addEventListener(Printer.PRINT_DONE,doDonePrint);
			g2_Btns.visible = false;
			addChild(printer);
			printer.printJob(content_mc);
		}
		
		private function doDonePrint(e:Event){
			removeEventListener(Printer.PRINT_DONE,doDonePrint);
			if(e.target.orient == "p") 
			{	
				content_mc.rotation = 0;
				content_mc.x -=450;
			}
			nowPrinting.visible = false;
			soundbtn.visible = true;
			g2_Btns.visible = true;
			flowers.logo.visible = true;
			content_mc.scaleX = 1;
			content_mc.scaleY = 1;
		}
		
	}
}