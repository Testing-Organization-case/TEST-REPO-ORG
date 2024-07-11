page 70019 "Packaging Information List"
{
    CardPageID = "Packaging Information Card";
    PageType = List;
    SourceTable = "Packaging Information";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                Editable = false;
                Enabled = false;
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Packaging Ref No."; Rec."Packaging Ref No.")
                {
                }
                field("Packaging Type"; Rec."Packaging Type")
                {
                }
                field("Reason Code"; Rec."Reason Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Created Date"; Rec."Created Date")
                {
                }
                field("Modified By"; Rec."Modified By")
                {
                }
                field("Modified Date"; Rec."Modified Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

