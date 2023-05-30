function trim(sInputString)
{
   var sTmpStr = ' ';
   var i = -1;
   while(sTmpStr == ' ')
   {
      ++i;
      sTmpStr = sInputString.substr(i,1);
   }
   sInputString = sInputString.substring(i);
   sTmpStr = ' ';
   i = sInputString.length;
   while(sTmpStr == ' ')
   {
      --i;
      sTmpStr = sInputString.substr(i,1);
   }
   sInputString = sInputString.substring(0,i+1);
   return sInputString
} 
/*
函数说明：删除掉SELECT标签中的所有元素。
*/
////////////////////////////////////////


var ESel = function(){
};
ESel.key = new Array();
ESel.value = new Array();
ESel.text = new Array();
ESel.element = null;
ESel.span = null;

ESel.add = function(key, value, text){
	this.key.push(key);
	this.value.push(value);
	this.text.push(text);
}
ESel.size = function(){
	return this.key.length;
}

ESel.setElement = function(element, span){
	this.element = element;
	this.span = span;
}
ESel.removeAll = function(){
	while (this.element.length > 0){
		this.element.remove(0);
	}
}
/*
当选择任一值时。
*/
ESel.set = function(key, selValue){
	this.removeAll();
	var oOption = null;
	var j = 0;
	for (i = 0; i < this.key.length; i++){
		if (this.key[i] == key)
		{
			oOption = document.createElement("OPTION");
			oOption.text = this.text[i];
			oOption.value = this.value[i];
			if (j == 0 || oOption.value == selValue){
				oOption.selected = true;
			}
			else{
				oOption.selected = false;
			}
			this.element.add(oOption);
			j++;
		}
	}
}

ESel.showSpan = function(selValue){
	if (this.span == null){
		return;
	}
	this.span.innerHTML = selValue;
}

///////////////////////////////////////////
ESelect = function(){
};
ESelect.prototype.key = new Array();
ESelect.prototype.value = new Array();
ESelect.prototype.text = new Array();
ESelect.prototype.element = null;
ESelect.prototype.span = null;
/*
key -- first selection ID;
value -- second selection ID;
text  -- second selection text.
*/
ESelect.prototype.add = function(key, value, text){
	this.key.push(key);
	this.value.push(value);
	this.text.push(text);
}
ESelect.prototype.size = function(){
	return this.key.length;
}

ESelect.prototype.setElement = function(element, span){
	this.element = element;
	this.span = span;
}
ESelect.prototype.removeAll = function(){
	while (this.element.length > 0){
		this.element.remove(0);
	}
}

ESelect.prototype.set = function(key, selValue){
	this.removeAll();
	var oOption = null;
	var j = 0;
	for (i = 0; i < this.key.length; i++){
		if (this.key[i] == key)
		{
			oOption = document.createElement("OPTION");
			oOption.text = this.text[i];
			oOption.value = this.value[i];
			if (j == 0 || oOption.value == selValue){
				oOption.selected = true;
			}
			else{
				oOption.selected = false;
			}
			this.element.add(oOption);
			j++;
		}
	}
}

ESelect.prototype.showSpan = function(selValue){
	if (this.span == null){
		return;
	}
	this.span.innerHTML = selValue;
}

///////////////////////////////////////////
/*
  函数说明：判断输入是否正确。本方法仅实现通用功能。
  参数说明：obj - 指定判断的对象！
            keyword - 对应的关键字名称
            isNum - 是否按照数字来判断。
*/
function validate(obj, keyword, isNum)
{
   if (obj == null)
   {
      alert("指定的对象不存在！");
      return false;
   }
   obj.value = trim(obj.value);
   if (obj.value == "")
   {
      alert("[" + keyword + "]不能为空！");
      if (obj.select != null)
      {
         obj.select();
      }
      obj.focus();
      return false;
   }
   if (isNum)
   {
      if (isNaN(obj.value))
      {
         alert("[" + keyword + "]必须为数字！");
         obj.select();
         obj.focus();
         return false;
      }
   }
   return true;
}



