
package com.barbie.thumbelina.game2{
	/** Document class for Barbie Thumbelina Feb. 2009
	maybe not use this
	*/
	import flash.display.*;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import com.barbie.thumbelina.util.*;
	import flash.net.navigateToURL;
    import flash.net.URLRequest;
	//import com.gs.TweenLite;
	
	public class Toy_Btn extends MovieClip {
		
		//public static const DONE_PAINTING:String = "DONE_PAINTING";
		private var cb:AnimatedBtn;
		
		public function Toy_Btn() {
			init();
		}
		
		private function init():void{
			cb = new AnimatedBtn(this,doToys);
			addChild(cb);
		}
		
		private function doToys(event:MouseEvent):void{
			trace("doToys: doToys");
			//dispatchEvent(new Event(DONE_PAINTING,true));
			var request:URLRequest = new URLRequest("http://barbie.everythinggirl.com/catalog/catalogbrd.aspx?cat_id=200003");
            try {            
                navigateToURL(request,"_blank");
            }
            catch (e:Error) {
                // handle error here
            }
		}
		
		
		
	}
}