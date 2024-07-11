page 70029 "PostPackaging info Subpage"
{
    PageType = ListPart;
    SourceTable = "Packaging Information";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Control10014501)
            {
                Enabled = false;
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
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
                field("Document No."; Rec."Document No.")
                {
                }
            }
        }
    }

    actions
    {
    }

    //[Scope('Internal')]
    procedure RunReport()
    var
        PackagingInformation: Record "Packaging Information";
        //BarcodeR: Record Barcodes;
        ReportCount: Integer;
        OldPackagingInfo: Record "Packaging Information";
    begin

        PackagingInformation.Reset;
        PackagingInformation.SetRange("Document No.", Rec."Document No.");
        //PackagingInformation.SETRANGE("Packaging Ref No.",Rec."Packaging Ref No.");
        //CurrPage.SETSELECTIONFILTER(PackagingInformation);
        REPORT.RunModal(REPORT::"Label Printing for PostPckg.", true, false, PackagingInformation);

        CurrPage.Update;
    end;
}