function isAlpha(val)
{
var ch;
var str1 = "~`!@#$%^&*()+-=[]{}:;'\\|<>?,./";
if (val.indexOf("\"")!=-1)
	{return false;}
else
  {
	for(i=0;i<str1.length;i++)
		{
		ch=str1.substring(i,i+1);	
		if (val.indexOf(ch)!=-1)
		  {return false;}
		}
   }
return true;
}

function isNum(num)
{
  var numstr="0123456789";
  if (num.length == 0)
  {
     return false;
  }
  for(i=0; i < num.length; i++)
  {
     numcom=num.substring(i,i+1);
     if(numstr.indexOf(parseInt(numcom))==-1)
     {
        return false;
     }
  }
  return true;
}

function isFloat(num)
{
var numstr=".0123456789";
var count=0;
for(i=0;i<num.length;i++)
  {
  numcom=num.substring(i,i+1);
  if(numstr.indexOf(numcom)==-1)
    {
	return false;
	}
	if(numcom==".")
	  {
		count++
	  }
  }
  if(count>1)
	{
	  return false;
	}
return true;
}

function showconfirm(yourURL, yourTitle)
{
   var truthBeTold = window.confirm(yourTitle);
   if (!truthBeTold)
   {
      return false;
   }
   location.href = yourURL;
}

function keyEnter(fname)
{ 
 var obj = fname;
 key=window.event.keyCode; 
 if(key==0xD)
  {	 
    CurTabIndex=event.srcElement.tabIndex+1	
    for (n=0;n<eval(obj).elements.length;n++)  
   {
        if (eval(obj).elements[n].tabIndex==CurTabIndex) 
       {
             eval(obj).elements[n].focus(); 
			  return true;
      } 
    } 
  } 
}



function valDate(M, D, Y){ 
var Months= new Array(31,28,31,30,31,30,31,31,30,31,30,31); 
var Leap = false; 
var ok=true;
if((Y % 4 == 0) && ((Y % 100 != 0) || (Y %400 == 0))){Leap = true;}
if(!isNum(M) || !isNum(D) || !isNum(Y)){ok=false;}
if(Y>2099 || Y<1850){ok=false;}
if((D < 1) || (D > 31) || (M < 1) || (M > 12) || (Y < 0)){ok=false;}
if((D > Months[M-1]) && !((M == 2) && (D > 28))){ok=false;}
if(!(Leap) && (M == 2) && (D > 28)){ok=false;}
if((Leap) && (M == 2) && (D > 29)){ok=false;}
return ok;
} 

function isDate(val){ 
var dSize = val.length; 
if(val=='') return; 

//将输入的日期字符串分隔成3部分 (Month, Day & Year) 
var idxBarI = val.indexOf("-"); 
var idxBarII= val.lastIndexOf("-"); 
var strY = val.substring(0,idxBarI); 
var strM = val.substring(idxBarI+1,idxBarII); 
var strD = val.substring(idxBarII+1,dSize); 

strM = (strM.length < 2 ? '0'+strM : strM); 
strD = (strD.length < 2 ? '0'+strD : strD); 
if(strY.length == 2){strY = (strY > 50 ? '19'+strY : '20'+strY);}
var Ok = valDate(strM,strD,strY);
return Ok;
} 


function TableRowChecked()
{
	//TableName Must be tMain
	var flag=false;
	for(var i=1;i<tMain.rows.length;i++)
	{
		if(tMain.rows[i].cells[0].children[0].checked)
		{
			flag=true;
			break;
		}
	}
	return flag;
}

/**
 *初始化一个xmlhttp对象
 */
function InitObj(){
    var ajax  =  false;
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            ajax = false;
        }
    }
    if (!ajax && typeof XMLHttpRequest!='undefined') {
        ajax = new XMLHttpRequest();
    }
    return ajax;
}

