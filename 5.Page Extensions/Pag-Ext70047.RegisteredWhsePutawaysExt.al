pageextension 70047 "Registered Whse. Put-aways Ext" extends "Registered Whse. Put-aways"
{
    actions
    {
        addafter("Delete Registered Movements")
        {
            action("Preview - Reg. Put-Aways")
            {
                ApplicationArea = All;
                Image = TestReport;
                Promoted = true;
                trigger OnAction()
                var
                    RegisteredWhseActivHeader: Record "Registered Whse. Activity Hdr.";
                begin
                    RegisteredWhseActivHeader.SETFILTER("No.", Rec."No.");
                    REPORT.RUNMODAL(70019, TRUE, FALSE, RegisteredWhseActivHeader);
                end;
            }
        }
    }
}
