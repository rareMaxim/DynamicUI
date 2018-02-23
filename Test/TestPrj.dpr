program TestPrj;

uses
  System.StartUpCopy,
  FMX.Forms,
  Test in '..\Test.pas' {Form6},
  DynamicUI in '..\DynamicUI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
