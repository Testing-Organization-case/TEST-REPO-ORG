tableextension 70026 "Item Variant Extension" extends "Item Variant"
{
    fields
    {
        field(70000; "Common Item No."; Code[20])
        {
            Caption = 'Common Item No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                lBOUtils: Codeunit "LSC BO Utils";
                lItemVariant: Record "Item Variant";
                lItem: Record Item;
                Text10014600_02: TextConst ENU = 'Common Item No. exists in Item Variant record %1 %2';
                Text10014600_01: TextConst ENU = 'Common Item No. exists in Item record %1';
            begin
                //LS -
                IF (lBOUtils.IsFranchisePermitted) AND
                  ("Common Item No." <> '') THEN BEGIN
                    lItemVariant.RESET;
                    lItemVariant.SETCURRENTKEY("Common Item No.");
                    lItemVariant.SETRANGE("Common Item No.", "Common Item No.");
                    lItemVariant.SETFILTER("Item No.", '<>%1', "Item No.");
                    lItemVariant.SETFILTER(Code, '<>%1', Code);
                    IF lItemVariant.FIND('-') THEN
                        ERROR(STRSUBSTNO(Text10014600_02, lItemVariant."Item No.", lItemVariant.Code));
                    lItem.RESET;
                    lItem.SETCURRENTKEY(lItem."Common Item No.");
                    lItem.SETRANGE("Common Item No.", "Common Item No.");
                    lItem.SETFILTER("No.", '<>%1', "Item No.");
                    IF lItem.FIND('-') THEN
                        ERROR(STRSUBSTNO(Text10014600_01, lItem."No."));
                END;
                //LS +
            end;
        }
        field(70001; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(70002; Inventory; Decimal)
        {
            Caption = 'Inventory';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."), "Location Code" = FIELD("Location Filter")));
            Editable = false;
        }
    }
}
