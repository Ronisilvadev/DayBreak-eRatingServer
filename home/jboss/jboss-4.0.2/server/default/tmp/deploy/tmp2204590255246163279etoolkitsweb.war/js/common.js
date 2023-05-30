/**
*得到页面中checkbox（id是'checkboxlist'）的值。
*如果一个checkbox也没有勾选，返回""；否则返回以","分割的被选中的checkbox.value;
*/
function getSelectCheckboxIds(checkid) {
    var checkObj = "checkboxlist";
    if (checkid != null) {
        checkObj = checkid;
    }
    var ids = "";
    var ob=document.getElementsByName(checkObj);
      for(var i=0;i<ob.length;i++){
   if (ob[i].checked == true) {
            if (ids != "") {
                ids += ",";
            }
            ids += ob[i].value;
        }
        }
    return ids;
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