pageextension 70119 "LSC Retail Purchase Order Ext" extends "LSC Retail Purchase Order"
{
    layout
    {
        addafter("Last Open-to-Buy Check Status")
        {
            field("Format Region"; Rec."Format Region")
            {
                ApplicationArea = All;
            }
        }
        addafter("Vendor Order No.")
        {
            field("Vendor Trade Scheme"; Rec."Vendor Trade Scheme")
            {
                ApplicationArea = All;
            }
        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                VendorTradeSchemeR: Record "Vendor Trade Scheme";
            begin
                VendorTradeSchemeR.RESET;
                VendorTradeSchemeR.SETRANGE("Vendor No.", Rec."Buy-from Vendor No.");
                VendorTradeSchemeR.SETRANGE(Active, TRUE);
                IF VendorTradeSchemeR.FINDFIRST THEN BEGIN
                    Rec."Vendor Trade Scheme" := VendorTradeSchemeR.Scheme;
                    Rec.MODIFY;
                END;
            end;
        }
    }
    actions
    {
        addafter(Dimensions)
        {
            action("Page Purchase Order List")
            {
                Caption = 'List';
                ApplicationArea = ALl;
                Image = EditLines;
                RunObject = page "Purchase Order List";
                RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
            }
            action("Page Document Group Lines")
            {
                Caption = 'Document &Groups';
                ApplicationArea = ALl;
                Image = Documents;
                RunObject = page "LSC Document Group Lines";
                RunPageLink = "Reference Type" = CONST(Purchase), "Reference No." = FIELD("No.");
            }
            action(NAVAttributes)
            {
                Caption = 'Attributes';
                ApplicationArea = ALl;
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
        addafter("Receipt Lines")
        {
            action("Create Receipt")
            {
                ApplicationArea = All;
                Caption = 'Create Receipt';
                Image = Receipt;
                trigger OnAction()
                var
                    GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                begin
                    GetSourceDocInbound.CreateFromPurchOrder(Rec);
                end;
            }
        }
        modify(Reopen)
        {
            trigger OnAfterAction()

            begin
                //Added by STH on 28Jun23 
                IF Rec."LSC Retail Status" = Rec."LSC Retail Status"::Sent THEN BEGIN
                    Rec."LSC Retail Status" := Rec."LSC Retail Status"::New;
                END;
                //Added by STH on 28Jun23 
            end;
        }


    }
}
