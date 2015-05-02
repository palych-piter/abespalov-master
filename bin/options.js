
var mainmenu=new newArr(
"Куда пойдем ? :)",
"Домой",
"Музыка - Любимое",
"Кино - Любимое",
"English Jokes",
"CV - English"
);

var tnsnmenu=new newArr(
"Куда пойдем ? :)",
"Тянь-Шань",
"Фото",
"История",
"Состав",
"Поэзия",
"Проза",
"Аудио",
"Видео",
"Новости",
"Домой"
);

var tnsnmgr=new newArr(
"index",
"fotos",
"book",
"people",
"songs",
"texts",
"aud",
"video",
"news",
"gbook"
);

function newArr() { 
	this.length=newArr.arguments.length;
	for (var i=0; i<=this.length; i++) this[i]=newArr.arguments[i];
}

function prStr(group) {
		for (var i=0; i<eval(group+'.length'); i++) {
		var s=eval(group + '[i].split("=")');
		document.write('<option>',s[0],'</option>');
	}
}

function prMenuGr(group) {
		for (var i=0; i<eval(group+'.length'); i++) {
		var s=eval(group + '[i].split("=")');
		document.write('<a  class=internallink href=',s[0],'.htm><img src=../images/tnsn/menu/',s[0],'.gif border=0></a><br>');
	}
}
function ViewFotoMenu(group) {
		document.write(' <p class=smallstringsleft>');
		document.write(' <span class=namestitle>Архив 1990-1996</span><br>');
		document.write(' <img src=../images/7pics.jpg border=0>&nbsp;<A  class=internallink HREF=fotos-arch1.htm><b>Том 1</b></a><br> ');
		document.write(' <img src=../images/7pics.jpg border=0>&nbsp;<A  class=internallink HREF=fotos-arch2.htm><b>Том 2</b></a><br> ');
		document.write(' <img src=../images/7pics.jpg border=0>&nbsp;<A  class=internallink HREF=fotos-arch3.htm><b>Том 3</b></a><br><br> ');
		document.write(' <span class=namestitle>Концерты</span><br> ');
		document.write(' <img src=../images/7pics.jpg border=0>&nbsp;<A  class=internallink HREF=fotos-live.htm><b>Мастер // Роттердам // 1996</b></a><br><br> ');
		document.write(' </p> ');
		
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
else if (document.work_form.work_menu.selectedIndex == 2) location='./fotos.htm';
else if (document.work_form.work_menu.selectedIndex == 3) location='./book.htm';
else if (document.work_form.work_menu.selectedIndex == 4) location='./people.htm';
else if (document.work_form.work_menu.selectedIndex == 5) location='./songs.htm';
else if (document.work_form.work_menu.selectedIndex == 5) location='./texts.htm';
else if (document.work_form.work_menu.selectedIndex == 6) location='./aud.htm';
else if (document.work_form.work_menu.selectedIndex == 7) location='./video.htm';
else if (document.work_form.work_menu.selectedIndex == 8) location='./news.htm';
else if (document.work_form.work_menu.selectedIndex == 9) location='../index.htm';
}


/* JavaScript error stopper - By Website Abstraction (www.wsabstract.com) 200+ free JavaScripts here */
function stoperror() {return true; }
window.onerror = stoperror;	




