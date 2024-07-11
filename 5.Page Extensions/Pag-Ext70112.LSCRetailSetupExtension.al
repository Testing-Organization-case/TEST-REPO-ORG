pageextension 70112 "LSC Retail Setup Extension" extends "LSC Retail Setup"
{
    layout
    {
        addafter("Create Items No. Series")
        {
            field("Barcode Lookup in Sales Line"; Rec."Barcode Lookup in Sales Line")
            {
                ApplicationArea = ALl;

            }

        }
    }
    actions
    {
        addafter("&Insert Default Data")
        {
            action("Default Logo")
            {
                Caption = 'Default Logo';
                ApplicationArea = ALl;
                Image = CompanyInformation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //RunObject = page "Retail Default Logo";
                RunPageOnRec = true;
            }
        }
    }
}
