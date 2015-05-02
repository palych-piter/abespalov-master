var height=0;
var width=0;
if (self.screen) { // for NN4 and IE4
    width = screen.width
    height = screen.height
}
else if (self.java) { // for NN3 with enabled Java
    var jkit = java.awt.Toolkit.getDefaultToolkit();
    var scrsize = jkit.getScreenSize();       
    width = scrsize.width; 
    height = scrsize.height; 
}
if (width <=0 || height <=0) { width = 480; height = 640; } 
function openwin (url) {
	var w=width-40;
	var h=height-80;
	window.open(url,'Galery','scrollbars,resizable,width='+w+',height='+h+',left=20,top=20');
	void(0);		
}

function imagewin(image, w, h) {
	w=w+40;
	h=h+40
	var left=(width-w-40)/2;
	var top=(height-h-40)/2;
	if (left<=0) {left=1; w=width-10; }
	if (top<=0) {top=1; h=height-10; }
	window.open(image,'new','scrollbars,resizable,width='+w+',height='+h+',left='+left+',top='+top);
	void(0);
}


function switch_page_work() {
if (document.work_form.work_menu.selectedIndex == 0) location='index.htm';
else if (document.work_form.work_menu.selectedIndex == 1) location='index.htm';
else if (document.work_form.work_menu.selectedIndex == 2) location='music.htm';
else if (document.work_form.work_menu.selectedIndex == 3) location='movies.htm';
else if (document.work_form.work_menu.selectedIndex == 4) location='jokes.htm';
else if (document.work_form.work_menu.selectedIndex == 5) location='cv-en.htm';
}

function switch_page_work_tnsn() {
if (document.work_form.work_menu.selectedIndex == 0) location='../index.htm';
else if (document.work_form.work_menu.selectedIndex == 1) location='./index.htm';
else if (document.work_form.work_menu.selectedIndex == 2) location='./people.htm';
else if (document.work_form.work_menu.selectedIndex == 3) location='./aud.htm';
else if (document.work_form.work_menu.selectedIndex == 4) location='./book.htm';
else if (document.work_form.work_menu.selectedIndex == 5) location='./songs.htm';
else if (document.work_form.work_menu.selectedIndex == 5) location='./texts.htm';
else if (document.work_form.work_menu.selectedIndex == 6) location='./news.htm';
else if (document.work_form.work_menu.selectedIndex == 7) location='../index.htm';
}



var list_options=new newArr(
"Куда пойдем ? :)=t.htm=2000-06-06",
"Музыка - любимое=t.htm=2000-06-06",
"Кино - любимое=t.htm=2000-06-06",
"English Jokes=t.htm=2000-06-06",
"CV - Еnglish=t.htm=2000-06-06")

var today = new Date();

//-------------------- end of description -------------------

function newArr() { 
	this.length=newArr.arguments.length;
	for (var i=0; i<=this.length; i++) this[i]=newArr.arguments[i];
}

function newWin(url) {
var vTop=40;
var vLeft=280;
if (self.screen) {
    var vTop=(screen.height - 400)/2;
    var vLeft=screen.width - 360; }
    var vWin=window.open ('./'+url+'.htm','Desc','scrollbars,dependent,height=300,width=328,left='+vLeft+',top='+vTop+'');
    vWin.focus();
}


function prStr(rty) {
		for (var i=0; i<eval(rty+'.length'); i++) {
		var s=eval(rty + '[i].split("=")');
		document.write(s[0],'&nbsp;<A HREF="javascript:newWin(' + "'" + s[1] + "'" + ')">','<IMG SRC="images/u1.gif" WIDTH=18 HEIGHT=16 ALT="Iia?iaiaa..." BORDER="0">','</A><BR>');
	}
}





function News (update) {
	var vUpdate = update.split("-");
	var vDt = new Date(vUpdate[0],vUpdate[1]-1,vUpdate[2]);
	if ((today - vDt)/86400000<15) return true;
	return false;
}

/* JavaScript error stopper - By Website Abstraction (www.wsabstract.com) 200+ free JavaScripts here */
function stoperror() {return true; }
window.onerror = stoperror;	