unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
 type
  TPStudent=^TStudent; // указатель на тип TPStudent
TStudent = record
fam:string[20]; // фамилия
name:string[20]; // имя
next:TPStudent; // следующий элемент списка
end;
var
head: TPStudent;// начало (голова) списка

{ TForm1 }



procedure TForm1.Button1Click(Sender: TObject);
var
nov:TPStudent;// новый элемент списк
begin
  new(nov);// создание нового элемента списка
nov^.fam:=Edit1.Text;// фамилия
nov^.name:=Edit2.Text;// имя
nov^.next:=head;
head:=nov;
 Edit1.Text:='';
 Edit2.Text:='';
 Edit1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
 var
tek:TPStudent; // текущий проверяемый узел
pre:TPStudent; // предыдущий узел
del:boolean; // узел, который надо удалить
begin
  if head=nil then
begin
MessageDlg('Список пуст!', mtError, [mbOk],0);
exit;
end;
tek:=head; //текущий узел - первый узел
pre:=nil;// предыдущего узла нет
del:=false;
//найти узел, который надо удалить
while (tek<>nil) and (not del) do
begin
if (tek^.fam=Edit1.Text) and (tek^.name=Edit2.text)
then del:=true // нужный узел найден
else// к следующему узлу
begin
pre:=tek;
tek:=tek^.next;
end;
end;
if del then
begin
if MessageDlg('Узел будет удален из списка!', mtWarning,
[mbOk,mbCancel],0)=mrYes
then exit;
 if pre=nil
then head:=tek^.next else pre^.next:=tek^.next;
Dispose(tek);
MessageDlg('Узел найден и будет удален из списка!'+#13 + 'имя-'+Edit1.Text+'фамилия-'+Edit2.Text, mtInformation, [mbOk],0);
end
else// узла, который надо удалить, в списке нет
MessageDlg('Узел '+'имя-'+Edit1.Text+'фамилия-'+Edit2.Text+#13+'не найден', mtError, [mbOk],0);
edit1.text:='';
 edit2.text:='';
 edit1.SetFocus;
end;



procedure TForm1.Button3Click(Sender: TObject);
var
tek:TPStudent; // текущий элемент списка
n:integer; // количество элементов списка
st: string; //строковое представление списка
begin
 n:=0;
st:='';
tek:=head;
while tek<>nil do
begin
n:=n+1;
st:=st+tek^.fam+' '+ tek^.name+#13;
tek:=tek^.next;
end;
if n<>0
then ShowMessage('Список:'+#13+st) else ShowMessage('Список пуст!');
end;
procedure  TForm1.FormCreate(Sender: TObject);
begin
  head:=nil;
end;
end.

