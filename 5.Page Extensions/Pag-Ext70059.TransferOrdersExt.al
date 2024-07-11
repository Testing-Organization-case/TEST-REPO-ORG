pageextension 70059 TransferOrdersExt extends "Transfer Orders"
{
    layout
    {
        addafter("Receipt Date")
        {
            field("Transfer From"; Rec."Transfer From")
            {
                ApplicationArea = All;
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter(Release)
        {
            action(MultiSelectRelease)
            {
                ApplicationArea = Location;
                Image = ReleaseDoc;
                Caption = 'MultiSelectRelease';
                Promoted = true;
                PromotedCategory = Category4;

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
        addafter("Reo&pen")
        {
            action(MultiSelectReopen)
            {
                ApplicationArea = Location;
                Image = ReOpen;
                Caption = 'MultiSelectReopen';
                Promoted = true;
                PromotedCategory = Category4;

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

        addafter(Dimensions)
        {
            action(Attributes)
            {
                //ApplicationArea = Location;
                Image = Category;
                Caption = 'Attributes';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // @22_Jun_2021_09_54_AM
                    CLEAR(TransferAttributeListL);
                    TransferAttributeListL.SetTransferDocumentNo(Rec."No.");
                    TransferAttributeListL.EDITABLE(FALSE);
                    TransferAttributeListL.RUN;
                end;
            }
        }
        addafter("Get Bin Content")
        {
            action("Transfer Lines")
            {
                ApplicationArea = All;
                Image = Line;
                RunObject = page "Transfer Lines NWMM";
            }
        }
    }

    var
        TransferHeader: Record "Transfer Header";
        ReleaseTransferDoc: Codeunit "Release Transfer Document";
        TransferAttributeListL: page TransferAttributesList;
}
