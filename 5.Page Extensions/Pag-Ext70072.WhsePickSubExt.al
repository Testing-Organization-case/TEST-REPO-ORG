pageextension 70072 WhsePickSubExt extends "Whse. Pick Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field("Check Item"; Rec."Check Item")
            {
                ApplicationArea = All;
                StyleExpr = TextStyleL;
            }
            field("Scan Barcode"; Rec."Scan Barcode")
            {
                ApplicationArea = All;
                StyleExpr = TextStyleL;

            }
        }



        addafter(Quantity)
        {
            field(Remark; Rec.Remark)
            {
                ApplicationArea = All;
                StyleExpr = TextStyleL;
            }
        }

        addafter("Assemble to Order")
        {
            field("Packaging Info"; Rec."Packaging Info")
            {
                ApplicationArea = All;
                StyleExpr = TextStyleL;
            }
            field(Size; Rec.Size)
            {
                ApplicationArea = All;
                StyleExpr = TextStyleL;
            }
        }
        modify("Item No.")
        {
            StyleExpr = TextStyleL;
        }
        modify("Action Type")
        {
            StyleExpr = TextStyleL;
        }
        modify("Source Document")
        {
            StyleExpr = TextStyleL;
        }
        modify("Source No.")
        {
            StyleExpr = TextStyleL;
        }
        modify("Variant Code")
        {
            StyleExpr = TextStyleL;
        }
        modify(Description)
        {
            StyleExpr = TextStyleL;
        }
        modify("Serial No.")
        {
            StyleExpr = TextStyleL;
        }
        modify("Lot No.")
        {
            StyleExpr = TextStyleL;
        }
        modify("Package No.")
        {
            StyleExpr = TextStyleL;
        }
        modify("Expiration Date")
        {
            StyleExpr = TextStyleL;
        }
        modify("Location Code")
        {
            StyleExpr = TextStyleL;
        }
        modify("Zone Code")
        {
            StyleExpr = TextStyleL;
        }
        modify("Bin Code")
        {
            StyleExpr = TextStyleL;
        }
        modify("Shelf No.")
        {
            StyleExpr = TextStyleL;
        }
        modify(Quantity)
        {
            StyleExpr = TextStyleL;
        }
        modify("Qty. (Base)")
        {
            StyleExpr = TextStyleL;
        }
        modify("Qty. to Handle")
        {
            StyleExpr = TextStyleL;
        }
        modify("Qty. Handled")
        {
            StyleExpr = TextStyleL;
        }
        modify("Qty. to Handle (Base)")
        {
            StyleExpr = TextStyleL;
        }
        modify("Qty. Outstanding")
        {
            StyleExpr = TextStyleL;
        }
        modify("Qty. Outstanding (Base)")
        {
            StyleExpr = TextStyleL;
        }
        modify("Due Date")
        {
            StyleExpr = TextStyleL;
        }
        modify("Unit of Measure Code")
        {
            StyleExpr = TextStyleL;
        }
        modify("Qty. per Unit of Measure")
        {
            StyleExpr = TextStyleL;
        }
        modify("Destination Type")
        {
            StyleExpr = TextStyleL;
        }
        modify("Destination No.")
        {
            StyleExpr = TextStyleL;
        }
        modify("Whse. Document Type")
        {
            StyleExpr = TextStyleL;
        }
        modify("Whse. Document No.")
        {
            StyleExpr = TextStyleL;
        }
        modify("Whse. Document Line No.")
        {
            StyleExpr = TextStyleL;
        }
        modify("Special Equipment Code")
        {
            StyleExpr = TextStyleL;
        }
        modify("Assemble to Order")
        {
            StyleExpr = TextStyleL;
        }

    }

    trigger OnAfterGetRecord()

    begin
        GetPackAndSize();


        TextStyleL := 'FALSE';

        IF Rec."Check Item" = TRUE THEN
            TextStyleL := 'Favorable';

    end;

    local procedure GetPackAndSize()
    var
        ItemTable: Record Item;
    begin
        Itemtable.RESET();
        Itemtable.SETRANGE("No.", Rec."Item No.");
        IF Itemtable.FINDFIRST THEN BEGIN
            Rec."Packaging Info" := Itemtable."Packaging Info";
            Rec.Size := Itemtable.Size;
        END

    end;

    var
        TextStyleL: Text;
}
