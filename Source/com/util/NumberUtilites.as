package com.util {
	
	public class NumberUtilites {
		public function NumberUtilites(){
			trace("hello NU!")
		}
		public static function randomNumber(min:Number, max:Number):Number {
			var n:Number = (Math.random()*(max-min))+min;
			return n;
		}
		public static function randomInteger(min:Number, max:Number):int {
			var n:int = (Math.random()*(max-min))+min;
			return Math.ceil(n);
		}
		
		public function randomUniqueIntArray(min:int, max:int, arrayLength:int):Array {
			var count:int = arrayLength;
			var number_array:Array = new Array();
			while (count > 0){
				var newRandom:int = NumberUtilites.randomNumber(min, max);
				var used:Boolean = false;
				for(var i:int=0; i<number_array.length; i++){
					if(newRandom == number_array[i]){
						used = true;
						break;
					} 
				}
				if(used == false){
					number_array.push(newRandom);
					count --;
				} 
			}
			return number_array;
		}
		
		public function customUniqueIntArray(min:int, max:int, arrayLength:int, _exArray:Array):Array {
			var count:int = arrayLength;
			var number_array:Array = new Array();
			while (count > 0){
				var newRandom:int = NumberUtilites.randomNumber(min, max);
				var used:Boolean = false;
				var index:int = _exArray.indexOf(newRandom);
				if(index >= 0){
					used = true;
				}
				for(var i:int=0; i<number_array.length; i++){
					if(newRandom == number_array[i]){
						used = true;
						break;
					} 
				}
				if(used == false){
					number_array.push(newRandom);
					count --;
				} 
			}
			return number_array;
		}
	}
}