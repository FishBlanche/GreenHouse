package components
{
	import mx.charts.LegendItem;
	
	public class BigFontLegendItem extends LegendItem
	{
		public function BigFontLegendItem()
		{
			super();
			this.styleName = "BigFont";  
		}
		
		override public function set legendData(value:Object):void
		{
			// TODO Auto Generated method stub
			super.legendData = value;
		}
		
	}
}