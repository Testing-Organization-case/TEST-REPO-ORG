pageextension 70056 ReferenceExt extends "Item References"
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

        addafter("Item No.")
        {

            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;
            }
        }



        modify("Reference Type No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields(Rec."Vendor Name");
            end;
        }

        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields(Rec."Item Description");
            end;
        }

    }
}
