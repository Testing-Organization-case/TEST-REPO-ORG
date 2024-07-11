pageextension 70101 PostedWhseShipSubExt extends "Posted Whse. Shipment Subform"
{
    layout
    {


        addafter("Shipping Advice")
        {
            field("Packaging Info"; Rec."Packaging Info")
            {
                ApplicationArea = All;
            }
            field(Size; Rec.Size)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Bin Contents List")
        {
            action("Packaging Lines Data")
            {
                Caption = 'Packaging Lines Data';
                Image = List;
                //Promoted = true;
                //PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = page "Package No. Information List";
                //RunPageLink = "Item No." =field("Item No."),
            }
        }
    }

    trigger OnAfterGetRecord()

    begin
        GetPackAndSize();

    end;

    local procedure GetPackAndSize()
    var
        ItemTable: Record Item;
    begin
        Itemtable.RESET();
        Itemtable.SETRANGE("No.", Rec."No.");
        IF Itemtable.FINDFIRST THEN BEGIN
            Rec."Packaging Info" := Itemtable."Packaging Info";
            Rec.Size := Itemtable.Size;
        END

    end;
}
