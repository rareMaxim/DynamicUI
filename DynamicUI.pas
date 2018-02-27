unit DynamicUI;

interface

uses
  System.Rtti,
  System.Classes,
  FMX.Types,
  System.Generics.Collections;

type
  IduiModule = interface
    ['{FC116234-E717-4AF4-95AA-20D2EB98B8A6}']
    function SetProperty(const AName: string; AValue: TValue): IduiModule;
  end;

  TduiModule = class(TInterfacedObject, IduiModule)
  private
    FType: TRttiInstanceType;
    FParent: TFmxObject;
    FModule: TValue;
  protected
    procedure DoInitRttiType;
  public
    function SetProperty(const AName: string; AValue: TValue): IduiModule;
    constructor Create(ARttiType: TRttiType; AParent: TFmxObject);
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
var
  LType: TRttiType;
begin
  Result := nil;
  LType := FRttiCtx.FindType(AQualifiedName);
  if LType <> nil then
    Result := TduiModule.Create(LType, FLayout);
end;

{ TduiModule }

constructor TduiModule.Create(ARttiType: TRttiType; AParent: TFmxObject);
begin
  FType := ARttiType.AsInstance;
  FParent := AParent;
  DoInitRttiType;
end;

procedure TduiModule.DoInitRttiType;
begin
  FModule := FType.GetMethod('Create').Invoke(FType.MetaclassType, [nil]);
  SetProperty('Parent', TValue.From(FParent));
end;

function TduiModule.SetProperty(const AName: string; AValue: TValue): IduiModule;
begin
  FType.GetProperty(AName).SetValue(FModule.AsObject, AValue);
  Result := Self;
end;

end.

