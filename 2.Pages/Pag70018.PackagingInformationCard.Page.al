page 70018 "Packaging Information Card"
{
    SourceTable = "Packaging Information";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    Enabled = false;
                }
                field("Packaging Ref No."; Rec."Packaging Ref No.")
                {
                }
                field("Packaging Type"; Rec."Packaging Type")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Reason Code"; Rec."Reason Code")
                {
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'WHS Document No';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

