pageextension 70057 TransferOrderExt extends "Transfer Order"
{
    layout
    {
        addafter(Status)
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Dimensions)
        {
            action(Attributes)
            {
                trigger OnAction()
                var
                    TransferAttributeListL: Page TransferAttributesList;
                begin
                    // @22_Jun_2021_09_54_AM
                    CLEAR(TransferAttributeListL);
                    TransferAttributeListL.SetTransferDocumentNo(Rec."No.");
                    TransferAttributeListL.EDITABLE(FALSE);
                    TransferAttributeListL.RUN;
                end;

            }
        }
    }
}
