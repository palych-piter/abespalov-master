#!/usr/bin/perl
$base_dir	="../guestbook";                #Базовая директория, где искать перечисленные ниже файлы. В принципе, Вы можете указать и полный путь для каждого из файлов. Лично я храню все файлы в одной директории..)
$file		="gb.txt";		#файл с записями Гостевой Книги.
$badwords	="badwords.txt";	#Список неприличных слов..
$banned		="badwords.txt";	#Список нехороших юзеров..


$script_url="../cgi-bin/guestbook.pl";          #ссылка на гостевуху. Можно и полную ссылку дать, типа "http://scripts.sinor.ru/cgi-bin/guestbook.pl"
$mailprog = '/usr/sbin/sendmail';               #Системная установка отправки почты: Путь к СендМайл - программе. Если не знаете точно, где лежит, спросите у Вашего Админа.
$mailto="moi_email\@mail.ru";                   #Впишите свой емайл вот так: moi_email\@mail.ru если хотите отправлять емайлы. Значок \ перед собакой ОБЯЗАТЕЛЕН!

$password='celeron';                            #Пароль для администрирования гостевухи. Не забудьте поменять.
$cenzura='Пиип!(цензура вырезала)';     	#Надпись, появляющаяся на месте матюгов.
$divider='<hr color="#808080" noshade size="1" width="85%">'; #Разделитель записей.
$bodyspecs= 'BODY BGCOLOR="#005000" LINK="#99FF99" VLINK="#669966" TEXT="#FFFFCC" TOPMARGIN="12" LEFTMARGIN="23" MARGINWIDTH="0" MARGINHEIGHT="0"';#полное содержимое тега BODY
$table_bgcolor="808080";                        #Фоновый цвет таблицы формы
$table_header_bgcolor="669933";                 #Фоновый цвет заголовка формы
$allow_html=0;					#Если поставить 1 то HTML в мессагах будет разрешён. Можно будет вставлять в тело гостевой всякие нехорошие теги HTML и скрипты JavaScript. Этим часто балуются Ламеры.
################################################################################################################################################################
#SYGNALSTRING>>>>>>>>>Эту строку ни в коем случае не трогайте, если планируете пользоваться АВТОКОНФИГУРАТОРОМ.<<<<<<<SYGNALSTRING
################################################################################################################################################################
#Строка выше является сигнальной - по ней АВТОКОНФИГУРАТОР определяет,
#что конфигурационная часть закончилась и начинается код.


################################################################################
#Вот получаем дату в виде текстовой переменной " $date "
@months = ('Января','Февраля','Maрта','Aпреля','Maя','Июня','Июля','Aвгуста','Сeнтября','Oктября','Нoября','Дeкабря');
@days = ('Воскресенье','Пoнедельник','Вторник','Среда','Четверг','Пятница','Суббота');
($sec,$min,$hour,$mday,$mon,$year,$wday) = (localtime(time))[0,1,2,3,4,5,6];
if ($sec < 10) { $sec = "0$sec"; }
if ($min < 10) { $min = "0$min"; }
if ($hour < 10) { $hour = "0$hour"; }
if ($mday < 10) { $mday = "0$mday"; }
if ($year >99) { $year = $year-100+2000; } else {$year = $year+1900;}
#Это только что был фикс проблемы 2000 (Y2k bug, е&$ть его в с$%ку)
$date = "$days[$wday], $mday $months[$mon] $year г. $hour:$min:$sec";

#################################################################################
#Батч, то есть линейная часть выполнения процедур. Как сказал Гагарин - ПОЕХАЛИ!
&fileopen;
&parse_form;
#-------В планах:          &check_form_data;    #Проверка на БАН.

################################################################################
#Далее ветвим выполнение скрипта в зависимости от того, какие данные введены в форму..
if ($FORM{'nick'}eq $password)			{&admin;}
elsif ($FORM{'Send'}eq "Отправить")		{&add_zapis;&fileopen;&send_mail;&gb_show;}
elsif ($FORM{'submit'}eq "Удалить эту запись!")	{&del_zapis;&fileopen;&gb_show;}
elsif ($FORM{'submit'}eq "Применить список")	{&apply_badwords;&fileopen;&gb_show;}
else 						{&gb_show;}

#################################################################################
sub add_zapis{#ЗДЕСЬ!!! именно здесь добавляется запись.. Надо ввести Filelocking.
open (shnyaga, ">$file")|| error ("Не открывается на запись противный филей \"$file\"..");
print shnyaga  "$divider<table border=0 width=\"75%\"><tr><td width=\"16%\"><i>Автор:</i></td><td><a href=\"mailto:$FORM{'email'}\"><b>$FORM{'nick'}</b></a></td></tr><tr><td width=\"16%\">$FORM{'city'}</td><td>$date</td></tr><tr><td><i>Сообщение:</i></td><td><b>$FORM{'message'}</b></td></tr></table><!--Отправлено с IP: $ENV{'REMOTE_ADDR'} (host: $ENV{'REMOTE_HOST'})-->\n";
print shnyaga @zapisi;
close shnyaga;
}
################################################################################
sub apply_badwords{#Изменение списка нехороших словечек.
open (shnyaga, ">$badwords")|| error ("Не открывается на запись противный филей \"$badwords\"..");
print shnyaga $FORM{'badwords'};
close shnyaga;
}

