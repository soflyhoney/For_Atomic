//Written by Rebecca A. Krug
package com.barbie.thumbelina.game2{
	/** Document class for Barbie Thumbelina Feb. 2009
	maybe not use this
	*/
	import flash.display.*;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import com.gs.TweenLite;
	import com.util.*;
	import flash.geom.ColorTransform;

	public class Coloring_Game extends MovieClip {
		
		private var colorTip:ColorTransform;
		private var colorDrop:ColorTransform;
		private var currentColor:*;
		public static const GAME_OVER:String = "GAME_OVER";
		
		public function Coloring_Game() {
			trace("hello Coloring_Game");
			init();
		}
		
		private function init():void{
			thumb_fly.stop();
			thumb_fly.girl.stop();
			thumb_fly.trees.stop();
			this.addEventListener(MouseEvent.MOUSE_MOVE,pickupBrush);
			this.addEventListener(MouseEvent.ROLL_OUT,showMouse);
			this.addEventListener(MouseEvent.ROLL_OVER,hideMouse);
			Mouse.hide();
			currentColor = "0xC35091";
			palette.mouseChildren = true;
			//var mcc:MovieClip = palette.color1;
			var color1:Color_Paint = new Color_Paint(palette.color1,"0xF4A256");
			var color2:Color_Paint = new Color_Paint(palette.color2,"0xE1468A");
			var color3:Color_Paint = new Color_Paint(palette.color3,"0xE9B1CC");
			var color4:Color_Paint = new Color_Paint(palette.color4,"0xB7D88F");
			var color5:Color_Paint = new Color_Paint(palette.color5,"0x79CCD6");
			var color6:Color_Paint = new Color_Paint(palette.color6,"0x5F5F5F");
			var color7:Color_Paint = new Color_Paint(palette.color7,"0xD8A085");
			var color8:Color_Paint = new Color_Paint(palette.color8,"0xC58F61");
			var color9:Color_Paint = new Color_Paint(palette.color9,"0xF8F189");
			var color10:Color_Paint = new Color_Paint(palette.color10,"0xD7DD57");
			var color11:Color_Paint = new Color_Paint(palette.color11,"0xA3CC7D");
			var color12:Color_Paint = new Color_Paint(palette.color12,"0xA982B1");
			var color13:Color_Paint = new Color_Paint(palette.color13,"0xEEB28E");
			var color14:Color_Paint = new Color_Paint(palette.color14,"0x9DD6DD");
			var color15:Color_Paint = new Color_Paint(palette.color15,"0xE24B2C");
			var color16:Color_Paint = new Color_Paint(palette.color16,"0xC35091");
			addChild(color1);
			addChild(color2);
			addChild(color3);
			addChild(color4);
			addChild(color5);
			addChild(color6);
			addChild(color7);
			addChild(color8);
			addChild(color9);
			addChild(color10);
			addChild(color11);
			addChild(color12);
			addChild(color13);
			addChild(color14);
			addChild(color15);
			addChild(color16);
			addEventListener(Color_Paint.OVER_COLOR,doOverColor);
			addEventListener(Color_Paint.OUT_COLOR,doOutColor);
			addEventListener(Color_Paint.SELECT_COLOR,doSelectColor);
			addEventListener(ColoringMovieClip.COLOR_ME, doColorIt);
			colorTip = paintbrush.pb_tip.transform.colorTransform;
			colorDrop = paintbrush.pb_drop.transform.colorTransform;
		}

		private function pickupBrush(event:MouseEvent):void
		{
			//palette.visible = true;
			TweenLite.to(palette, .3, { alpha:1} );
			paintbrush.x = mouseX;
			paintbrush.y = mouseY;
		}
		
		public function dropPaintbrush():void{
			paintbrush.visible = false;
			TweenLite.to(palette, .3, { alpha:0} );
			thumb_fly.play();
			thumb_fly.girl.play();
			thumb_fly.trees.play();
			this.removeEventListener(MouseEvent.MOUSE_MOVE,pickupBrush);
			this.removeEventListener(MouseEvent.ROLL_OUT,showMouse);
			this.removeEventListener(MouseEvent.ROLL_OVER,hideMouse);
			Mouse.show();
			removeEventListener(Color_Paint.OVER_COLOR,doOverColor);
			removeEventListener(Color_Paint.OUT_COLOR,doOutColor);
			removeEventListener(Color_Paint.SELECT_COLOR,doSelectColor);
			removeEventListener(ColoringMovieClip.COLOR_ME, doColorIt);
		}
		
		private function doOverColor(e:Event):void{
			colorTip.color = e.target.thisColor;
			colorDrop.color = e.target.thisColor;
			// apply the change to the display object
			paintbrush.pb_tip.transform.colorTransform = colorTip;
			paintbrush.pb_drop.transform.colorTransform = colorDrop;
		}
		
		private function doOutColor(e:Event):void{
			//return to current color
			colorTip.color = currentColor;
			colorDrop.color = currentColor;
			// apply the change to the display object
			paintbrush.pb_tip.transform.colorTransform = colorTip;
			paintbrush.pb_drop.transform.colorTransform = colorDrop;
		}
		
		private function doSelectColor(e:Event):void{
			currentColor = e.target.thisColor;
		}
		
		private function doColorIt(e:Event):void{
			e.target.setColor(currentColor);
		}
		
		private function showMouse(event:MouseEvent):void{
			Mouse.show();
		}
		
		private function hideMouse(event:MouseEvent):void{
			Mouse.hide();
		}
		
		public function stopAnimation():void{
			thumb_fly.stop();
			thumb_fly.girl.stop();
			thumb_fly.trees.stop();
		}

	}
}