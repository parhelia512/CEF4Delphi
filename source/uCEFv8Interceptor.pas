unit uCEFv8Interceptor;

{$IFDEF FPC}
  {$MODE OBJFPC}{$H+}
{$ENDIF}

{$I cef.inc}

{$IFNDEF TARGET_64BITS}{$ALIGN ON}{$ENDIF}
{$MINENUMSIZE 4}

interface

uses
  uCEFBaseRefCounted, uCEFInterfaces, uCEFTypes;

type
  TCefV8InterceptorOwn = class(TCefBaseRefCountedOwn, ICefV8Interceptor)
    protected
      function GetByName(const name: ustring; const object_: ICefv8Value; var retval: ICefv8Value; var exception: ustring): boolean; virtual;
      function GetByIndex(index: integer; const object_: ICefv8Value; var retval: ICefv8Value; var exception: ustring): boolean; virtual;
      function SetByName(const name: ustring; const object_, value: ICefv8Value; var exception: ustring): boolean; virtual;
      function SetByIndex(index: integer; const object_, value: ICefv8Value; var exception: ustring): boolean; virtual;

    public
      constructor Create; virtual;
  end;

  TCefFastV8Interceptor = class(TCefV8InterceptorOwn)
    protected
      FGetterByName  : TCefV8InterceptorGetterByNameProc;
      FSetterByName  : TCefV8InterceptorSetterByNameProc;
      FGetterByIndex : TCefV8InterceptorGetterByIndexProc;
      FSetterByIndex : TCefV8InterceptorSetterByIndexProc;

      function GetByName(const name: ustring; const object_: ICefv8Value; var retval: ICefv8Value; var exception: ustring): boolean; override;
      function GetByIndex(index: integer; const object_: ICefv8Value; var retval: ICefv8Value; var exception: ustring): boolean; override;
      function SetByName(const name: ustring; const object_, value: ICefv8Value; var exception: ustring): boolean; override;
      function SetByIndex(index: integer; const object_, value: ICefv8Value; var exception: ustring): boolean; override;

    public
      constructor Create(const getterbyname  : TCefV8InterceptorGetterByNameProc;
                         const setterbyname  : TCefV8InterceptorSetterByNameProc;
                         const getterbyindex : TCefV8InterceptorGetterByIndexProc;
                         const setterbyindex : TCefV8InterceptorSetterByIndexProc); reintroduce;
  end;

implementation

uses
  uCEFMiscFunctions, uCEFLibFunctions, uCEFv8Value;

function cef_v8_interceptor_get_byname(      self      : PCefV8Interceptor;
                                       const name      : PCefString;
                                             object_   : PCefV8Value;
                                       out   retval    : PCefv8Value;
                                             exception : PCefString): Integer; stdcall;
var
  TempObject      : TObject;
  TempException   : ustring;
  TempReturnValue : ICefv8Value;
  TempRecObject   : ICefv8Value;
begin
  Result     := Ord(False);
  retval     := nil;
  TempObject := CefGetObject(self);

  if (TempObject <> nil) and (TempObject is TCefV8InterceptorOwn) then
    try
      TempRecObject   := TCefv8ValueRef.UnWrap(object_);
      TempException   := '';
      TempReturnValue := nil;

      Result := Ord(TCefV8InterceptorOwn(TempObject).GetByName(CefString(name),
                                                               TempRecObject,
                                                               TempReturnValue,
                                                               TempException));

      retval := CefGetData(TempReturnValue);

      if (exception <> nil) then
        begin
          CefStringFree(exception);
          exception^ := CefStringAlloc(TempException);
        end;
    finally
      TempRecObject   := nil;
      TempReturnValue := nil;
    end;
end;

function cef_v8_interceptor_get_byindex(    self      : PCefV8Interceptor;
                                            index     : integer;
                                            object_   : PCefV8Value;
                                        out retval    : PCefv8Value;
                                            exception : PCefString): integer; stdcall;
var
  TempObject      : TObject;
  TempException   : ustring;
  TempReturnValue : ICefv8Value;
  TempRecObject   : ICefv8Value;
begin
  Result     := Ord(False);
  retval     := nil;
  TempObject := CefGetObject(self);

  if (TempObject <> nil) and (TempObject is TCefV8InterceptorOwn) then
    try
      TempRecObject   := TCefv8ValueRef.UnWrap(object_);
      TempException   := '';
      TempReturnValue := nil;

      Result := Ord(TCefV8InterceptorOwn(TempObject).GetByIndex(index,
                                                                TempRecObject,
                                                                TempReturnValue,
                                                                TempException));

      retval := CefGetData(TempReturnValue);

      if (exception <> nil) then
        begin
          CefStringFree(exception);
          exception^ := CefStringAlloc(TempException);
        end;
    finally
      TempRecObject   := nil;
      TempReturnValue := nil;
    end;
end;

function cef_v8_interceptor_set_byname(      self      : PCefV8Interceptor;
                                       const name      : PCefString;
                                             object_   : PCefV8Value;
                                             value     : PCefv8Value;
                                             exception : PCefString): integer; stdcall;
