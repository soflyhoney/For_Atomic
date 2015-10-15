//Written by Rebecca A. Krug
package com.barbie.thumbelina.game2{
	/** Document class for Barbie Thumbelina Feb. 2009
	maybe not use this
	*/
	import flash.display.MovieClip;
	import flash.printing.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	
	public class Printer extends MovieClip {
		
		private var _orient:String;
		public static const PRINT_DONE:String = "PRINT_DONE";
		
		public function get orient():String{
			return _orient;
		}
		public function Printer() {		}
		
		public function printJob(_printmc:MovieClip) {
			// Call the _print instance as part of the PrintJob class
			var _print:PrintJob = new PrintJob();
			
			var pLogos = new Print_logos();
			pLogos.x = 25;
			pLogos.y = 170;
			_printmc.addChild(pLogos);
			// Starts the OS's printing process by opening the printer
			// dialogue, adding the read-only properties,
			// and prepares the page to be sent to the spooler
			_print.start();
			if (_print.orientation == PrintJobOrientation.PORTRAIT)
				{
					_orient = "p";
					_printmc.rotation = 90;
					_printmc.x = 450 ;
					_printmc.y = 0;
					var printOption:PrintJobOptions = new PrintJobOptions();
					var rect1:Rectangle = new Rectangle(0, 0, 699, 449);

					printOption.printAsBitmap = true;
					_print.addPage(_printmc, rect1, printOption);
				}
			else {
				_orient = "l";
				var printOption:PrintJobOptions = new PrintJobOptions();
				var rect2:Rectangle = new Rectangle(0, 0, 699, 449);
	
				printOption.printAsBitmap = true;
				_print.addPage(_printmc, rect2, printOption);
			}
		
			// send finishes the print job and send the page
			// to the print spooler.
			_print.send();
			//delete _print;
			dispatchEvent(new Event(PRINT_DONE, true));
			_printmc.removeChild(pLogos);
}
		
	}
}