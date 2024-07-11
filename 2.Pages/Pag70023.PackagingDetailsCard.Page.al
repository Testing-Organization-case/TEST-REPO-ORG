page 70023 "Packaging Details Card"
{
    SourceTable = "Details Packaging Info.";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Enabled = false;
                    Visible = false;
                }
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
                    MultiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    Enabled = false;
                    Visible = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Enabled = false;
                    Visible = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    Enabled = false;
                    Visible = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    Enabled = false;
                    Visible = false;
                }
            }
            part(PackagingInfo; "Packaging info Subpage")
            {
                SubPageLink = "Document No." = FIELD("Document No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Post & Print")
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        CurrPage.PackagingInfo.PAGE.RunReport;
                    end;
                }
            }
        }
    }
}

