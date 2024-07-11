pageextension 70152 "LSCRetailTransferOrder ListExt" extends "LSC Retail Transfer Order List"
{
    actions
    {
        addafter("&Card")
        {
            action("Page Attributes")
            {
                Caption = 'Attributes';
                Image = Category;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
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

        addafter("&Print")
        {
            action(MultiSelectRelease)
            {
                ApplicationArea = Location;
                Image = ReleaseDoc;
                Caption = 'MultiSelectRelease';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //ModidiedBy CCW (22Feb2022)
                    TransferHeader.RESET;
                    TransferHeader.SETRANGE("No.", Rec."No.");
                    CurrPage.SETSELECTIONFILTER(TransferHeader);
                    IF TransferHeader.FINDFIRST THEN
                        REPEAT
                            IF TransferHeader.Status = TransferHeader.Status::Open THEN BEGIN

                                ReleaseTransferDoc.RUN(TransferHeader);


                            END;
                        UNTIL TransferHeader.NEXT = 0;
                end;
            }
        }
        addafter("&Print")
        {
            action(MultiSelectReopen)
            {
                ApplicationArea = Location;
                Image = ReOpen;
                Caption = 'MultiSelectReopen';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //ModidiedBy CCW (22Feb2022)
                    TransferHeader.RESET;
                    TransferHeader.SETRANGE("No.", Rec."No.");
                    CurrPage.SETSELECTIONFILTER(TransferHeader);
                    IF TransferHeader.FINDFIRST THEN
                        REPEAT
                            IF TransferHeader.Status = TransferHeader.Status::Released THEN BEGIN

                                ReleaseTransferDoc.Reopen(TransferHeader);

                            END;
                        UNTIL TransferHeader.NEXT = 0;
                end;
            }

        }
    }
    var
        TransferHeader: Record "Transfer Header";
        ReleaseTransferDoc: Codeunit "Release Transfer Document";
}
