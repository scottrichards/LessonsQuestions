package components
{
	import spark.components.Button;
	
	public class BIPButton extends Button
	{
		public function BIPButton()
		{
			super();
			label = "BIP Button";
			setStyle("fillColors", ['red', 'blue']);
			toolTip="A BIP Button";
		}
	}
}