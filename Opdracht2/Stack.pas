unit Stack;

interface

uses SysUtils;

const MaxStackSize = 128;

type
  StackElement = Char;
  TStack = class
  private
    CurrentIndex: 0..MaxStackSize;
    Stack: array[0..MaxStackSize] of StackElement;
  public
    procedure Instantiate;
    procedure Push (Element: StackElement);
    procedure Clear;
    function Pop: StackElement;
    function Peek: StackElement;
    function IsFull: Boolean;
    function IsEmpty: Boolean;
  end;

implementation

procedure TStack.Push (Element: StackElement);
begin
  if IsFull then
    raise Exception.Create('Reached maximum stack size.');
  Stack[CurrentIndex] := Element;
  Inc(CurrentIndex);
end;

function TStack.Pop: StackElement;
begin
  if IsEmpty then
    raise Exception.Create('Stack contains no elements.');
  Dec(CurrentIndex);
  Result := Stack[CurrentIndex];
end;

function TStack.Peek: StackElement;
begin
  if IsEmpty then
    raise Exception.Create('Stack contains no elements.');
  Result := Stack[CurrentIndex - 1];
end;

procedure TStack.Clear;
begin
  CurrentIndex := 0;
end;

function TStack.IsFull: Boolean;
begin
  Result := (CurrentIndex + 1 = MaxStackSize);
end;

function TStack.IsEmpty: Boolean;
begin
  Result := (CurrentIndex = 0);
end;

procedure TStack.Instantiate;
begin
  Clear;
end;

end.