################################################################################
sub send_mail {
if ($mailto){
    open(MAIL,"|$mailprog -t");
    print MAIL "To: $mailto\n";
    print MAIL "From: $FORM{'nick'} <$FORM{'email'}>\n";
    print MAIL "Content-Type: text/plain; charset=Windows-1251\n";
    print MAIL "Content-Transfer-Encoding: 8bit\n";
    print MAIL "Subject: HoBoe cooбщeHиe на Стенгазете.\n\n" ;
    print MAIL "На Стенгазету только что пришло новое сообщение от $FORM{'nick'}\n";
    print MAIL "Его е-майл: $FORM{'email'}\n\nВот это сообщение:\n $FORM{'message'}" ;
    print MAIL "IP-Адрес: $ENV{'REMOTE_ADDR'}\n$date\n\n\n";
    print MAIL "Вот это сообщение:\n $FORM{'message'}" ;
    print MAIL "\n\n\n--------------------------------------------------------\n";
    print MAIL "Это сообщение сформировано автоматически.\n";
    print MAIL "Если Вы получили его помимо своего желания, пожалуйста,\n";
    print MAIL "перенаправьте его по адресу animals\@online.sinor.ru ." ;
    close (MAIL);
    }}
#################################################################################
sub del_zapis{
open (shnyaga, ">$file")||error ("Не открывается на запись противный филей \"$file\"..");
$counter=1;
foreach $zapis (@zapisi){
if ($FORM{$counter} ne "1"){print shnyaga $zapis;}
$counter++;
#-------Отладка:          print "Запись: $zapis<br>ФОРМА: $FORM{$counter} ($counter)<hr>";
}
close shnyaga;
}
#################################################################################
sub admin{
print <<END_OF_PAGE
Content-type: text/html


<html>
<head>

<title>Администрирование Гостевой книги</title>
</head>

<$bodyspecs>

<div align="center"><center>
<h2>Администрируем Гостевую Книгу</h2><br>
<form action="$script_url" method="post">
<table bgcolor="#$table_header_bgcolor" cellpadding=0 cellspacing=1 width="76%"><tr><td>
<table  bgcolor="#$table_bgcolor" border="0" cellpadding="0" width="100%">
<tr bgcolor="#$table_header_bgcolor"><td>Запись которую следует.............</td><td>Удалить!</td></tr>
END_OF_PAGE
;
###########
#Выпечатываем запись за записью с чекбоксами.
$count=1;
foreach $zapis (@zapisi){
print "<tr><td valign=top>$divider$zapis</td><td valign=top>$divider<input type=\"checkbox\" name=\"$count\" value=\"1\">$count</td></tr>";
$count++;
}
#Выпечатали
###########
print <<END_OF_PAGE
<tr>
<td valign=top colspan=2>
<input type="submit" name="submit" value="Удалить эту запись!"></td></tr>
</table>
</td>
</tr>
</table>
</form>
END_OF_PAGE
;
#Теперь вторая чать Админа:  Плохие Слова.
print <<END_OF_PAGE
<form action="$script_url" method="post">
<table bgcolor="#$table_header_bgcolor" cellpadding=0 cellspacing=1 width="76%"><tr><td>
<table  bgcolor="#$table_bgcolor" border="0" cellpadding="0" width="100%">
<tr bgcolor="#$table_header_bgcolor"><td>Список матюгов</td></tr>
<tr><td><textarea name="badwords" rows="12" cols="60">
END_OF_PAGE
;
###########
#Выпечатываем плохие слова
open(FILE,$badwords)||error ("Не открывается на чтение файл с неприличными словами \"$badwords\"..");
my @materki = <FILE>;
close(FILE);

print @materki;
#Выпечатали
###########
print <<END_OF_PAGE
</textarea></td></tr>
<tr>
<td valign=top>
<input type="submit" name="submit" value="Применить список">
</td></tr>
</table>
</td>
</tr>
</table>

</form>
</body>
</html>
END_OF_PAGE
;
&fileopen;}
#################################################################################
sub gb_show{

my $input_form=<<ENDOFFORM
<center>
<TABLE BORDER=0 CELLPADDING=0 WIDTH="400" >
<TR ALIGN=CENTER VALIGN=CENTER>
<TD ALIGN=CENTER></CENTER>

<TABLE BORDER=0 CELLPADDING=4 width="100%" bgcolor="#$table_bgcolor">
<TR>
<TD BGCOLOR="#$table_header_bgcolor">
<CENTER><B>Оставьте&nbsp;&nbsp; Вашу&nbsp;&nbsp;запись</B></CENTER>
</TD>
</TR>

<TR>
<TD BGCOLOR="$table_bgcolor">
<FORM METHOD="POST" name="Feedback" onSubmit="return checkAll()" ACTION="$script_url">

<B>Имя:</B><BR>
<INPUT TYPE="text" NAME="nick" VALUE="" SIZE=45><BR>

<B>e-mail:</B>&nbsp;<BR>
<INPUT TYPE="text" NAME="email" VALUE="" SIZE=45><BR>

<B>Город:</B>&nbsp;<BR>
<INPUT TYPE="text" NAME="city" VALUE="" SIZE=45><BR>

<B>Текст:</B>&nbsp;<BR>
<TEXTAREA NAME="message" ROWS=6 COLS=45 wrap=no></TEXTAREA>

<CENTER>
<TABLE BORDER=0 CELLSPACING=0 >
<CAPTION>
<CENTER>

</CENTER>
</CAPTION>

<TR>
<TD><INPUT TYPE="submit" NAME="Send" VALUE="Отправить"></TD>

<TD><INPUT TYPE="reset" VALUE="Очистить"></TD>

<TD>
<CENTER></FORM></CENTER>
</TD>
</TR>

<TR>
<TD COLSPAN="2">
</TD>
</TR>
</TABLE></CENTER>


</TD></TR></TABLE>
</TD>
</TR>

<TR>
<TD>
</TD></TR></TABLE>

</center>

<script language="JavaScript">
<!-- //hide

function isValidName(str)
{
if(str=="")
{
alert("Представьтесь пожалуйста!")
return false
}
return true
}

function isValidEmailAddress(str)
{
if((str=="")||(str.indexOf("@",0)==-1)||(str.indexOf(" ",0)>-1)||(str.indexOf(".",0)==-1))
{
alert("Пожалуйста, введите правильный e-mail")
return false
}
return true
}



function isValidCity(str)
{
if(str=="")
{
alert("Простите, но откуда Вы?")
return false
}
return true
}


function isValidMessage(str)
{
if(str=="")
{
alert("А что же Вы сказать-то хотели?..")
return false
}
return true
}

function checkAll()
{
if(!isValidName(document.Feedback.nick.value))
return false
else if(!isValidEmailAddress(document.Feedback.email.value))
return false
else if(!isValidCity(document.Feedback.city.value))
return false
else if(!isValidMessage(document.Feedback.message.value))
return false
return true
}
//end hide-->
</script>
ENDOFFORM
;

print <<END_OF_PAGE
Content-type: text/html

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=Windows-1251">
<META NAME="Generator" CONTENT="NetObjects Fusion 4.0 Trial for Windows">
<TITLE>Гостевая Книга</TITLE>
</HEAD>
<$bodyspecs>
<p align="center">   
@zapisi
<br>
$input_form
</p>
</BODY>
</HTML>
END_OF_PAGE
;
}
##################################################################################
sub parse_form{
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
        @pairs = split(/&/, $buffer);
        foreach $pair (@pairs){
                ($val1, $val2) = split(/=/, $pair);

		$val1 =~ tr/+/ /;
                $val1 =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
                $val2 =~ tr/+/ /;
                $val2 =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
                $val2 =~ s/(|\n)*//g;

                if ($val1 ne "badwords"){
      		if ($allow_html != 1) {		$value =~ s/<([^>]|\n)*>//g;}
	      	else {unless ($name eq 'body') {	$value =~ s/<([^>]|\n)*>//g;}}

                        $val2 =~ s/\cM\n*/\n/g;
                        $val2 =~ s/\n/<BR>/g;
                        $val2 =~ s/<BR>\s\s\s+/<BR><BR>/g;
                        $val2 =~ s/<BR>\t/<BR><BR>/g;
                        $val2 =~ s/\s+/ /g;
                        $val2 =~ s/<BR>\s/<BR>/g;
                        $val2 =~ s/\s<BR>/<BR>/g;
                        $val2 =~ s/<BR><BR>/<P>/g;
                        $val2 =~ s/<P><BR>/<P>/g;
                	$val2 =~ s/^\s+//g;#Уборка пробелов в начале
                	$val2 =~ s/\s+$//g;#и конце

                        open(FILE,$badwords)||error ("Не открывается на чтение файл с неприличными словами \"$badwords\"..");
			my @materki = <FILE>;
			close(FILE);
                        foreach $materok (@materki){
			$val2 =~ s/$materok/$cenzura/ig;
			}
                        }
                if ($FORM{$val1}) {
                $FORM{$val1} = "$FORM{$val1} $val2"; }
        else {  $FORM{$val1} = $val2;}
}}
#################################################################################
sub fileopen{open(FILE,$file)||error ("Не открывается на чтение противный филей \"$file\"..");@zapisi = <FILE>;close(FILE);}
################################################################################
sub error{
print "Content-type: text/html\n\n<h3>@_</h3>";
die @_;
}

1;