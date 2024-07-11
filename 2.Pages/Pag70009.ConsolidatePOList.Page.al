page 70009 "Consolidate PO List"
{
    CardPageID = "Consolidate Purchase Order";
    PageType = List;
    SourceTable = "Consolidate Purchase Header";
    ApplicationArea = ALl;
    UsageCategory = Lists;
    Caption = 'Consolidate Purchase Order';

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
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        ConPOLine.Reset;
        ConPOLine.SetRange("Document No.", Rec."No.");
        if ConPOLine.FindSet then
            repeat
                ConPOLine.DeleteAll;
            until ConPOLine.Next = 0;

        ConPODetailLines.Reset;
        ConPODetailLines.SetRange("Document No.", Rec."No.");
        if ConPODetailLines.FindSet then
            repeat
                ConPODetailLines.DeleteAll;
            until ConPODetailLines.Next = 0;

        PurchHeader.Reset;
        //PurchHeader.SETRANGE("CPO Confirm",TRUE);
        PurchHeader.SetRange("CPO No.", Rec."No.");
        if PurchHeader.FindSet then
            repeat
                PurchHeader."CPO Confirm" := false;
                PurchHeader."CPO No." := '';
                PurchHeader.Modify(true);
            until PurchHeader.Next = 0;
    end;

    var
        ConPOLine: Record "Consolidate Purchase Line";
        ConPODetailLines: Record "Consolidate PO Detail Line";
        PurchHeader: Record "Purchase Header";
}

