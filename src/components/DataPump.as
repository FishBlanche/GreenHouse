package components
{	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.messaging.ChannelSet;
	import mx.messaging.Consumer;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.StringUtil;
	
	import spark.managers.PersistenceManager;
	
	import model.SensingEntry;
 

	public class DataPump  extends EventDispatcher
	{
		public var isConnected:Boolean = false;
		public  var newestSensing:SensingEntry = new SensingEntry();
		public var consumer:Consumer=new Consumer;  
		 
        private var myAMF:AMFChannel=new AMFChannel;
		private var channelSet:ChannelSet=new ChannelSet;
		private var subscribetimes:int=0;
		public function DataPump()
		{		
			trace("DataPump()");
			var persistencemanager:PersistenceManager=new PersistenceManager();
			if(persistencemanager.load())
			{
				if(persistencemanager.getProperty("serverAddress"))
				{
					myAMF.url=persistencemanager.getProperty("serverAddress").toString();
					channelSet.addChannel(myAMF); 
					consumer.destination="newSensing";  
					consumer.subtopic="LiveSense";  
					consumer.channelSet=channelSet;  
					consumer.addEventListener(MessageEvent.MESSAGE, messageHandler);  
					consumer.addEventListener(ChannelFaultEvent.FAULT,fault);  
					consumer.addEventListener(ChannelEvent.CONNECT,connected); 
					consumer.addEventListener(MessageFaultEvent.FAULT,fault2);  
					consumer.subscribe();
					 
					FlexGlobals.topLevelApplication.GlobalBusy=false;
				}
				else
				{
					FlexGlobals.topLevelApplication.GlobalBusy=true;
				}
			}
             
		  
		}
		private function InfoTip(event:Event):void
		{
			
		}
		public function getConsumer():Consumer
		{
			return consumer;
		}
		private function refresh():void
		{
			consumer.subscribe();
		}
		private function messageHandler(event:MessageEvent):void  
		{  
			var entyArray:String =  StringUtil.trim(event.message.body.toString());
		    var a:Array = entyArray.split(",");
			//trace(entyArray);
			 
			newestSensing.Moteid_ID=parseInt(a[0]);;
			newestSensing.temperature=parseFloat(a[5]);
			newestSensing.humidity=parseFloat(a[4]);
			newestSensing.light=parseFloat(a[6]);
			newestSensing.CO2=parseFloat(a[8]);
			newestSensing.A0=parseFloat(a[9]);
			newestSensing.A1=parseFloat(a[10]);
			newestSensing.nodeType=a[11];
			
			 dispatchEvent(new Event("_newSensingData"));
		}  
		 
		
        private function connected(e:ChannelEvent):void  
		{		
		 	trace("---connected----");
		}  
		private function fault(e:ChannelFaultEvent):void  
		{  
			trace("---channel fault----");
			
			var timer:Timer = new Timer(5000,1);
			timer.addEventListener(TimerEvent.TIMER,timer_Handler);
			timer.start();
		}  
		protected function timer_Handler(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			consumer.subscribe();
		}
		
		private function fault2(e:MessageFaultEvent):void  
		{  
			trace("---message fault----");
		 
			
		    var timer:Timer = new Timer(5000,1);
			timer.addEventListener(TimerEvent.TIMER,timer_Handler);
			timer.start();
	    	//consumer.subscribe();
		}  
}  
}	
	
