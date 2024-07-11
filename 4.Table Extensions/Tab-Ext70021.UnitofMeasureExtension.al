tableextension 70021 "Unit of Measure Extension" extends "Unit of Measure"
{
    fields
    {
        field(70000; "Weight Unit Of Measure"; Boolean)
        {
            Caption = 'Weight Unit Of Measure';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                UOM: Record "Unit of Measure";
                Text99001450: TextConst ENU = 'Only one %1 is allowed at any time';
            begin
                //LS
                IF "Weight Unit Of Measure" THEN BEGIN
                    UOM.SETRANGE("Weight Unit Of Measure", TRUE);
                    IF UOM.FIND('-') THEN
                        ERROR(STRSUBSTNO(Text99001450, TABLECAPTION))
                END;
            end;
        }
        field(70001; "POS Min. Denominator"; Decimal)
        {
            Caption = 'POS Min. Denominator';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        SystemId := CREATEGUID;
    end;
}
