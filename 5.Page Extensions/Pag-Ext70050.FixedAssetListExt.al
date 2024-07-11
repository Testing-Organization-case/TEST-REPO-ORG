pageextension 70050 FixedAssetListExt extends "Fixed Asset List"
{
    layout{
        addafter(Acquired)
        {
            field("Disposal Of";Rec."Disposal Of")
            {
                ApplicationArea = All;

            }
        }


    }

    trigger OnAfterGetRecord()
    var
        FADepreciatioinBookR: Record "FA Depreciation Book";
    begin

        FADepreciatioinBookR.RESET;
        FADepreciatioinBookR.SETRANGE("FA No.",Rec."No.");
        IF FADepreciatioinBookR.FINDFIRST THEN BEGIN
        Rec."Disposal Of" := FADepreciatioinBookR."Disposal Date" > 0D;
        END;
        
    end;       


}
