page 70059 ItemInvVarSerialLotsWksPage          //Created By MK
{
    Editable = false;
    PageType = ListPart;
    SourceTable = ItemInvVariSerialiLotsWks;

    layout
    {
        area(content)
        {
            group(Control10014511)
            {
                ShowCaption = false;
                field("Item No Filter"; Rec."Item No Filter")
                {
                }
                field("Location Code Filter"; Rec."Location Code Filter")
                {
                }
            }
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }

                field("Location Code"; Rec."Location Code")
                {
                }
                field(No; Rec.No)
                {
                }
                field("Serial No."; Rec."Serial No.")
                {
                }
                field("Item Ledger Qty"; Rec."Item Ledger Qty")
                {
                }
                field("Tran Sale Qty"; Rec."Tran Sale Qty")
                {
                }
                field("Sum Qty"; Rec."Sum Qty")
                {
                }
            }
        }
    }

    actions
    {
    }
}

