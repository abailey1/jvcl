{******************************************************************************}
{* WARNING:  JEDI VCL To CLX Converter generated unit.                        *}
{*           Manual modifications will be lost on next release.               *}
{******************************************************************************}

{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvExCheckLst.pas, released on 2004-01-04

The Initial Developer of the Original Code is Andreas Hausladen [Andreas dott Hausladen att gmx dott de]
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id$

unit JvQExCheckLst;

{$I jvcl.inc}
{MACROINCLUDE JvExControls.macros}

{*****************************************************************************
 * WARNING: Do not edit this file.
 * This file is autogenerated from the source in devtools/JvExVCL/src.
 * If you do it despite this warning your changes will be discarded by the next
 * update of this file. Do your changes in the template files.
 ****************************************************************************}

interface

uses 
  QGraphics, QControls, QForms, QCheckLst, 
  Types, Qt, QWindows, QMessages,
  Classes, SysUtils,
  JvQTypes, JvQThemes, JVCLXVer, JvQExControls;



 {$IF not declared(PatchedVCLX)}
  {$DEFINE NeedMouseEnterLeave}
 {$IFEND}


type
  TJvExCheckListBox = class(TCheckListBox, IJvWinControlEvents, IJvControlEvents, IPerformControl)  
  // IJvControlEvents
  public
    function Perform(Msg: Cardinal; WParam, LParam: Longint): Longint;
    function IsRightToLeft: Boolean;
  protected
    WindowProc: TClxWindowProc;
    procedure WndProc(var Msg: TMessage); virtual;
    procedure MouseEnter(Control: TControl); override;
    procedure MouseLeave(Control: TControl); override;
    procedure ParentColorChanged; override;
  private
//    InternalFontChanged: TNotifyEvent;
    FFontHeight: integer;
    procedure OnFontChanged(Sender: TObject);
  protected
    procedure BoundsChanged; override;
    procedure DoFontChanged(Sender: TObject); dynamic;
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    function NeedKey(Key: Integer; Shift: TShiftState;
      const KeyText: WideString): Boolean; override;
    procedure Painting(Sender: QObjectH; EventRegion: QRegionH); override;
    procedure PaintWindow(PaintDevice: QPaintDeviceH);
    function WidgetFlags: integer; override;
    procedure CreateWnd; dynamic;
    procedure CreateWidget; override;
    procedure RecreateWnd;
  public
    procedure PaintTo(PaintDevice: QPaintDeviceH; X, Y: integer); 
  private
    FHintColor: TColor;
    FSavedHintColor: TColor;
    FMouseOver: Boolean;
    FOnParentColorChanged: TNotifyEvent;
  {$IFDEF NeedMouseEnterLeave}
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
  protected
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  {$ENDIF NeedMouseEnterLeave}
  protected
    procedure CMFocusChanged(var Msg: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure DoFocusChanged(Control: TWinControl); dynamic;
    property MouseOver: Boolean read FMouseOver write FMouseOver;
    property HintColor: TColor read FHintColor write FHintColor default clInfoBk;
    property OnParentColorChange: TNotifyEvent read FOnParentColorChanged write FOnParentColorChanged;
  private  
    FAboutJVCLX: TJVCLAboutInfo;
  published
    property AboutJVCLX: TJVCLAboutInfo read FAboutJVCLX write FAboutJVCLX stored False; 
  protected
    procedure DoGetDlgCode(var Code: TDlgCodes); virtual;
    procedure DoSetFocus(FocusedWnd: HWND); dynamic;
    procedure DoKillFocus(FocusedWnd: HWND); dynamic;
    procedure DoBoundsChanged; dynamic;
    function DoPaintBackground(Canvas: TCanvas; Param: Integer): Boolean; virtual; 
  private
    FCanvas: TCanvas;
  protected
    procedure Paint; virtual;
    property Canvas: TCanvas read FCanvas; 
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TJvExPubCheckListBox = class(TJvExCheckListBox) 
  end;
  

implementation



procedure TJvExCheckListBox.MouseEnter(Control: TControl);
begin
  Control_MouseEnter(Self, Control, FMouseOver, FSavedHintColor, FHintColor);
  inherited MouseEnter(Control);
  {$IF not declared(PatchedVCLX)}
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
  {$IFEND}
end;

procedure TJvExCheckListBox.MouseLeave(Control: TControl);
begin
  Control_MouseLeave(Self, Control, FMouseOver, FSavedHintColor);
  inherited MouseLeave(Control);
  {$IF not declared(PatchedVCLX)}
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
  {$IFEND}
end;

procedure TJvExCheckListBox.ParentColorChanged;
begin
  inherited ParentColorChanged;
  if Assigned(FOnParentColorChanged) then
    FOnParentColorChanged(Self);
end;

function TJvExCheckListBox.Perform(Msg: Cardinal; WParam, LParam: Longint): Longint;
var
  Mesg: TMessage;
begin
  Mesg.Result := 0;
  if Self <> nil then
  begin
    Mesg.Msg := Msg;
    Mesg.WParam := WParam;
    Mesg.LParam := LParam;
    WindowProc(Mesg);
  end;
  Result := Mesg.Result;
end;

procedure TJvExCheckListBox.WndProc(var Msg: TMessage);
begin
  Dispatch(Msg);
end;

function TJvExCheckListBox.IsRightToLeft: Boolean;
begin
  Result := False;
end;
  
function TJvExCheckListBox.NeedKey(Key: Integer; Shift: TShiftState;
  const KeyText: WideString): Boolean;
begin
  Result := WidgetControl_NeedKey(Self, Key, Shift, KeyText,
    inherited NeedKey(Key, Shift, KeyText));
end;

procedure TJvExCheckListBox.OnFontChanged(Sender: TObject);
var
  FontChangedEvent: QEventH;
begin
  ParentFont := False;
  if Font.Height <> FFontHeight then
  begin
    ScalingFlags := ScalingFlags + [sfFont];
    FFontHeight := Font.Height;
  end;
  FontChangedEvent := QEvent_create(QEventType_FontChanged);
  if FontChangedEvent <> nil then
    QApplication_postEvent(Handle, FontChangedEvent);
end;

procedure TJvExCheckListBox.DoFontChanged(Sender: TObject);
begin
//  if Assigned(InternalFontChanged) then
//    InternalFontChanged(self);
  FontChanged;
end;

procedure TJvExCheckListBox.BoundsChanged;
begin
  inherited BoundsChanged;
  DoBoundsChanged;
end;

procedure TJvExCheckListBox.RecreateWnd;
begin
  RecreateWidget;
end;

procedure TJvExCheckListBox.CreateWidget;
begin
  CreateWnd;
end;

procedure TJvExCheckListBox.CreateWnd;
begin
  inherited CreateWidget;
end;

function TJvExCheckListBox.WidgetFlags: integer;
begin
  Result := inherited WidgetFlags or
    integer(WidgetFlags_WRepaintNoErase) or
    integer(WidgetFlags_WMouseNoMask);
end;

function TJvExCheckListBox.EventFilter(Sender: QObjectH; Event: QEventH): boolean;
begin
  Result := inherited EventFilter(Sender, Event);
  Result := Result or WidgetControl_EventFilter(Self, Sender, Event);
end;

procedure TJvExCheckListBox.PaintWindow(PaintDevice: QPaintDeviceH);
begin
  WidgetControl_PaintTo(self, PaintDevice, 0, 0);
end;

procedure TJvExCheckListBox.PaintTo(PaintDevice: QPaintDeviceH; X, Y: integer);
begin
  WidgetControl_PaintTo(self, PaintDevice, X, Y);
end;
  

procedure TJvExCheckListBox.CMFocusChanged(var Msg: TCMFocusChanged);
begin
  inherited;
  DoFocusChanged(Msg.Sender);
end;

procedure TJvExCheckListBox.DoFocusChanged(Control: TWinControl);
begin
end;
  
procedure TJvExCheckListBox.DoBoundsChanged;
begin
end;

procedure TJvExCheckListBox.DoGetDlgCode(var Code: TDlgCodes);
begin
end;

procedure TJvExCheckListBox.DoSetFocus(FocusedWnd: HWND);
begin
end;

procedure TJvExCheckListBox.DoKillFocus(FocusedWnd: HWND);
begin
end;

function TJvExCheckListBox.DoPaintBackground(Canvas: TCanvas; Param: Integer): Boolean;
asm
  JMP   DefaultDoPaintBackground
end;
  
constructor TJvExCheckListBox.Create(AOwner: TComponent);
begin 
  WindowProc := WndProc; 
  inherited Create(AOwner); 
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
//  InternalFontChanged := Font.OnChange;
  Font.OnChange := OnFontChanged; 
  FHintColor := Application.HintColor;
end;


procedure TJvExCheckListBox.Painting(Sender: QObjectH; EventRegion: QRegionH);
begin
  WidgetControl_Painting(Self, Canvas, EventRegion);
end;

procedure TJvExCheckListBox.Paint;
begin
  WidgetControl_DefaultPaint(self, Canvas);
end;


destructor TJvExCheckListBox.Destroy;
begin
  inherited Destroy;
end;
  

end.
