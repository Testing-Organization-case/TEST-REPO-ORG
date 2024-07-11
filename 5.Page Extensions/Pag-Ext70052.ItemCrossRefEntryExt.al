pageextension 70052 ItemRefEntryExt extends "Item Reference Entries"
{
    layout
    {
        addafter("Reference Type No.")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }

        addafter("Reference No.")
        {
            field("Item No."; Rec."Item No.")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    Rec.CALCFIELDS(Rec."Item Description");
                end;
            }
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;
            }
        }

        modify("Reference Type No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.CALCFIELDS(Rec."Vendor Name");
            end;
        }


    }
}
