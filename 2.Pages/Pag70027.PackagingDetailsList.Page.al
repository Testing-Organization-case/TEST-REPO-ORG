page 70027 "Packaging Details List"
{
    CardPageID = "Packaging Details Card";
    PageType = List;
    SourceTable = "Details Packaging Info.";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                ShowCaption = false;
                field("Tracking No."; Rec."Tracking No.")
                {
                }
                field("Packaging Reference No."; Rec."Packaging Reference No.")
                {
                }
                field("Packaging Type"; Rec."Packaging Type")
                {
                }
                field(Length; Rec.Length)
                {
                }
                field(Width; Rec.Width)
                {
                }
                field(Height; Rec.Height)
                {
                }
                field("Total Width"; Rec."Total Width")
                {
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                }
                field("Shipping Notes"; Rec."Shipping Notes")
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
                field("Document No."; Rec."Document No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

