pageextension 70048 "Warehouse Picks Extension" extends "Warehouse Picks"
{
    layout
    {
        addafter("Assignment Date")
        {
            field("Warehouse Shipment No."; Rec."Warehouse Shipment No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Registered Picks")
        {
            action("Multi Register Pick")
            {
                ApplicationArea = All;
                Image = RegisterPick;
                trigger OnAction()

                begin
                    IF CONFIRM('Do you want to register the Pick Document?', TRUE) THEN BEGIN
                        WarehouseActivityHeader := Rec;
                        WarehouseActivityHeader.SETFILTER("No.", Rec."No.");
                        CurrPage.SETSELECTIONFILTER(WarehouseActivityHeader);
                        IF WarehouseActivityHeader.FINDSET THEN
                            REPEAT

                                WarehouseActivityLines.RESET;
                                WarehouseActivityLines.SETFILTER("No.", WarehouseActivityHeader."No.");
                                IF WarehouseActivityLines.FINDSET THEN
                                    REPEAT

                                        RegisterActivityYesNo;

                                    UNTIL WarehouseActivityLines.NEXT = 0;
                            UNTIL WarehouseActivityHeader.NEXT = 0;
                    END;
                end;
            }
        }
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            action("PrintNWMM")
            {
                ApplicationArea = Warehouse;
                Caption = 'Print';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                begin
                    WarehouseActivityHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(WarehouseActivityHeader);
                    REPORT.RUNMODAL(70007, TRUE, FALSE, WarehouseActivityHeader);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Warehouse Shipment No.");
    end;

    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        WarehouseActivityLines: Record "Warehouse Activity Line";
        WhseActivLine: Record "Warehouse Activity Line";

    procedure RegisterActivityYesNo()
    begin
        WhseActivLine.COPY(WarehouseActivityLines);
        WhseActivLine.FILTERGROUP(3);
        WhseActivLine.SETRANGE(Breakbulk);
        WhseActivLine.FILTERGROUP(0);
        CODEUNIT.RUN(CODEUNIT::"Whse.-Act.-MultiRegister", WhseActivLine);
        Rec.RESET;
        WarehouseActivityLines.SETCURRENTKEY("Activity Type", "No.", "Sorting Sequence No.");
        Rec.FILTERGROUP(4);
        WarehouseActivityLines.SETRANGE("Activity Type", WarehouseActivityLines."Activity Type");
        WhseActivLine.SETFILTER("No.", WarehouseActivityLines."No.");
        Rec.FILTERGROUP(3);
        WhseActivLine.SETRANGE(Breakbulk, FALSE);
        Rec.FILTERGROUP(0);
        CurrPage.UPDATE(FALSE);
    end;

}
