pageextension 70038 "Apply Customer Entries Ext" extends "Apply Customer Entries"
{
    layout
    {
        addafter("Customer No.")
        {
            field("Sell-to Contact No."; Rec."Sell-to Contact No.")
            {
                ApplicationArea = All;
            }
            field("Contact Name"; gContactName)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()

    begin
        //LS -
        IF gContact.GET(Rec."Sell-to Contact No.") THEN
            gContactName := gContact.Name
        ELSE
            gContactName := '';
        // LS +
    end;

    var
        gContact: Record Contact;
        gContactName: Text[100];
}
