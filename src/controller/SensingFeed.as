/** 
 * Christophe Coenraets, http://coenraets.org
 */
package controller
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.events.PropertyChangeEvent;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.utils.StringUtil;
	
	import spark.managers.PersistenceManager;
	
	import components.DataPump;
	import components.DataPumpHelper;
	
	import model.SensingEntry;

	public class SensingFeed extends EventDispatcher
	{
		protected var index:int = 0;
		
		protected var updateOrder:Array = [6,4,1,7,0,3,2,5]; // used to simulated randomness of updates
		
		protected var timer:Timer;
		
		protected var senseMap:Dictionary;	
	
		
		private  var datapump:DataPumpHelper  = new DataPumpHelper();
		private  var datap:DataPump = datapump.getDataPump();
		
		private var myAMF:AMFChannel=new AMFChannel();
		private var channelSet:ChannelSet=new ChannelSet();
		private var ro:RemoteObject = new RemoteObject();
		
		public function SensingFeed()
		{
		//	trace("SensingFeed()");
		 
		    datap.addEventListener("_newSensingData",newData);
			
	 
		}
		
		public function refresh():void{
			ro.getNewestSensings();	
		}
		
		private function property_change(event:Event):void{
			trace("ds property changed `````");
		}
	
	
		private function newData(event:Event):void{
		
			var sense:SensingEntry  = datapump.getDataPump().newestSensing;
			
			var stockCount:int = FlexGlobals.topLevelApplication.newestSensingList.length;
			for (var k:int = 0; k < stockCount; k++)
			{
				 if(FlexGlobals.topLevelApplication.newestSensingList.getItemAt(k).Moteid_ID == sense.Moteid_ID){
					 FlexGlobals.topLevelApplication.newestSensingList.getItemAt(k).temperature=sense.temperature;
					 FlexGlobals.topLevelApplication.newestSensingList.getItemAt(k).humidity=sense.humidity;
					 FlexGlobals.topLevelApplication.newestSensingList.getItemAt(k).light=sense.light;	
					 FlexGlobals.topLevelApplication.newestSensingList.getItemAt(k).CO2=sense.CO2;
					 FlexGlobals.topLevelApplication.newestSensingList.getItemAt(k).A0=sense.A0;
					 FlexGlobals.topLevelApplication.newestSensingList.getItemAt(k).A1=sense.A1;
					 FlexGlobals.topLevelApplication.newestSensingList.itemUpdated(FlexGlobals.topLevelApplication.newestSensingList.getItemAt(k));
					break;
				}
				}
			}
		trace("newData(event:Event)");
}
}