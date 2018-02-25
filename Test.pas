unit Test;

interface

uses
  DynamicUI, System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm6 = class(TForm)
    btn1: TButton;
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

{$R *.fmx}

procedure TForm6.FormCreate(Sender: TObject);
begin
  FTest := TDynamicUI.Create(Self);
  FTest.Layout := Self;
  FTest.NewModule(btn1.QualifiedClassName);
end;

end.

