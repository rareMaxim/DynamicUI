unit Test;

interface

uses
  DynamicUI,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Layouts;

type
  TForm6 = class(TForm)
    btn1: TButton;
    Layout1: TLayout;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FTest: TDynamicUI;
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses
  System.Rtti;

{$R *.fmx}

procedure TForm6.FormCreate(Sender: TObject);
begin
  FTest := TDynamicUI.Create(Self);
  FTest.Layout := Self;

  FTest.NewModule(btn1.QualifiedClassName)//
.SetProperty('Text', 'Test').SetProperty('Align', TValue.From(TAlignLayout.Top))
end;

end.

