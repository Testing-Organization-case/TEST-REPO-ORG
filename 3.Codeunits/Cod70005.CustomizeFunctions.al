codeunit 70005 CustomizeFunctions
{
    //@@@@ For LSC Barcode Management
    procedure EAN13_10String(InputBarcode: Code[20]): Text
    var
        LRSeparator: Text[3];
        CSeparator, LeftStructure : Text[6];
        Weight: Text[12];
        Structure: array[10] of Text[6];
        Encoding: array[10, 3] of Text[7];
        CurrentBarcode, EncodedBarcode : Text;
        BarcodeWithCheckSum: Code[13];
        CheckDigit, Count, NumberEval, StructureIndex : Integer;
        Text002: TextConst ENU = 'Is this a EAN13 Barcode with Price?';
    begin
        LRSeparator := '202';
        CSeparator := '02020';
        Weight := '131313131313';

        // If barcode is already with Checksum digit at the end
        IF STRLEN(InputBarcode) = 13 THEN BEGIN
            EVALUATE(CheckDigit, COPYSTR(InputBarcode, 13, 1));
            CurrentBarcode := COPYSTR(InputBarcode, 1, 12);
            //Comparing checkdigit
            IF CheckDigit <> STRCHECKSUM(CurrentBarcode, Weight, 10) THEN BEGIN
                //ERROR(Text003);
                //CurrentBarcode := '2300000000009';
            END;
        END ELSE BEGIN

            //  IF STRLEN(InputBarcode) <> 12 THEN
            //    ERROR(Text001,12);
            InputBarcode := '2300000000009';
            EVALUATE(CheckDigit, COPYSTR(InputBarcode, 13, 1));
            CurrentBarcode := COPYSTR(InputBarcode, 1, 12);
        END;

        FOR Count := 1 TO STRLEN(CurrentBarcode) DO BEGIN
            //Checking if barcode constructed only of digits
            IF NOT (CurrentBarcode[Count] IN ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']) THEN
                ERROR(Text002);
        END;

        //Initializing EAN13 structure
        InitEAN13Structure(Structure, Encoding);

        //Checkdigit again
        CheckDigit := STRCHECKSUM(CurrentBarcode, Weight, 10);

        //Barcode to encode with checksum
        BarcodeWithCheckSum := COPYSTR(CurrentBarcode, 2, STRLEN(CurrentBarcode)) + FORMAT(CheckDigit);

        //Structure to use (Left Part)
        EVALUATE(StructureIndex, FORMAT(CurrentBarcode[1]));
        StructureIndex := StructureIndex + 1;
        LeftStructure := Structure[StructureIndex];

        //Add Beginning lines
        EncodedBarcode := EncodedBarcode + LRSeparator;

        FOR Count := 1 TO STRLEN(BarcodeWithCheckSum) DO BEGIN
            //Add Middle Lines
            IF Count = 7 THEN BEGIN
                EncodedBarcode := EncodedBarcode + CSeparator;
            END;
            //Getting Barcode digit by index
            EVALUATE(NumberEval, FORMAT(BarcodeWithCheckSum[Count]));

            IF Count <= 6 THEN BEGIN
                //Left Part
                CASE LeftStructure[Count] OF
                    'L':
                        EncodedBarcode := EncodedBarcode + Encoding[NumberEval + 1] [1];
                    'G':
                        EncodedBarcode := EncodedBarcode + Encoding[NumberEval + 1] [2];
                END;
            END ELSE BEGIN
                //Right Part
                EncodedBarcode := EncodedBarcode + Encoding[NumberEval + 1] [3];
            END;

        END;

        //Ending Lines
        EncodedBarcode := EncodedBarcode + LRSeparator;

        EXIT(EncodedBarcode);
    end;

    local procedure InitEAN13Structure(VAR Structures: ARRAY[10] OF Text[6]; VAR Encodings: ARRAY[10, 3] OF Text[7])
    begin
        Structures[1] := 'LLLLLL';
        Structures[2] := 'LLGLGG';
        Structures[3] := 'LLGGLG';
        Structures[4] := 'LLGGGL';
        Structures[5] := 'LGLLGG';
        Structures[6] := 'LGGLLG';
        Structures[7] := 'LGGGLL';
        Structures[8] := 'LGLGLG';
        Structures[9] := 'LGLGGL';
        Structures[10] := 'LGGLGL';

        Encodings[1] [1] := '0001101';
        Encodings[1] [2] := '0100111';
        Encodings[1] [3] := '1110010';
        Encodings[2] [1] := '0011001';
        Encodings[2] [2] := '0110011';
        Encodings[2] [3] := '1100110';
        Encodings[3] [1] := '0010011';
        Encodings[3] [2] := '0011011';
        Encodings[3] [3] := '1101100';
        Encodings[4] [1] := '0111101';
        Encodings[4] [2] := '0100001';
        Encodings[4] [3] := '1000010';
        Encodings[5] [1] := '0100011';
        Encodings[5] [2] := '0011101';
        Encodings[5] [3] := '1011100';
        Encodings[6] [1] := '0110001';
        Encodings[6] [2] := '0111001';
        Encodings[6] [3] := '1001110';
        Encodings[7] [1] := '0101111';
        Encodings[7] [2] := '0000101';
        Encodings[7] [3] := '1010000';
        Encodings[8] [1] := '0111011';
        Encodings[8] [2] := '0010001';
        Encodings[8] [3] := '1000100';
        Encodings[9] [1] := '0110111';
        Encodings[9] [2] := '0001001';
        Encodings[9] [3] := '1001000';
        Encodings[10] [1] := '0001011';
        Encodings[10] [2] := '0010111';
        Encodings[10] [3] := '1110100';
    end;
    //@@@@ For LSC Barcode Management

    //-------------------------------------------------------------------------------------------------------------------------

    //@@@@ For SelectionFilterManagemet
    procedure GetSelectionFilterForPORecord(VAR PORecord: Record "Purchase Header"): Text
    var
        SelectionFilteMgt: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    begin
        //Message('Hello');
        RecRef.GETTABLE(PORecord);
        //Message('Hi');
        EXIT(SelectionFilteMgt.GetSelectionFilter(RecRef, PORecord.FIELDNO("No.")));

    end;


    //@@@@ For BO Utils
    procedure getLookupForm(FormNo: Integer): Integer
    var
        LookupFormNo: Integer;
    begin
        IF IsEasyRetail() THEN BEGIN
            ;
            LookupFormNo := 0;
            CASE FormNo OF
                18:
                    LookupFormNo := 10000705;
                23:
                    LookupFormNo := 10000706;
                27:
                    LookupFormNo := 99001452;
                7002:
                    LookupFormNo := 10000783;
                10000704:
                    LookupFormNo := 10000703;
            END;
        END
        ELSE BEGIN
            ;
            LookupFormNo := 0;
            CASE FormNo OF
                18:
                    LookupFormNo := 10000705;
                23:
                    LookupFormNo := 10000706;
                27:
                    LookupFormNo := 99001452;
                7002:
                    LookupFormNo := 10000783;
                10000704:
                    LookupFormNo := 10000703;
            END;
        END;

        EXIT(LookupFormNo);
    end;

    procedure IsEasyRetail(): Boolean
    begin
        exit(false);
    end;

    procedure DisplayRetailImageNwmm(RecRef_p: RecordRef)
    var
        ImageTableLink: Record "LSC Retail Image Link";
        ImageLinkPage: Page "LSC Retail Image Link List";
    begin
        RecRef_p.FILTERGROUP(2);
        ImageTableLink.SETRANGE("Record Id", FORMAT(RecRef_p.RECORDID));
        RecRef_p.FILTERGROUP(0);
        ImageTableLink.SETCURRENTKEY("Display Order");
        ImageLinkPage.SETTABLEVIEW(ImageTableLink);
        ImageLinkPage.LOOKUPMODE(TRUE);
        ImageLinkPage.RUNMODAL;

    end;
    //@@@@ For BO Utils

    // procedure GetSelectionFilterForPORecordNwmm(VAR PORecord: Record "Purchase Header"): Text
    // var
    //     RecRef: RecordRef;
    //     SelectionFilterManagement: Codeunit SelectionFilterManagement;

    // begin
    //     RecRef.GETTABLE(PORecord);
    //     EXIT(SelectionFilterManagement.GetSelectionFilter(RecRef, PORecord.FIELDNO("No."))); //Added by HMA
    // end;
    //for SelectionFilterManagement


    // procedure InsertItemAttributeValueNWMM(ItemAttributeValue: Record "Item Attribute Value"; TempItemAttributeValueSelection: Record "Item Attribute Value Selection")
    // var


    //     ValDecimal: Decimal;
    //     ValDate: Date;
    // begin
    //     CLEAR(ItemAttributeValue);
    //     ItemAttributeValue."Attribute ID" := TempItemAttributeValueSelection."Attribute ID";
    //     ItemAttributeValue.Blocked := TempItemAttributeValueSelection.Blocked;
    //     CASE TempItemAttributeValueSelection."Attribute Type" OF
    //         TempItemAttributeValueSelection."Attribute Type"::Option,
    //       TempItemAttributeValueSelection."Attribute Type"::Text:
    //             ItemAttributeValue.Value1 := TempItemAttributeValueSelection.Value1;

    //         TempItemAttributeValueSelection."Attribute Type"::Integer:
    //             ItemAttributeValue.VALIDATE(Value1, TempItemAttributeValueSelection.Value1);

    //         TempItemAttributeValueSelection."Attribute Type"::Decimal:
    //             IF TempItemAttributeValueSelection.Value1 <> '' THEN BEGIN
    //                 EVALUATE(ValDecimal, TempItemAttributeValueSelection.Value1);
    //                 ItemAttributeValue.VALIDATE(Value1, FORMAT(ValDecimal));
    //             END;
    //         TempItemAttributeValueSelection."Attribute Type"::Date:
    //             IF TempItemAttributeValueSelection.Value1 <> '' THEN BEGIN
    //                 EVALUATE(ValDate, TempItemAttributeValueSelection.Value1);
    //                 ItemAttributeValue.VALIDATE("Date Value", ValDate);
    //             END;
    //     END;

    //     ItemAttributeValue.INSERT;
    // end;
}
