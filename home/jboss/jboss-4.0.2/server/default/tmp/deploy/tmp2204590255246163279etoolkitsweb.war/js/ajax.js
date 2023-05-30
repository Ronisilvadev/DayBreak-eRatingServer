
function $() {
	var elements = new Array();
	for (var i = 0; i < arguments.length; i++) {
		var element = arguments[i];
		if (typeof element == "string") {
			var obj = document.getElementById(element);
			if(null == obj){
				element = document.getElementsByName(element)[0];
			}
			else{
				element = obj;
			}
		}
		if (arguments.length == 1) {
			return element;
		}
		elements.push(element);
	}
	return elements;
}


function getOs()
{
   if(navigator.userAgent.indexOf("MSIE")>0) return 1;//IE6.0-7 or marthon
   if(isFirefox=navigator.userAgent.indexOf("Firefox")>0)return 2;//firefox
   /*if(isopera=navigator.userAgent.indexOf("Opera")>0)return 3;//opera
   if(isSafari=navigator.userAgent.indexOf("Safari")>0)return 4;  
   if(isCamino=navigator.userAgent.indexOf("Camino")>0)return 5;
   if(isMozilla=navigator.userAgent.indexOf("Gecko")>0)return 6;*/
   return 0;
}

/**
 *   兼容firefox的 outerHTML  使用以下代码后，firefox可以使用element.outerHTML
 **/

if(window.HTMLElement) {
    HTMLElement.prototype.__defineSetter__("outerHTML",function(sHTML){
        var r=this.ownerDocument.createRange();
        r.setStartBefore(this);
        var df=r.createContextualFragment(sHTML);
        this.parentNode.replaceChild(df,this);
        return sHTML;
        });

    HTMLElement.prototype.__defineGetter__("outerHTML",function(){
     var attr;
        var attrs=this.attributes;
        var str="<"+this.tagName.toLowerCase();
        for(var i=0;i<attrs.length;i++){
            attr=attrs[i];
            if(attr.specified)
                str+=" "+attr.name+'="'+attr.value+'"';
            }
        if(!this.canHaveChildren)
            return str+">";
        return str+">"+this.innerHTML+"</"+this.tagName.toLowerCase()+">";
        });
       
 HTMLElement.prototype.__defineGetter__("canHaveChildren",function(){
  switch(this.tagName.toLowerCase()){
            case "area":
            case "base":
         case "basefont":
            case "col":
            case "frame":
            case "hr":
            case "img":
            case "br":
            case "input":
            case "isindex":
            case "link":
            case "meta":
            case "param":
            return false;
        }
        return true;

     });
     
 HTMLElement.prototype.__defineGetter__("innerText",function (){
	var anyString = "";

	var childS = this.childNodes;
	for(var i=0; i<childS.length; i++)
	{
		if(childS[i].nodeType==1)
			anyString += childS[i].tagName=="BR" ? '\n' : childS[i].innerText;
		else if(childS[i].nodeType==3)
			anyString += childS[i].nodeValue;
	}

	return anyString;
	});
}


 

/**
 *   兼容firefox的 xpath 
 **/

if(document.implementation && document.implementation.createDocument)
{
    XMLDocument.prototype.loadXML = function(xmlString)
    {
        var childNodes = this.childNodes;
        for (var i = childNodes.length - 1; i >= 0; i--)
            this.removeChild(childNodes[i]);

        var dp = new DOMParser();
        var newDOM = dp.parseFromString(xmlString, "text/xml");
        var newElt = this.importNode(newDOM.documentElement, true);
        this.appendChild(newElt);
    };

    // check for XPath implementation
    if( document.implementation.hasFeature("XPath", "3.0") )
    {
       // prototying the XMLDocument
       XMLDocument.prototype.selectNodes = function(cXPathString, xNode)
       {
          if( !xNode ) { xNode = this; } 
          var oNSResolver = this.createNSResolver(this.documentElement)
          var aItems = this.evaluate(cXPathString, xNode, oNSResolver, 
                       XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null)
          var aResult = [];
          for( var i = 0; i < aItems.snapshotLength; i++)
          {
             aResult[i] =  aItems.snapshotItem(i);
          }
          return aResult;
       }

       // prototying the Element
       Element.prototype.selectNodes = function(cXPathString)
       {
          if(this.ownerDocument.selectNodes)
          {
             return this.ownerDocument.selectNodes(cXPathString, this);
          }
          else{throw "For XML Elements Only";}
       }
    }

    // check for XPath implementation
    if( document.implementation.hasFeature("XPath", "3.0") )
    {
       // prototying the XMLDocument
       XMLDocument.prototype.selectSingleNode = function(cXPathString, xNode)
       {
          if( !xNode ) { xNode = this; } 
          var xItems = this.selectNodes(cXPathString, xNode);
          if( xItems.length > 0 )
          {
             return xItems[0];
          }
          else
          {
             return null;
          }
       }
       
       // prototying the Element
       Element.prototype.selectSingleNode = function(cXPathString)
       {    
          if(this.ownerDocument.selectSingleNode)
          {
             return this.ownerDocument.selectSingleNode(cXPathString, this);
          }
          else{throw "For XML Elements Only";}
       }
    }
}

