pageextension 70015 PurchOrderExt extends "Purchase Order"          //Create By MK
{
    layout
    {
        addafter("Due Date")
        {
            field("FOC PO No."; Rec."FOC PO No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Queue Status")
        {
            field("CPO No."; Rec."CPO No.")
            {
                ApplicationArea = All;
            }
            field("CPO Confirm"; Rec."CPO Confirm")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(DocAttach)
        {
            action(NAVAttributes)
            {
                Caption = 'Attributes';
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    PurchaseAttributeListL: Page PurchaseAttributesList;
                begin
                    // @22_Jun_2021_02_09_PM
                    CLEAR(PurchaseAttributeListL);
                    PurchaseAttributeListL.SetPurchaseDocumentNo(Rec."No.");
                    PurchaseAttributeListL.RUN;
                end;
            }
        }
        modify(Release)
        {
            trigger OnAfterAction()
            var
                PurchLine: Record "Purchase Line";
            begin
                PurchLine.RESET;
                PurchLine.SETRANGE("Document No.", Rec."No.");
                IF PurchLine.FINDSET THEN
                    REPEAT
                        PurchLine."PO Status" := Rec.Status;
                        //  MESSAGE('%1',rec.Status);
                        PurchLine.MODIFY;
                    UNTIL PurchLine.NEXT = 0;
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            begin
                IF Rec."LSC Retail Status" = Rec."LSC Retail Status"::Sent THEN BEGIN
                    Rec."LSC Retail Status" := Rec."LSC Retail Status"::New;
                END;
            end;
        }
        modify("&Print")
        {
            Visible = false;

        }
        addbefore(AttachAsPDF)
        {
            action(PrintNWMM)
            {
                Caption = 'Print';
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                //Ellipsis = true;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader := Rec;
                    PurchaseHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(70014, TRUE, FALSE, PurchaseHeader);

                end;
            }
        }

    }

}
