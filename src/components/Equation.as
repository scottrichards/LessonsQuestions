package components
{
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	import spark.components.Label;
	import spark.components.TextInput;
	import spark.primitives.Rect;
	
	import model.EquationData;
	
	public class Equation extends UIComponent
	{
		private static const COMPONENT_HEIGHT:uint = 40;
		private static const TOP_PADDING:uint = 15;
		private static const WIDTH_H_PADDING:uint = 40;
		private static const INPUT_FIELD_WIDTH :uint = 60;
		private static const INPUT_FIELD_HEIGHT :uint = 35;
		private static const INPUT_FIELD_H_PADDING :uint = 5;
		private static const INPUT_FIELD_V_PADDING :uint = 5;

		private var _data:ArrayCollection;
		private var _numTextLabels:uint;
		private var _numAnswers:uint;

		
		private var labelChanged:Boolean = false;
		
		public function Equation()
		{
			super();
		}
		
		// -----------------
		// public methods
		// -----------------
		
		
		// From the question node it finds questionContent and traverses all subnodes looking for <answer> tags
		public function addXMLData(question:XML):void
		{
			_data = new ArrayCollection();
			
			var questionContentList : XMLList = question.questionContent;
			var numItems:uint = questionContentList.length();
			if (numItems > 0) {
				var questionContentNode : XML = questionContentList[0];
				var childrenList : XMLList = questionContentNode.children();
				for each (var childNode:XML in childrenList) {
					var tag:String = "text";
					var type:String="";
					var value:String ="";
					var nodeKind : String = childNode.nodeKind(); 
					if (nodeKind == "text") {
						value = childNode.toString();
					} else if (nodeKind == "element") {
						var localName :String = childNode.name().localName;
						if (localName == "answer") {
							tag = "answer";
							value = childNode.toString();
						}
					} 
					var eqData:EquationData = new EquationData(tag,value);
					_data.addItem(eqData);
				}
			}
		}
		
		// -----------------
		// overrides
		// -----------------
		
		override protected function createChildren():void
		{
			super.createChildren();

			
			for each(var item:Object in _data)
			{
				if (item.tag == "text") {
					var textLabel:Label = new Label();
					textLabel.text = item.value;
					textLabel.name = "textLabel" + _numTextLabels.toString();
					_numTextLabels++;
					addChild(textLabel);
				}
				if (item.tag == "answer") {
/*					var uic:UIComponent = new UIComponent();
					uic.name="answer" + _numAnswers.toString();
					uic.width = 80;
					uic.height = COMPONENT_HEIGHT;
					uic.graphics.lineStyle(1,0xcccccc); 
					addChild(uic);*/
					_numAnswers++;
					var inputField:TextInput = new TextInput();
					inputField.width = INPUT_FIELD_WIDTH;
					inputField.name = "answer" + _numAnswers.toString();
					inputField.height = INPUT_FIELD_HEIGHT;
					addChild(inputField);
				}
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (labelChanged) {
				labelChanged = false;
			}
		}
		
		override protected function measure():void
		{
			super.measure();
			measuredHeight = COMPONENT_HEIGHT;
			measuredMinHeight = COMPONENT_HEIGHT;
			measuredWidth = measuredMinWidth = 0;
			var textLabelCount:uint;
			var answerCount:uint;
			for each(var item:Object in _data) 
			{
				if (item.tag == "text") {
					var label:Label = this.getChildByName("textLabel" + textLabelCount.toString()) as Label;
					textLabelCount++;
					measuredWidth += label.getExplicitOrMeasuredWidth();
					measuredMinWidth += label.getExplicitOrMeasuredWidth();
				}
				if (item.tag == "answer") {
					var uic:UIComponent= this.getChildByName("answer" + answerCount.toString()) as UIComponent;
					answerCount++;
					measuredWidth += INPUT_FIELD_WIDTH;
					measuredMinWidth += INPUT_FIELD_WIDTH;
					//				trace("label named: " + label.name);
					//				trace("label.text: " + label.text);
					//				measuredWidth += label.getExplicitOrMeasuredWidth();
					//				measuredMinWidth += label.getExplicitOrMeasuredWidth();
					//				trace("measuredWidth: " + measuredWidth);
				}
			}
//			for (var i:uint=0;i<_numTextLabels;i++)
//			{
//				var label:Label = this.getChildByName("textLabel" + i.toString()) as Label;
//				trace("label named: " + label.name);
//				trace("label.text: " + label.text);
//				measuredWidth += label.getExplicitOrMeasuredWidth();
//				measuredMinWidth += label.getExplicitOrMeasuredWidth();
//				trace("measuredWidth: " + measuredWidth);
//			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number,
													  unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			trace("unscaledWidth: " + unscaledWidth + " unscaledHeight: " + unscaledHeight);
			var currentWidth:Number = 0;
			var labelWidth:Number;
			var textLabelCount:uint;
			for each(var item:Object in _data) 
			{
				if (item.tag == "text") {
					var label:Label = this.getChildByName("textLabel" + textLabelCount.toString()) as Label;
					textLabelCount++;
					trace("label named: " + label.name);
					trace("label.text: " + label.text);
					label.move( currentWidth, TOP_PADDING);
					labelWidth = label.getExplicitOrMeasuredWidth();
					trace("label.getExplicitOrMeasuredWidth(): " + labelWidth);
					currentWidth += label.getExplicitOrMeasuredWidth();
					label.setActualSize(labelWidth,COMPONENT_HEIGHT);
					trace("current width: " + currentWidth);
				}
				if (item.tag == "answer") {
					var input:TextInput = this.getChildByName("answer" + textLabelCount.toString()) as TextInput;
					if (input != null) {
						trace("answer named: " + input.name);
						input.move( currentWidth + INPUT_FIELD_H_PADDING, INPUT_FIELD_V_PADDING);
						var inputWidth:Number = label.getExplicitOrMeasuredWidth();
						input.setActualSize(INPUT_FIELD_WIDTH, INPUT_FIELD_HEIGHT);
						currentWidth += INPUT_FIELD_WIDTH + (INPUT_FIELD_H_PADDING * 2);
					}
				}
			}
			
//			for (var i:uint=0;i<_numTextLabels;i++)
//			{
//				var label:Label = this.getChildByName("textLabel" + i.toString()) as Label;
//				trace("label named: " + label.name);
//				trace("label.text: " + label.text);
//				label.move( currentWidth, TOP_PADDING);
//				labelWidth = label.getExplicitOrMeasuredWidth();
//				trace("label.getExplicitOrMeasuredWidth(): " + labelWidth);
//				currentWidth += label.getExplicitOrMeasuredWidth();
//				label.setActualSize(labelWidth,COMPONENT_HEIGHT);
//				trace("current width: " + currentWidth);
//			}
			
		}
		
		
		public function set data(value:ArrayCollection):void
		{
			_data = value;
			invalidateProperties();
			invalidateSize();
		}
	}
}