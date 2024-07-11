pageextension 70001 CustomerListExt extends "Customer List"         //Created By MK
{
    actions
    {
        addafter("Sales Statistics")
        {
            action("Customer/Item Sales POS Report")
            {
                Caption = 'Customer/Item Sales POS Report';
                Image = Report;
                ApplicationArea = basic, Suite;
                trigger OnAction()
                begin
                    REPORT.RUNMODAL(70017, TRUE, TRUE);
                end;
            }
            action("Customer/Item Sales Order Report")
            {
                Caption = 'Customer/Item Sales Order Report';
                Image = Report;
                Promoted = false;
                trigger OnAction()
                begin
                    REPORT.RUNMODAL(70024, TRUE, TRUE);
                end;
            }
        }
    }
}
