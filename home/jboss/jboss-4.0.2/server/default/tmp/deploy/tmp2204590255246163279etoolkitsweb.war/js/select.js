function addSelectValue(sourceField, targetField) 
{	
	if (sourceField.options.length > 0) 
	{
		for(var i = 0; i < sourceField.options.length; i++) 
		{
			if(sourceField.options(i).selected) 
			{
			     put = 0;
                 if (targetField.options.length > 0)
                 {
	             	for (j = 0; j < targetField.options.length; j++)
	                {                                
	                	if (targetField.options(j).value == sourceField(i).value)
                        {
                       		put = 1;
                       		break;
                      	}
	                }
                 }
                 
                 if (put == 0)
                 {     
                 	//alert();             	            	
				 	//targetField.options[targetField.options.length] = new Option(sourceField.options(i).text, sourceField.options(i).value)
				 	for(k=targetField.options.length;k>0;k--)
				 		targetField.options[k] = new Option(targetField.options(k-1).text, targetField.options(k-1).value)				 		
				 	
				 	targetField.options[0] = new Option(sourceField.options(i).text, sourceField.options(i).value)
				 }
			}
		}
	}
}


function delSelectValue(sourceField) 
{
	if (sourceField.options.length > 0) 
	{		
		for(var i = sourceField.options.length - 1; i > -1; i--) 
		{
			if(sourceField.options(i).selected) 
			{				
		    	sourceField.options[i] = null
			}
		}
	}	
}

function selectAll(sourceField) 
{
	for(var i = 0; i < sourceField.options.length; i++) 
			sourceField.options(i).selected = true;	
}

function clearAll(sourceField)
{
	for(var i = sourceField.options.length - 1; i > -1; i--) 
		sourceField.options[i] = null
}

 	//??/??
function cmd_AllSel(objform)
{
		for (i=0; i< objform.elements.length; i++){
			if (objform.elements[i].type == "checkbox"){ 
				if(objform.elements[i].checked == true){
					objform.elements[i].checked = false;
				}
				else{
					objform.elements[i].checked = true;
				}
			}
		}
	}
	
	function cmd_Del(cb)
	{
		var strcheck;
		strcheck=0;	
		if(cb == null)
		{
			alert("对不起!您没有可以删除的记录。");	
			return false;
		}
		if(cb.length)
		{
			for (i=0; i<cb.length; i++)
			{
				if (cb[i].checked){ 
					strcheck = 1;
					break;
				}	
			}
		}
		else
		{
			if (cb.checked)
				strcheck = 1;
		}
		
		if (strcheck == 0)
		{
			alert("请您选择要删除的内容!");
			return false;
		}	
		return true;	
	}
	//返回当前被选中的单选按钮的值
  function getSelectedValue(cb)
	{
	 var strcheck;
		if(cb == null)
		{
			return null;
		}
		if(cb.length)
		{
			for (i=0; i<cb.length; i++)
			{
				if (cb[i].checked){ 
					strcheck = cb[i].value;
					break;
				}	
			}
		}
		else
		{
			if (cb.checked)
				strcheck = cb.value;
		}
		
	
		return strcheck;
  }
	
	
	function cmd_Print(cb)
	{
		var strcheck;
		strcheck=0;	
		if(cb == null)
		{
			alert("对不起!您没有可以打印的记录。");	
			return false;
		}
		if(cb.length)
		{
			for (i=0; i<cb.length; i++)
			{
				if (cb[i].checked){ 
					strcheck = 1;
					break;
				}	
			}
		}
		else
		{
			if (cb.checked)
				strcheck = 1;
		}
		
		if (strcheck == 0)
		{
			alert("请您选择要打印的内容!");
			return false;
		}	
		return true;	
	}
	
	
	function cmd_select(cb)
	{
		var strcheck;
		strcheck=0;	
		if(cb == null)
		{
	//		alert("对不起!您没有可以打印的记录。");	
			return false;
		}
		if(cb.length)
		{
			for (i=0; i<cb.length; i++)
			{
				if (cb[i].checked){ 
					strcheck = 1;
					break;
				}	
			}
		}
		else
		{
			if (cb.checked)
				strcheck = 1;
		}
		
		if (strcheck == 0)
		{
//			alert("请您选择要打印的内容!");
			return false;
		}	
		return true;	
	}
