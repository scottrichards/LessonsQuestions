package model
{
	public class EquationData extends Object
	{
		public var tag : String;
		public var value : String;
		public var type : String;	// for answers indicates the type of the result e.g. numeric
		
		public function EquationData(tag:String,value:String)
		{
			super();
			this.tag = tag;
			this.value = value;
		}
	}
}