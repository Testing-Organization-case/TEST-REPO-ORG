page 70030 "Posted CPO Header"
{
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Posted CPO Header";
    Caption = 'Posted Consolidate Purch. Order';
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Caption = 'Created Date';
                    Editable = true;
                    Visible = true;
                }
                field("Consolidate Starting Date"; Rec."Consolidate Starting Date")
                {
                }
                field("Consolidate Ending Date"; Rec."Consolidate Ending Date")
                {

                    trigger OnValidate()
                    begin
                        if Rec."Consolidate Starting Date" = 0D then begin
                            Error('Please select Starting Date first!');
                        end;

                        //EndDateValidate;
                    end;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ShowMandatory = true;
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                }
                field("Invoice Discount %"; Rec."Invoice Discount %")
                {
                }
                field("0% Invoice Discount"; Rec."0% Invoice Discount")
                {
                }
                field(CommentTextG; CommentTextG)
                {
                    Caption = 'Comment';
                    ColumnSpan = 2;
                    Editable = false;
                    MultiLine = true;
                    RowSpan = 10;
                }
            }
            part(Control10014512; "Posted CPO Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Vendor No." = FIELD("Vendor No.");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ShowCommentBlobText;
    end;

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
        PurchHeader.SetRange("CPO Confirm", true);
        PurchHeader.SetRange("CPO No.", Rec."No.");
        if PurchHeader.FindSet then
            repeat
                PurchHeader."CPO Confirm" := false;
                PurchHeader."CPO No." := '';
                PurchHeader.Modify(true);
            until PurchHeader.Next = 0;
    end;

    var
        CommentTextG: Text;
        ConPODetailLines: Record "Consolidate PO Detail Line";
        ConPOLine: Record "Posted CPO Lines";
        PurchHeader: Record "Purchase Header";
        PostedCPONoG: Code[20];

    [ServiceEnabled]
    procedure GetParamComment(CommentText: Text; PostedCPONo: Code[20])
    var
        PostedCPOHeader: Record "Posted CPO Header";
        InStr: InStream;
        BinaryReader: DotNet BinaryReader;
        BinaryWriter: DotNet BinaryWriter;
        Encoding: DotNet Encoding;
        MyText: Text;
        InputLongTextTest: Page InputLongTextTest;
        NewText: Text;
        OutStr: OutStream;
    begin
        //CommentTextG := CommentText;
        PostedCPOHeader.SetRange("No.", PostedCPONo);
        if PostedCPOHeader.FindFirst then begin
            Clear(Rec.Comment);
            PostedCPOHeader.Comment.CreateOutStream(OutStr);
            BinaryWriter := BinaryWriter.BinaryWriter(OutStr, Encoding.UTF8);
            BinaryWriter.Write(CommentText);
            BinaryWriter.Close;
            //MODIFY;
            PostedCPOHeader.Modify(true);
        end;
    end;

    local procedure ShowCommentBlobText()
    var
        InStr: InStream;

        BinaryReader: DotNet BinaryReader;
        BinaryWriter: DotNet BinaryWriter;
        Encoding: DotNet Encoding;
        MyTextL: Text;
        InputLongTextTest: Page InputLongTextTest;
        NewText: Text;
        OutStr: OutStream;
    begin

        CommentTextG := '';
        // @18_May_2021_03_32_PM
        Rec.CalcFields(Comment);
        Rec.Comment.CreateInStream(InStr);
        BinaryReader := BinaryReader.BinaryReader(InStr, Encoding.UTF8);
        if not IsNull(BinaryReader) then begin   //read value from BLOB field
            if BinaryReader.BaseStream.Length > 0 then
                MyTextL := BinaryReader.ReadString;
            BinaryReader.Close;
        end;

        CommentTextG := MyTextL;
    end;
}

