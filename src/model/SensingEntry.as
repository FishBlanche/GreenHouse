package model
{
	[Bindable]
	 
	public class SensingEntry{
		 
		public var Moteid_ID:int = 0;	
		public var Area:int = 0;
		public var sensingType:String="";
		public var temperature:Number = 0.0;
		public var humidity:Number = 0.0;
		public var light:Number = 0.0;
		
		public var CO2:Number = 0.0;	
		public var nodeType:String="";
	 
		public var A0:Number = 0.0;
		public var A1:Number = 0.0;
		public function SensingEntry()
		{
		
			Moteid_ID = 0;
		    temperature= 0.0;
			humidity = 0.0;
			light = 0.0;	
		    CO2 = 0.0;
			nodeType="";
		}
	}


}