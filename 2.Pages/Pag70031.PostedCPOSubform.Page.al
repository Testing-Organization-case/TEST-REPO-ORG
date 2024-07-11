page 70031 "Posted CPO Subform"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Posted CPO Lines";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    TableRelation = Vendor;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    TableRelation = Item;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }

                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    AssistEdit = true;
                    DrillDown = false;
                    Editable = false;
                    Lookup = false;

                    trigger OnAssistEdit()
                    var
                        ConPODetailLine: Record "Consolidate PO Detail Line";
                        ConPODetailPage: Page "Consign PO Detail Lines";
                        ConPODetailCardPage: Page "Consolidate Detail Card";
                    begin
                        ConPODetailLine.Reset;
                        ConPODetailLine.SetRange("Vendor No.", Rec."Vendor No.");
                        ConPODetailLine.SetRange("Item No.", Rec."Item No.");
                        ConPODetailLine.SetRange("Document Type", 'Order');
                        ConPODetailLine.SetRange("Document No.", Rec."Document No.");

                        if Rec."Item No." <> '' then begin
                            Editable := false;
                            ConPODetailCardPage.Editable(false);
                            ConPODetailCardPage.SetRecord(ConPODetailLine);
                            ConPODetailCardPage.Run;
                            //PAGE.RUN(50530,ConPODetailLine);
                        end;

                        ConPODetailLine."Document No." := Rec."Document No.";
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Direct Unit Cost Excl. VAT"; Rec."Direct Unit Cost Excl. VAT")
                {
                    Editable = false;
                }
                field("Net Cost"; Rec."Net Cost Price")
                {
                    Caption = 'Net Cost';
                    Editable = false;
                }
                field("Total Discount Amt"; Rec."Total Discount Amt")
                {
                    Editable = false;
                }
                field("Total Dis AMT"; Rec."Total Dis AMT")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line Amount Excl. VAT"; Rec."Line Amount Excl. VAT")
                {
                    Editable = false;
                }
                field("Scheme Code"; Rec."Scheme Code")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
                field("Consolidate Start Date"; Rec."Consolidate Start Date")
                {
                    Editable = false;
                }
                field("Consolidate End Date"; Rec."Consolidate End Date")
                {
                    Editable = false;
                }
                field("Retrieve Purchase Lines"; Rec."Retrieve Purchase Lines")
                {
                    Editable = false;
                }
                field(MaxQtyperUOM; Rec.MaxQtyperUOM)
                {
                    Editable = false;
                }
                field("Lock PO"; Rec."Lock PO")
                {
                }
            }
            group(Control10014505)
            {
                ShowCaption = false;
                group(Control10014504)
                {
                    ShowCaption = false;
                    field("Total Discount Amount"; Rec."Total Discount Amount")
                    {
                        Editable = false;
                    }
                }
                group(Control10014502)
                {
                    ShowCaption = false;
                    field("Total Line Amount Excl. VAT"; Rec."Total Line Amount Excl. VAT")
                    {
                        Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
    }


}