var
  TempObject    : TObject;
  TempException : ustring;
  TempValue     : ICefv8Value;
  TempRecObject : ICefv8Value;
begin
  Result     := Ord(False);
  TempObject := CefGetObject(self);

  if (TempObject <> nil) and (TempObject is TCefV8InterceptorOwn) then
    try
      TempRecObject := TCefv8ValueRef.UnWrap(object_);
      TempValue     := TCefv8ValueRef.UnWrap(value);
      TempException := '';

      Result := Ord(TCefV8InterceptorOwn(TempObject).SetByName(CefString(name),
                                                               TempRecObject,
                                                               TempValue,
                                                               TempException));

      if (exception <> nil) then
        begin
          CefStringFree(exception);
          exception^ := CefStringAlloc(TempException);
        end;
    finally
      TempRecObject := nil;
      TempValue     := nil;
    end;
end;

function cef_v8_interceptor_set_byindex(self      : PCefV8Interceptor;
                                        index     : integer;
                                        object_   : PCefV8Value;
                                        value     : PCefv8Value;
                                        exception : PCefString): integer; stdcall;
var
  TempObject    : TObject;
  TempException : ustring;
  TempValue     : ICefv8Value;
  TempRecObject : ICefv8Value;
begin
  Result     := Ord(False);
  TempObject := CefGetObject(self);

  if (TempObject <> nil) and (TempObject is TCefV8InterceptorOwn) then
    try
      TempRecObject := TCefv8ValueRef.UnWrap(object_);
      TempValue     := TCefv8ValueRef.UnWrap(value);
      TempException := '';

      Result := Ord(TCefV8InterceptorOwn(TempObject).SetByIndex(index,
                                                                TempRecObject,
                                                                TempValue,
                                                                TempException));

      if (exception <> nil) then
        begin
          CefStringFree(exception);
          exception^ := CefStringAlloc(TempException);
        end;
    finally
      TempRecObject := nil;
      TempValue     := nil;
    end;
end;

// TCefV8InterceptorOwn

constructor TCefV8InterceptorOwn.Create;
begin
  inherited CreateData(SizeOf(TCefV8Interceptor));

  with PCefV8Interceptor(FData)^ do
    begin
      get_byname  := {$IFDEF FPC}@{$ENDIF}cef_v8_interceptor_get_byname;
      get_byindex := {$IFDEF FPC}@{$ENDIF}cef_v8_interceptor_get_byindex;
      set_byname  := {$IFDEF FPC}@{$ENDIF}cef_v8_interceptor_set_byname;
      set_byindex := {$IFDEF FPC}@{$ENDIF}cef_v8_interceptor_set_byindex;
    end;
end;

function TCefV8InterceptorOwn.GetByName(const name: ustring; const object_: ICefv8Value; var retval: ICefv8Value; var exception: ustring): boolean;
begin
  Result := False;
end;

function TCefV8InterceptorOwn.GetByIndex(index: integer; const object_: ICefv8Value; var retval: ICefv8Value; var exception: ustring): boolean;
begin
  Result := False;
end;

function TCefV8InterceptorOwn.SetByName(const name: ustring; const object_, value: ICefv8Value; var exception: ustring): boolean;
begin
  Result := False;
end;

function TCefV8InterceptorOwn.SetByIndex(index: integer; const object_, value: ICefv8Value; var exception: ustring): boolean;
begin
  Result := False;
end;

// TCefFastV8Interceptor

constructor TCefFastV8Interceptor.Create(const getterbyname  : TCefV8InterceptorGetterByNameProc;
                                         const setterbyname  : TCefV8InterceptorSetterByNameProc;
                                         const getterbyindex : TCefV8InterceptorGetterByIndexProc;
                                         const setterbyindex : TCefV8InterceptorSetterByIndexProc);
begin
  FGetterByName  := getterbyname;
  FSetterByName  := setterbyname;
  FGetterByIndex := getterbyindex;
  FSetterByIndex := setterbyindex;
end;

function TCefFastV8Interceptor.GetByName(const name: ustring; const object_: ICefv8Value; var retval: ICefv8Value; var exception: ustring): boolean;
begin
  if assigned(FGetterByName) then
    Result := FGetterByName(name, object_, retval, exception)
   else
    Result := False;
end;

function TCefFastV8Interceptor.GetByIndex(index: integer; const object_: ICefv8Value; var retval: ICefv8Value; var exception: ustring): boolean;
begin
  if assigned(FGetterByIndex) then
    Result := FGetterByIndex(index, object_, retval, exception)
   else
    Result := False;
end;

function TCefFastV8Interceptor.SetByName(const name: ustring; const object_, value: ICefv8Value; var exception: ustring): boolean;
begin
  if assigned(FSetterByName) then
    Result := FSetterByName(name, object_, value, exception)
   else
    Result := False;
end;

function TCefFastV8Interceptor.SetByIndex(index: integer; const object_, value: ICefv8Value; var exception: ustring): boolean;
begin
  if assigned(FSetterByIndex) then
    Result := FSetterByIndex(index, object_, value, exception)
   else
    Result := False;
end;

end.
