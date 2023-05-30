// JavaScript Document
//navbar on jquery
<!--
/*菜单定义*/

var menus;

function menu(title,content,open_callback,close_callback,init_stat,menus,level)
{
	this._parent = false;
	var head = $(title);
	var body = $(content);
	
	this.level = level;
	
	this.getLevel = function()
	{
		return this.level;
	}
	
	function toogle(){
	
		for(var i = 0 ;i<menus.length;i++){
			if(menus[i].getLevel() == level){
				menus[i].close();
			}
		}
	
		if(body.css('display')=='none')
		{
			body.slideDown('fast');
			//if (open_callback)open_callback(head.get(0),body.get(0));
			head.addClass('open');
			head.removeClass('close');
			body.addClass('show');
			body.removeClass('hide');
		}
		else
		{
			body.slideUp('fast');
			//if (close_callback)close_callback(head.get(0),body.get(0));
			head.addClass('close');
			head.removeClass('open');
			body.addClass('hide');
			body.removeClass('show');
		}
		
		return (false);
	}
	head.click(toogle);
	head.keypress(toogle);
	head.select(function(){alert(':(');return false});
	this.open = function()
	{
		if(body.css('display')=='none')
		{
			body.slideDown('fast');
			head.addClass('open');
			head.removeClass('close');
			body.addClass('show');
			body.removeClass('hide');
			//if (open_callback)open_callback(head.get(0),body.get(0));
		}
		return (false);
	};
	this.close = function()
	{
		if(body.css('display')!='none')
		{
			body.slideUp('fast');
			//if (close_callback)close_callback(head.get(0),body.get(0));
			head.addClass('close');
			head.removeClass('open');
			body.addClass('hide');
			body.removeClass('show');
		}
		return (false);
	};
	

	
	
	/* 菜单初始化*/
	if(init_stat == 'hide' || init_stat == 'close' || init_stat == false ){
		if(body.css('display')!='none'){
			body.slideUp('fast');
			if (close_callback)close_callback(head.get(0),body.get(0));
			return (false);
		}
	}
}
// 菜单体有全部展开和全部收起的功能
function menubar()
{
	var level;
	
	var menus = new Array();
	this.menu = function(title,content,open_callback,close_callback,init_stat,level)
	{
		//this.level = level;
		menus.push(new menu(title,content,open_callback,close_callback,init_stat,menus,level));
	};
	this.expand = function()
	{
			for(var i = 0 ;i<menus.length;i++)menus[i].open();
			return (false);
	};
	this.collapse = function()
	{
			for(var i = 0 ;i<menus.length;i++)menus[i].close();
		return (false);
	};
}
/*结束*/

/*具体的应用实例*/
var show = true;
var hide = false;

//添加菜单	
/*window.onload=function()
{
	menus = new menubar();
	menus.menu("menu1",'menu1_content',my_on,my_off,hide);
	menus.menu("menu2",'menu2_content',my_on,my_off,hide);
	$('.menu_expand').click(menus.expand);
	$('.menu_collapse').click(menus.collapse)
}*/
$(document).ready(function(){
	menus = new menubar();
	$('.menu_expand').click(menus.expand);
	$('.menu_collapse').click(menus.collapse)
	var head = $('.menu_head').not('.static');
	var menu_body = $('.menu_body').not('.static');
	if(head.length == menu_body.length)
	{
		var flag = true;
		head.each(function(idx,o){
			var isShow = 'hide';
			if(flag == true){
				isShow = 'show';
			}
			else {
				isShow = 'hide';
			}
			flag = false;
			if(head.attr('class'))
			menus.menu(o,menu_body.get(idx),null,null,isShow,'first_level');
		})
	}
	$('.menu_head').filter('.static').click(function (){return (false);});
	
	//lsj add
	var sub_head = $('.sub_head').not('.static');
	var sub_body = $('.sub_body').not('.static');
	
	if(sub_head.length == sub_body.length)
	{
		sub_head.each(function(idx,o){
			if(sub_head.attr('class'))
			menus.menu(o,sub_body.get(idx),null,null,'hide','second_level');
		})
	}
	
	$('.sub_head').filter('.static').click(function (){return (false);});
	//lsj add end
	
})


//lsj add

/*
$(document).ready(function(){
	//menus = new menubar();
	//$('.menu_expand').click(menus.expand);
	//$('.menu_collapse').click(menus.collapse)
	
})
*/


//lsj add end

//-->
