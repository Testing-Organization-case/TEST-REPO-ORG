page 70032 "Posted CPO List"
{
    CardPageID = "Posted CPO Header";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Posted CPO Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Posted Consolidated Purchase Orders';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("FOC PO No."; Rec."FOC PO No.")
                {
                }
                field("Consolidate Starting Date"; Rec."Consolidate Starting Date")
                {
                }
                field("Consolidate Ending Date"; Rec."Consolidate Ending Date")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Total Discount Amount"; Rec."Total Discount Amount")
                {
                }
                field("Total Line Amount Excl. VAT"; Rec."Total Line Amount Excl. VAT")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Invoice Discount %"; Rec."Invoice Discount %")
                {
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                }
            }
        }
    }

    actions
    {
    }
}

