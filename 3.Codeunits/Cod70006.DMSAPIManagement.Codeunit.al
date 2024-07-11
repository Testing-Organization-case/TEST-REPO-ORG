codeunit 70006 "DMS - API Management"
{

    trigger OnRun()
    begin
    end;

    [Scope('OnPrem')]
    procedure GetWebServicePort(): Text
    var
        //_XmlDoc: Automation;
        // _XmlDocNode: Automation;
        // _XmlDocNodeList: Automation;
        // _ClientConfigFileNameWithPath: Text;
        WebServicePortL: Text;
    begin
     
  

        //if Clear(_XmlDoc) then
            // if not Create(_XmlDoc, false, true) then //false, false � onserver and reuse
            //     Error('Cannot Create XML service (Error in GetNavDbServerAndDbName (�))');

        // _XmlDoc.load(ApplicationPath + 'Microsoft.Dynamics.Nav.Server.exe.config');

        // _XmlDocNode :=
        // _XmlDoc.selectSingleNode('//configuration/appSettings');

        //check if XmlDoc was found � if not path to single node cannot be found
        // if Clear(_XmlDocNode) then
            // Error('Cannot Find Server Exe Config file (Error in GetNavDbServerAndDbName (�))');

        //�CustomSettings.config�;
        // _ClientConfigFileNameWithPath := _XmlDocNode.attributes.item(0).text;

        //check if path is local (like std. or full)
        // if StrPos(_ClientConfigFileNameWithPath, '') = 0 then
        //     _ClientConfigFileNameWithPath := ApplicationPath + _ClientConfigFileNameWithPath;

        // _XmlDoc.load(_ClientConfigFileNameWithPath);




        // if Clear(_XmlDocNode) then
            // if not Create(_XmlDocNode, false, true) then //false, false � onserver and reuse
            //     Error('Cannot Create XML service (Error in GetNavDbServerAndDbName (�))');

        // _XmlDocNodeList := _XmlDoc.selectNodes('//appSettings/add');



        // _XmlDocNode := _XmlDocNodeList.item(13);
        // if Clear(_XmlDocNode) then
        //     Error('Cannot Find Server Exe Config file (Error in GetNavDbServerAndDbName (�))');


        // WebServicePortL := _XmlDocNode.attributes.item(1).text;

        exit(WebServicePortL);
    end;

    [Scope('OnPrem')]
    procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        while StrPos(String, FindWhat) > 0 do
            String := DelStr(String, StrPos(String, FindWhat)) + ReplaceWith + CopyStr(String, StrPos(String, FindWhat) + StrLen(FindWhat));
        NewString := String;
    end;

    [Scope('OnPrem')]
    procedure TextToBase64String(Value: Text) ReturnValue: Text
    var
        BinaryValue: Text;
        Length: Integer;
    begin

        Length := StrLen(Value);
        BinaryValue := TextToBinary(Value, 8);
        ReturnValue := ConvertBinaryValueToBase64String(BinaryValue, Length);
    end;

    [Scope('OnPrem')]
    procedure StreamToBase64String(Value: InStream) ReturnValue: Text
    var
        SingleByte: Char;
        BinaryValue: Text;
        Length: Integer;
    begin

        while not Value.EOS do begin
            Value.Read(SingleByte, 1);
            Length += 1;
            BinaryValue += ByteToBinary(SingleByte, 8);

        end;

        ReturnValue := ConvertBinaryValueToBase64String(BinaryValue, Length);
    end;

    [Scope('OnPrem')]
    procedure FromBase64StringToText(Value: Text) ReturnValue: Text
    var
        BinaryValue: Text;
    begin

        BinaryValue := ConvertBase64StringToBinaryValue(Value);
        ReturnValue := BinaryToText(BinaryValue);
    end;

    [Scope('OnPrem')]
    procedure FromBase64StringToStream(Value: Text; var ReturnValue: OutStream)
    var
        BinaryValue: Text;
    begin

        BinaryValue := ConvertBase64StringToBinaryValue(Value);
        BinaryToStream(BinaryValue, ReturnValue);
    end;

    local procedure ConvertBinaryValueToBase64String(Value: Text; Length: Integer) ReturnValue: Text
    var
        Length2: Integer;
        PaddingCount: Integer;
        BlockCount: Integer;
        Pos: Integer;
        CurrentByte: Text;
        i: Integer;
    begin

        if Length mod 3 = 0 then begin

            PaddingCount := 0;
            BlockCount := Length / 3;

        end
        else begin

            PaddingCount := 3 - (Length mod 3);
            BlockCount := (Length + PaddingCount) / 3;

        end;

        Length2 := Length + PaddingCount;
        Value := PadStr(Value, Length2 * 8, '0');

        // Loop through bytes in groups of 6 bits
        Pos := 1;
        while Pos < Length2 * 8 do begin
            CurrentByte := CopyStr(Value, Pos, 6);
            ReturnValue += GetBase64Char(BinaryToInt(CurrentByte));
            Pos += 6;
        end;

        // Replace last characters with '='
        for i := 1 to PaddingCount do begin
            Pos := StrLen(ReturnValue) - i + 1;
            ReturnValue[Pos] := '=';
        end;
    end;

    local procedure ConvertBase64StringToBinaryValue(Value: Text) ReturnValue: Text
    var
        BinaryValue: Text;
        i: Integer;
        IntValue: Integer;
        PaddingCount: Integer;
    begin

        for i := 1 to StrLen(Value) do begin
            if Value[i] = '=' then
                PaddingCount += 1;

            IntValue := GetBase64Number(Format(Value[i]));
            BinaryValue += IncreaseStringLength(IntToBinary(IntValue), 6);

        end;

        for i := 1 to PaddingCount do
            BinaryValue := CopyStr(BinaryValue, 1, StrLen(BinaryValue) - 8);

        ReturnValue := BinaryValue;
    end;

    local procedure TextToBinary(Value: Text; ByteLength: Integer) ReturnValue: Text
    var
        IntValue: Integer;
        i: Integer;
        BinaryValue: Text;
    begin

        for i := 1 to StrLen(Value) do begin

            IntValue := Value[i];
            BinaryValue := IntToBinary(IntValue);
            BinaryValue := IncreaseStringLength(BinaryValue, ByteLength);
            ReturnValue += BinaryValue;

        end;
    end;

    local procedure BinaryToText(Value: Text) ReturnValue: Text
    var
        Buffer: BigText;
        Pos: Integer;
        SingleByte: Text;
        CharValue: Text;
    begin

        Buffer.AddText(Value);

        Pos := 1;
        while Pos < Buffer.Length do begin
            Buffer.GetSubText(SingleByte, Pos, 8);
            CharValue[1] := BinaryToInt(SingleByte);
            ReturnValue += CharValue;
            Pos += 8;
        end;
    end;

    local procedure BinaryToStream(Value: Text; var ReturnValue: OutStream)
    var
        Buffer: BigText;
        Pos: Integer;
        SingleByte: Text;
        ByteValue: Char;
    begin

        Buffer.AddText(Value);

        Pos := 1;
        while Pos < Buffer.Length do begin
            Buffer.GetSubText(SingleByte, Pos, 8);
            ByteValue := BinaryToInt(SingleByte);
            ReturnValue.Write(ByteValue, 1);
            Pos += 8;
        end;
    end;

    local procedure ByteToBinary(Value: Char; ByteLength: Integer) ReturnValue: Text
    var
        BinaryValue: Text;
    begin

        BinaryValue := IntToBinary(Value);
        BinaryValue := IncreaseStringLength(BinaryValue, ByteLength);
        ReturnValue := BinaryValue;
    end;

    local procedure IntToBinary(Value: Integer) ReturnValue: Text
    begin

        while Value >= 1 do begin

            ReturnValue := Format(Value mod 2) + ReturnValue;
            Value := Value div 2;

        end;
    end;

    local procedure BinaryToInt(Value: Text) ReturnValue: Integer
    var
        Multiplier: BigInteger;
        IntValue: Integer;
        i: Integer;
    begin

        Multiplier := 1;
        for i := StrLen(Value) downto 1 do begin
            Evaluate(IntValue, CopyStr(Value, i, 1));
            ReturnValue += IntValue * Multiplier;
            Multiplier *= 2;
        end;
    end;

    local procedure IncreaseStringLength(Value: Text; ToLength: Integer) ReturnValue: Text
    var
        ExtraLength: Integer;
        ExtraText: Text;
    begin

        ExtraLength := ToLength - StrLen(Value);

        if ExtraLength < 0 then
            exit;

        ExtraText := PadStr(ExtraText, ExtraLength, '0');
        ReturnValue := ExtraText + Value;
    end;

    local procedure GetBase64Char(Value: Integer): Text
    var
        chars: Text;
        i: Integer;
    begin

        chars := Base64Chars;
        exit(Format(chars[Value + 1]));
    end;

    local procedure GetBase64Number(Value: Text): Integer
    var
        chars: Text;
    begin

        if Value = '=' then
            exit(0);

        chars := Base64Chars;
        exit(StrPos(chars, Value) - 1);
    end;

    local procedure Base64Chars(): Text
    begin

        exit('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/');
    end;
}

