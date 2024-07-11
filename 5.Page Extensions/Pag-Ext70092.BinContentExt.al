pageextension 70092 BinContentExt extends "Bin Content"
{
    layout
    {

        addafter("Item No.")
        {
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;
            }
        }

        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                ItemDescription := '';
                ItemR.RESET;
                ItemR.SETRANGE("No.", Rec."Item No.");
                IF ItemR.FINDFIRST THEN
                    ItemDescription := ItemR.Description
                ELSE
                    ItemDescription := '';
            end;
        }

        // 
    }

    trigger OnAfterGetRecord()
    begin
        ItemDescription := '';
        ItemR.RESET;
        ItemR.SETRANGE("No.", Rec."Item No.");
        IF ItemR.FINDFIRST THEN BEGIN
            ItemDescription := ItemR.Description;
        END;


    end;

    var
        ItemDescription: Text;
        ItemR: Record Item;
}