function getUnitType(unitname, objSelect, defaultval)
{ 
    alert(postStr);
    var ajax = InitObj();
    var postStr = "unitname=" + unitname;
    
    ajax.open("POST", "/getunittype.php", true);
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send(postStr);
    ajax.onreadystatechange = function() 
    {
       var oOption;
       var unittype = new Array();
        if (ajax.readyState == 4 && ajax.status == 200) 
        {
            returnVal  = ajax.responseText;
            alert(returnVal);
            if(returnVal != "false")
            {
               var ret = new String(returnVal);
               unittype = ret.split("	");
               var i;
               for (i = 0; i < unittype.length; i++)
               {
                  oOption = document.createElement("OPTION");
                  oOption.text = unittype[i];
                  oOption.value = unittype[i];
                  if (unittype[i].equals(defaultval))
                  {
                     oOption.selected = true;
                  }
                  else
                  {
                     oOption.selected = false;
                  }
                  objSelect.add(oOption);
               }
            }
        }
    }
}


/*从左右列表相互移动选项，选项上下移动，the following is ok in IE。*/
function moveItemsL2R(fromCase, toCase) {
	/*fromCase源选择框，toCase目标选择框*/
	var willMove =new Array();
	var i;

	for (i=0;i<fromCase.length;i++) {
		if (fromCase.options[i].selected) {
			var transferItem=document.createElement("OPTION");
			transferItem.text=fromCase.options[i].text;
			transferItem.value=fromCase.options[i].value;
			toCase.options.add(transferItem);
			//alert("*"+willMove.length);
			willMove[willMove.length]=i;
			//alert("**"+willMove[willMove.length-1]);
		}
	}
	//alert("***"+willMove.length);
	for (i=willMove.length-1;i>=0;i--) {
		//alert("****"+willMove[i]);
		fromCase.options.remove(willMove[i]);
	}
	return true;
}
function moveItemsAll(fromCase,toCase) {
	/*fromCase源选择框，toCase目标选择框*/
	var willMove=new Array();
	var i;
	//window.alert("select is select");
	for (i=0;i<fromCase.length;i++) {
			var transferItem=document.createElement("OPTION");
			transferItem.text=fromCase.options[i].text;
			transferItem.value=fromCase.options[i].value;
			toCase.options.add(transferItem);
			//alert("*"+willMove.length);
			willMove[willMove.length]=i;
			//alert("**"+willMove[willMove.length-1]);
	}
	//alert("***"+willMove.length);
	for (i=willMove.length-1;i>=0;i--) {
		//alert("****"+willMove[i]);
		fromCase.options.remove(willMove[i]);
	}
	return true;
}
function moveItemsU2D(thisCase,direction) {
	/*thisCase要进行上下移动的选择框，direction方向，取值为"up"，"down"，只对选中的第一个option移动，最好设定select为单选*/
	var selectedNumber=thisCase.selectedIndex;
	var tempItem=new Array(2);

	//window.alert(thisCase.selectedIndex);
	if (!(selectedNumber==-1 || selectedNumber==0)) {
		tempItem[0]=thisCase.options[selectedNumber].value;
		tempItem[1]=thisCase.options[selectedNumber].text;
		if (direction=="up") {
			movedNumber=selectedNumber-1;
		} else if (direction=="down") {
			movedNumber=selectedNumber+1;
		} else {
			return false;
		}
		thisCase.options[selectedNumber].value=thisCase.options[movedNumber].value;
		thisCase.options[selectedNumber].text=thisCase.options[movedNumber].text;
		thisCase.options[movedNumber].value=tempItem[0];
		thisCase.options[movedNumber].text=tempItem[1];
		thisCase.options[movedNumber].selected=true;
		thisCase.options[selectedNumber].selected=false;
	}
	//window.alert(thisCase.selectedIndex);
	return true;
}
function Ajax(thisServer) {
	this.url = "";
	this.send = function (url, method, callback, data) {
		var request = false;
		request = initXMLHttpRequestObject();
		if (method == "POST") {
			try {
				request.open("POST", this.url + url, true);//alert(this.url+url)
				request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				request.send(data);
				request.onreadystatechange = function () {
					if (request.readyState == 4 && request.status == 200) {
						callback(request, data);
					}
				};
			}
			catch (exception) {
			}
		} else {
			try {
				request.onreadystatechange = function () {
					if (request.readyState == 4 && request.status == 200) {
						callback(request, data);
					}
				};
				request.open("GET", url, true);
				request.send(null);
			}
			catch (exception) {
			}
		}
	};
}
/*结束从左右列表相互移动选项，选项上下移动，the following is ok in IE。*/
