unit DynamicUI;

interface

uses
  System.Rtti,
  System.Classes,
  FMX.Types;

type
  IduiModule = interface
    ['{FC116234-E717-4AF4-95AA-20D2EB98B8A6}']
 //   function SetProperty(const AName: string; AValue: TValue): IduiModule;
  end;

  TduiModule = class(TInterfacedObject, IduiModule)
  private
    FType: TRttiType;
  protected
    procedure DoInitRttiType;
  public
    constructor Create(ARttiType: TRttiType);
  end;

  TDynamicUI = class(TComponent)
  private
    FLayout: TFmxObject;
    FRttiCtx: TRttiContext;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function NewModule(const AQualifiedName: string): IduiModule;
  published
    property Layout: TFmxObject read FLayout write FLayout;
  end;

implementation

{ TDynamicUI }

constructor TDynamicUI.Create(AOwner: TComponent);
begin
  inherited;
  FRttiCtx := TRttiContext.Create;
end;

destructor TDynamicUI.Destroy;
begin
  FRttiCtx.Free;
  inherited;
end;

function TDynamicUI.NewModule(const AQualifiedName: string): IduiModule;
begin
  Result := TduiModule.Create(FRttiCtx.FindType(AQualifiedName));
end;

{ TduiModule }

constructor TduiModule.Create(ARttiType: TRttiType);
begin
  FType := ARttiType;
  DoInitRttiType;
end;

procedure TduiModule.DoInitRttiType;
var
  LConstructorMethod: TRttiMethod;
begin
  for LConstructorMethod in FType.GetMethods do
  begin
    if LConstructorMethod.IsConstructor then
    begin

    end;

  end;
end;

end.