/*初始化 XMLHTTPRequest 对象*/
function initXMLHttpRequestObject() {
	var xml;
	var xmlArray = ["MSXML2.XMLHTTP", "Microsoft.XMLHTTP"];
	for (var i = 0; i < xmlArray.length; i++) {
		try {
		//ie 浏览器
			xml = new ActiveXObject(xmlArray[i]);
		}
		catch (e) {
		}
		if (xml != null) {
			return xml;
		}
	}
	//其他浏览器
	xml = new XMLHttpRequest();
	//设置编码
	//xml.overrideMimeType("text/html;charset=gb2312");
	return xml;
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
function getXmlObjectArray(xml, tagName) {
	return xml.getElementsByTagName(tagName);
}
function getXmlObject(xml, tagName) {
	return getXmlObjectArray(xml, tagName)[0].firstChild;
}
function getXmlValue(xml, tagName) {
	return getXmlObject(xml, tagName).data;
}
function getXmlAttribute(response, tagName, attr) {
	var root = getXmlObjectArray(response.responseXML, tagName)[0];
	if (root == null) {
		return root;
	} else {
		return root.getAttribute(attr);
	}
}
function getResultArray(response, tagName) {
	var resultArray = [];
	var objectArray = getXmlObjectArray(response.responseXML, tagName);
	for (var i = 0; i < objectArray.length; i++) {
		if (objectArray[i].firstChild == null) {
			resultArray[i] = "";
		} else {
			resultArray[i] = objectArray[i].firstChild.data;
		}
	}
	return resultArray;
}

/*  
	@class:     
	XPath  @author:    
	Kinglong(kinglong@gmail.com)  
	@version:   0.5  
	@link:      http://www.klstudio.com  
	@build:     20080122  
	@lib:       none  
	*/  
	XPath = {       
		getIEXmlAX:function (){           
			var i,activeXarr;           
			var activeXarr = [
				"MSXML4.DOMDocument",
				"MSXML3.DOMDocument",               
				"MSXML2.DOMDocument",               
				"MSXML.DOMDocument",               
				"Microsoft.XmlDom"                          
							];             
			for(i=0; i<activeXarr.length; i++){               
				try{                   
					var o = new ActiveXObject(activeXarr[i]);                   
					return o;               
				}catch(e){}           
			}           
			return false;       
		 }       
		 ,       
		 parseXML:function(source){           
			try{               
				var domParser = new DOMParser();               
				var o = domParser.parseFromString(source,'text/xml');                  
				return o.documentElement;           
			}catch(e){               
				try{                   
					var o = this.getIEXmlAX();                   
					o.loadXML(source);                   
					return o.documentElement;               
				}catch(e){                   
					return null;               
				}           
			}       
		}       
		,       
		loadXML:function(path){           
			var xmlDoc=null;           
			if (window.ActiveXObject){               
				xmlDoc=this.getIEXmlAX();           
			}
			else if (document.implementation && document.implementation.createDocument){ 
				xmlDoc=document.implementation.createDocument("","",null);           
			}else{               
				alert('Your browser cannot handle this script');           
			}           
			xmlDoc.async=false;           
			xmlDoc.load(path);           
			return xmlDoc;       
		} 
	}

function v(name) {
	return $(name).value;
}
function blurNull(item, msg) {
	if (item.value == "") {
		alert(msg + "\uff01");
		return false;
	} else {
		return true;
	}
}
function checkNull(item, msg) {
	if (item.value.trim() == "") {
		alert(msg + "\uff01");
		item.focus();
		item.select();
		return false;
	} else {
		return true;
	}
}
function phonecheck(item,msg) {
	var str = item.value;
	var reg = /(^\d{7,8}$)|(^0\d{2,3}\-\d{7,8}$)|(^0?1[3,5][0-9]\d{8}$)/;   
	//var reg = /(^\d{7,16}$)/;

	if (reg.test(str) == false) {
		alert(msg + "!");
		item.focus();
		item.select();
		return false;
	}else{
		return true;
	}
	
}

// 检查是否为中文   
  
function isChn(str){   
  
      var reg = /^[u4E00-u9FA5]+$/;    //u4E00-u9FA5 这是汉字编码范围，首先检测str是否在这个范围之内，是的话，返回true 否则false   
  
      if(!reg.test(str)){   
       	return false;   
  
      }   
  
      return true;   
  
}  

function checkNum(item)//
{
	if (isNaN(item.value) )
	{
		alert("请输入一个数字!");
		item.focus();
		item.select();
		return false;
	}
	return true;
}

function checkInt(item)//
	{
	var TelNo=item.value ;
	var iTel ;

		for  (iTel=0;iTel<TelNo.length;iTel++)
		{
			var s=TelNo.substring(iTel,iTel+1) ;
			if (isNaN(s) )
			{
            window.alert("只能输入整数!");
		    item.select();
		   	item.focus();
			return false;

			break ;
			}
		}
			return true;
		
	}

/*
function checkImage(tFile){

	var filetypes = ["bmp","gif","jpg","jpeg","png","svg"];
	var filePath = tFile.value;
	var filetype = filePath.substring(filePath.lastIndexOf('.')+1,filePath.length)
	//验证文件类型
	if(!filetypes.contains(filetype)){
		alert("只能上传"+filetypes.toString()+"类型文件！");
		return false;
	}	
	
	checkImg.src = filePath;
	
	return true;
}

var checkImg =  $("fileChecker");
var maxFileSize = 1;
if(checkImg!= null)
checkImg.onreadystatechange = function ()   
{   
    if (checkImg.readyState == "complete")   
    {   
        //验证文件大小
		if (checkImg.fileSize > maxFileSize*1024*1024){
			alert("文件不能大于"+maxFileSize+"M！");
			return false;
		}  
    }   
} 
*/
var maxFileSize = 1;

function checkImage(tFile){

	var filetypes = ["bmp","gif","jpg","jpeg","png","svg"];
	var filePath = tFile.value;
	if(tFile.value.length == 0) return true;
	var filetype = filePath.substring(filePath.lastIndexOf('.')+1,filePath.length)
	//验证文件类型
	if(!filetypes.contains(filetype.toLowerCase())){
		alert("只能上传"+filetypes.toString()+"类型文件！");
		return false;
	}	
	
	var image = new Image();   
    image.dynsrc = filePath;   
	//验证文件大小
	if (image.fileSize > maxFileSize*1024*1024){
		alert("文件不能大于"+maxFileSize+"M！");
		return false;
	} 
	
	return true;
}

function getDate(){
	var d, s = "";           // 声明变量。
	d = new Date();                           // 创建 Date 对象。
	s += d.getYear() + "-";						 // 获取年份。
	s += (d.getMonth() + 1) + "-";            // 获取月份。
	s += d.getDate();		                 // 获取日。
	                         
	return(s);                                // 返回日期。
}

Array.prototype.toString = function() {
  var str = this[0];
  for(var i = 1;i<this.length;i++){
    str = str + "," + this[i];
  }
  return str;
}

Array.prototype.contains = function(arg) {
  for(var i = 0;i<this.length;i++){
    if(this[i] == arg){
      return true;
    }
  }
  return false;
}


Array.prototype.remove = function(arg) {
  for(var i = 0;i<this.length;i++){
    if(this[i] == arg){
      var nl = this.length-1;
      while(i<nl){
        this[i] = this[++i];
      };
      this.length = nl;
      return true;
    }
  }
  return false;
}


String.prototype.replaceAll = function (soeg, erstat) {
	var st = this;
	if (soeg.length == 0) {
		return st;
	}
	var idx = st.indexOf(soeg);
	while (idx >= 0) {
		st = st.substring(0, idx) + erstat + st.substr(idx + soeg.length);
		idx = st.indexOf(soeg);
	}
	return st;
}

String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, ""); 
}
