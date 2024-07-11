page 70010 "Consolidate Purchase Order"
{
    SourceTable = "Consolidate Purchase Header";
    ApplicationArea = ALl;
    //UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Caption = 'Created Date';
                    Editable = false;
                    Visible = true;
                }
                field("Consolidate Starting Date"; Rec."Consolidate Starting Date")
                {
                }
                field("Consolidate Ending Date"; Rec."Consolidate Ending Date")
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ShowMandatory = true;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {

                    trigger OnValidate()
                    var
                        Answer: Boolean;
                    begin
                        if Rec."Invoice Amount" = 0 then begin
                            Answer := Confirm('Do you want to apply Invoice Discount Amount into 0 for all Purchase Orders?', false, true);
                            if Answer = true then
                                Rec."0% Invoice Discount" := true
                            else
                                Rec."0% Invoice Discount" := false;
                        end else
                            Rec."0% Invoice Discount" := false;

                        if Rec."Invoice Amount" > 0 then
                            Rec."0% Invoice Discount" := false;
                        Rec."Invoice Discount %" := 0;
                    end;
                }
                field("Invoice Discount %"; rec."Invoice Discount %")
                {

                    trigger OnValidate()
                    var
                        Answer: Boolean;
                    begin
                        if Rec."Invoice Discount %" = 0 then begin
                            Answer := Confirm('Do you want to apply Invoice Discount into 0% for all Purchase Orders?', false, true);
                            if Answer = true then
                                Rec."0% Invoice Discount" := true
                            else
                                Rec."0% Invoice Discount" := false;
                        end else
                            Rec."0% Invoice Discount" := false;

                        if Rec."Invoice Discount %" > 0 then
                            Rec."Invoice Amount" := 0;
                    end;
                }
                field("0% Invoice Discount"; Rec."0% Invoice Discount")
                {
                    Editable = false;
                }
                field(CommentTextG; CommentTextG)
                {
                    Caption = 'Comment';
                    ColumnSpan = 2;
                    MultiLine = true;
                    RowSpan = 10;

                    trigger OnValidate()
                    begin
                        UpdateCommentBlobText(CommentTextG);
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = true;
                }
                field("Location Code"; Rec."Location Code")
                {
                }
            }
            part("Consolidate PO Subform"; "Consolidate PO Subform")
            {
                Caption = 'Consolidate PO Subform';
                SubPageLink = "Document No." = FIELD("No."),
                              "Vendor No." = FIELD("Vendor No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Action")
            {
                Caption = 'Action';
                action("Retrieve Purchase Lines")
                {
                    Caption = 'Retrieve Purchase Lines';
                    Enabled = false;
                    Image = Export;
                    Visible = false;

                    trigger OnAction()
                    var
                        PurchaseAttributeListL: Page PurchaseAttributesList;
                        Value: Decimal;
                        MaxValue: Code[10];
                        ConPODetailLine: Record "Consolidate PO Detail Line";
                        UOMR: Record "Unit of Measure";
                        ItemR: Record Item;
                        MyRecRef: Record "Consolidate Purchase Line";
                        MyFieldRef: Decimal;
                        LineNo: Integer;
                        LocCodeL: Code[200];
                        VDesc: Text;
                    begin

                        if Rec."Vendor No." = '' then begin
                            Error('Vendor No. must have a value!');
                        end;

                        ConPOLine.Reset;
                        ConPOLine.SetRange("Document No.", Rec."No.");
                        if ConPOLine.FindSet then
                            repeat

                            begin
                                // Rec.
                            end;

                            until ConPOLine.Next = 0;


                        LocCodeL := Rec."Location Code";
                        //MESSAGE('%1',LocCodeL);

                        //Location Code not equal to blank

                        if LocCodeL <> '' then begin
                            PurchHeader.Reset;
                            PurchHeader.SetRange("Buy-from Vendor No.", Rec."Vendor No.");
                            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                            PurchHeader.SetRange(Status, PurchHeader.Status::Open);
                            if PurchHeader.FindSet then
                                repeat
                                    if (PurchHeader."Document Date" >= Rec."Consolidate Starting Date") and (PurchHeader."Document Date" <= Rec."Consolidate Ending Date") then begin
                                        PurchLine.Reset;
                                        PurchLine.SetRange("Document No.", PurchHeader."No.");
                                        PurchLine.SetRange("Buy-from Vendor No.", PurchHeader."Buy-from Vendor No.");
                                        PurchLine.SetFilter("Location Code", LocCodeL);

                                        if PurchLine.FindSet then
                                            repeat

                                                LineNo := 1000;
                                                ConPOLine.Reset;
                                                ConPOLine.SetRange("Document No.", Rec."No.");
                                                if ConPOLine.FindLast then begin
                                                    LineNo := ConPOLine."Line No." + 1000;
                                                end;

                                                ConPOLine.Init;
                                                ConPOLine."Document No." := Rec."No.";
                                                ConPOLine."Vendor No." := Rec."Vendor No.";
                                                ConPOLine."Line No." := LineNo;
                                                ConPOLine."Item No." := PurchLine."No.";
                                                ConPOLine."Location Code" := PurchLine."Location Code";
                                                ConPOLine."Consolidate Start Date" := Rec."Consolidate Starting Date";
                                                ConPOLine."Consolidate End Date" := Rec."Consolidate Ending Date";
                                                ConPOLine."Location Code" := Rec."Location Code";
                                                ConPOLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                                                ConPOLine."Scheme Code" := PurchLine.Scheme;
                                                ConPOLine.Reset;
                                                ConPOLine.SetRange("Item No.", ConPOLine."Item No.");
                                                ConPOLine.SetRange("Document No.", ConPOLine."Document No.");
                                                ConPOLine.SetRange("Vendor No.", ConPOLine."Vendor No.");

                                                if ConPOLine.FindSet then
                                                    repeat
                                                        ConPOLine.Delete;
                                                    until ConPOLine.Next = 0;

                                                ConPOLine.Description := PurchLine.Description;
                                                ConPOLine."PO No." := PurchHeader."No.";
                                                ConPOLine."Net Cost Price" := PurchLine."Net Price";
                                                ConPOLine."Total Discount Amt" += PurchLine."Line Discount Amount";
                                                ConPOLine."Retrieve Purchase Lines" := true;
                                                ConPOLine.Insert;

                                                InsertConPOLinesLoc;

                                            until PurchLine.Next = 0;
                                    end;

                                until PurchHeader.Next = 0;

                        end
                        else
                        // Location equal to blank
                            begin
                            PurchHeader.Reset;
                            PurchHeader.SetRange("Buy-from Vendor No.", Rec."Vendor No.");
                            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                            PurchHeader.SetRange(Status, PurchHeader.Status::Open);
                            if PurchHeader.FindSet then
                                repeat
                                    if (PurchHeader."Document Date" >= Rec."Consolidate Starting Date") and (PurchHeader."Document Date" <= Rec."Consolidate Ending Date") then begin
                                        PurchLine.Reset;
                                        PurchLine.SetRange("Document No.", PurchHeader."No.");
                                        PurchLine.SetRange("Buy-from Vendor No.", PurchHeader."Buy-from Vendor No.");
                                        if PurchLine.FindSet then
                                            repeat

                                                LineNo := 1000;

                                                ConPOLine.Reset;
                                                ConPOLine.SetRange("Document No.", Rec."No.");
                                                if ConPOLine.FindLast then begin
                                                    LineNo := ConPOLine."Line No." + 1000;
                                                end;

                                                ConPOLine.Init;
                                                ConPOLine."Document No." := Rec."No.";
                                                ConPOLine."Vendor No." := Rec."Vendor No.";
                                                ConPOLine."Line No." := LineNo;
                                                ConPOLine."Item No." := PurchLine."No.";
                                                ConPOLine."Consolidate Start Date" := Rec."Consolidate Starting Date";
                                                ConPOLine."Consolidate End Date" := Rec."Consolidate Ending Date";
                                                ConPOLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                                                ConPOLine.Reset;
                                                ConPOLine.SetRange("Item No.", ConPOLine."Item No.");
                                                ConPOLine.SetRange("Document No.", ConPOLine."Document No.");
                                                ConPOLine.SetRange("Vendor No.", ConPOLine."Vendor No.");

                                                if ConPOLine.FindSet then
                                                    repeat
                                                        ConPOLine.Delete;
                                                    until ConPOLine.Next = 0;

                                                ConPOLine.Description := PurchLine.Description;
                                                ConPOLine."PO No." := PurchHeader."No.";
                                                ConPOLine."Net Cost Price" += PurchLine."Net Price";
                                                ConPOLine."Total Discount Amt" += PurchLine."Line Discount Amount";
                                                ConPOLine."Scheme Code" := PurchLine.Scheme;
                                                ConPOLine."Retrieve Purchase Lines" := true;
                                                ConPOLine.Insert;

                                                InsertConPOLines;

                                            until PurchLine.Next = 0; //IF PurchLine.FINDSET THEN

                                    end; //IF (PurchHeader."Document Date" >= Rec."Consolidate Starting Date") AND (PurchHeader."Document Date" <= Rec."Consolidate Ending Date")  THEN

                                until PurchHeader.Next = 0; //IF PurchHeader.FINDSET THEN

                        end;


                        // Date blank function

                        if (LocCodeL <> '') and (Rec."Consolidate Starting Date" = 0D) and (Rec."Consolidate Ending Date" = 0D) then begin
                            PurchHeader.Reset;
                            PurchHeader.SetRange("Buy-from Vendor No.", Rec."Vendor No.");
                            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                            PurchHeader.SetRange(Status, PurchHeader.Status::Open);
                            if PurchHeader.FindSet then
                                repeat
                                    PurchLine.Reset;
                                    PurchLine.SetRange("Document No.", PurchHeader."No.");
                                    PurchLine.SetRange("Buy-from Vendor No.", PurchHeader."Buy-from Vendor No.");
                                    PurchLine.SetFilter("Location Code", LocCodeL);
                                    if PurchLine.FindSet then
                                        repeat
                                            LineNo := 1000;
                                            ConPOLine.Reset;
                                            ConPOLine.SetRange("Document No.", Rec."No.");
                                            if ConPOLine.FindLast then begin
                                                LineNo := ConPOLine."Line No." + 1000;
                                            end;

                                            ConPOLine.Init;
                                            ConPOLine."Document No." := Rec."No.";
                                            ConPOLine."Vendor No." := Rec."Vendor No.";
                                            ConPOLine."Line No." := LineNo;
                                            ConPOLine."Item No." := PurchLine."No.";

                                            ConPOLine."Location Code" := PurchLine."Location Code";
                                            ConPOLine."Consolidate Start Date" := Rec."Consolidate Starting Date";
                                            ConPOLine."Consolidate End Date" := Rec."Consolidate Ending Date";
                                            ConPOLine."Location Code" := Rec."Location Code";
                                            ConPOLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                                            ConPOLine."Scheme Code" := PurchLine.Scheme;
                                            ConPOLine.Reset;
                                            ConPOLine.SetRange("Item No.", ConPOLine."Item No.");
                                            ConPOLine.SetRange("Document No.", ConPOLine."Document No.");
                                            ConPOLine.SetRange("Vendor No.", ConPOLine."Vendor No.");

                                            if ConPOLine.FindSet then
                                                repeat
                                                    ConPOLine.Delete;
                                                until ConPOLine.Next = 0;

                                            ConPOLine.Description := PurchLine.Description;
                                            ConPOLine."PO No." := PurchHeader."No.";
                                            ConPOLine."Net Cost Price" := PurchLine."Net Price";
                                            ConPOLine."Total Discount Amt" += PurchLine."Line Discount Amount";
                                            ConPOLine."Retrieve Purchase Lines" := true;
                                            ConPOLine.Insert;

                                            InsertConPOLinesLocDateBlank;

                                        until PurchLine.Next = 0;


                                until PurchHeader.Next = 0;

                        end
                        else
                            // Location equal to blank
                            if (LocCodeL = '') and (Rec."Consolidate Starting Date" = 0D) and (Rec."Consolidate Ending Date" = 0D) then begin
                                PurchHeader.Reset;
                                PurchHeader.SetRange("Buy-from Vendor No.", Rec."Vendor No.");
                                PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                                PurchHeader.SetRange(Status, PurchHeader.Status::Open);
                                if PurchHeader.FindSet then
                                    repeat

                                    begin
                                        PurchLine.Reset;
                                        PurchLine.SetRange("Document No.", PurchHeader."No.");
                                        PurchLine.SetRange("Buy-from Vendor No.", PurchHeader."Buy-from Vendor No.");
                                        if PurchLine.FindSet then
                                            repeat

                                                LineNo := 1000;

                                                ConPOLine.Reset;
                                                ConPOLine.SetRange("Document No.", Rec."No.");
                                                if ConPOLine.FindLast then begin
                                                    LineNo := ConPOLine."Line No." + 1000;
                                                end;

                                                ConPOLine.Init;
                                                ConPOLine."Document No." := Rec."No.";
                                                ConPOLine."Vendor No." := Rec."Vendor No.";
                                                ConPOLine."Line No." := LineNo;
                                                ConPOLine."Item No." := PurchLine."No.";
                                                ConPOLine."Consolidate Start Date" := Rec."Consolidate Starting Date";
                                                ConPOLine."Consolidate End Date" := Rec."Consolidate Ending Date";
                                                ConPOLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                                                ConPOLine.Reset;
                                                ConPOLine.SetRange("Item No.", ConPOLine."Item No.");
                                                ConPOLine.SetRange("Document No.", ConPOLine."Document No.");
                                                ConPOLine.SetRange("Vendor No.", ConPOLine."Vendor No.");

                                                if ConPOLine.FindSet then
                                                    repeat
                                                        ConPOLine.Delete;
                                                    until ConPOLine.Next = 0;


                                                ConPOLine.Description := PurchLine.Description;
                                                ConPOLine."PO No." := PurchHeader."No.";


                                                ConPOLine."Net Cost Price" += PurchLine."Net Price";
                                                ConPOLine."Total Discount Amt" += PurchLine."Line Discount Amount";
                                                //  ConPOLine."Line Amount Excl. VAT" += PurchLine."Line Amount";
                                                // ConPOLine."Line Amount Excl. VAT" := ConPOLine.Quantity * ConPOLine."Direct Unit Cost Excl. VAT" - ConPOLine."Total Discount Amt";
                                                ConPOLine."Scheme Code" := PurchLine.Scheme;
                                                ConPOLine."Retrieve Purchase Lines" := true;
                                                //  ConPOLine."Line Amount Excl. VAT" := ConPOLine.Quantity * ConPOLine."Direct Unit Cost Excl. VAT";
                                                ConPOLine.Insert;
                                                //                    ConPOLine.CALCSUMS("Line Amount Excl. VAT");
                                                //                    ConPOLine.CALCSUMS("Total Discount Amt");
                                                //                    ConPOLine."Total Line Amount Excl. VAT" := 1000;
                                                //                    ConPOLine."Total Discount Amount" := ConPOLine."Total Discount Amt";

                                                InsertConPOLines;
                                            //   QuantityUpdateNEW;


                                            until PurchLine.Next = 0; //IF PurchLine.FINDSET THEN

                                    end; //IF (PurchHeader."Document Date" >= Rec."Consolidate Starting Date") AND (PurchHeader."Document Date" <= Rec."Consolidate Ending Date")  THEN

                                    until PurchHeader.Next = 0; //IF PurchHeader.FINDSET THEN

                            end;
                    end;
                }
                action("Apply to All Purchae Order")
                {
                    Caption = 'Apply to All PO';
                    Image = Apply;

                    trigger OnAction()
                    var
                        PurchaseAttributeListL: Page PurchaseAttributesList;
                        TotalPurchaseLine: Record "Purchase Line";
                        xPurchaseLine: Record "Purchase Line";
                        Answer: Boolean;
                        PaymentTerms: Record "Payment Terms";
                    begin
                        Answer := Confirm('Do you want to apply to all Purchase Orders?', false, true);
                        if Answer = true then begin
                            ConPODetailLines.Reset;
                            ConPODetailLines.SetRange("Document No.", Rec."No.");
                            if ConPODetailLines.FindSet then
                                repeat
                                    PurchLine.Reset;
                                    PurchLine.SetRange("Document No.", ConPODetailLines."PO No.");
                                    PurchLine.SetRange("No.", ConPODetailLines."Item No.");
                                    PurchLine.SetRange("Buy-from Vendor No.", ConPODetailLines."Vendor No.");

                                    if PurchLine.FindSet then
                                        repeat
                                            if PurchLine."No." <> '' then begin

                                                if ConPODetailLines.Quantity <> 0 then begin
                                                    PurchLine.Validate(Quantity, ConPODetailLines.Quantity);
                                                    PurchLine.Validate("Net Price", ConPODetailLines."Net Cost");
                                                    PurchLine.Validate("Direct Unit Cost", ConPODetailLines."Direct Unit Cost Excl. VAT");
                                                    PurchLine.Validate("Line Discount %", ConPODetailLines."Line Discount %");
                                                    PurchLine.Validate("Line Discount Amount", ConPODetailLines."Line Discount Amount");
                                                    PurchLine.Validate(Amount, ConPODetailLines."Line Amount Excl. VAT");
                                                    PurchLine.Validate(Remark, ConPODetailLines.Remark);

                                                    PurchLine."Inv. Discount Amount" := Rec."Invoice Amount";
                                                    PurchLine.Modify;
                                                end
                                                else
                                                    PurchLine.Validate(Quantity, ConPODetailLines.Quantity);
                                                PurchLine.Validate("Net Price", ConPODetailLines."Net Cost");
                                                PurchLine.Modify;
                                            end;//added by CSH
                                        until PurchLine.Next = 0;




                                    PurchHeader.Reset;
                                    PurchHeader.SetRange("No.", ConPODetailLines."PO No.");
                                    if PurchHeader.FindSet then
                                        repeat
                                            if Rec."Invoice Amount" <> 0 then begin
                                                InvoiceDiscountAmount := Round(Rec."Invoice Amount", Currency."Amount Rounding Precision");
                                                ValidateInvoiceDiscountAmount;
                                                DocumentTotals.PurchaseDocTotalsNotUpToDate;//ok for replenishment order

                                            end else
                                                if Rec."Invoice Discount %" <> 0 then //to avoid default 0 from applying
                                                  begin
                                                    PurchLine.Reset;
                                                    PurchLine.SetRange("Document No.", PurchHeader."No.");
                                                    PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                                                    AmountWithDiscountAllowed := DocumentTotals.CalcTotalPurchAmountOnlyDiscountAllowed(PurchLine);
                                                    InvoiceDiscountAmount := Round(AmountWithDiscountAllowed * Rec."Invoice Discount %" / 100, Currency."Amount Rounding Precision");
                                                    PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, PurchHeader);
                                                    PurchHeader.Modify(true);
                                                end;
                                            if Rec."0% Invoice Discount" = true then //for the purpose invoice discount is intentionally set into 0%
                                              begin
                                                InvoiceDiscountAmount := 0;
                                                PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, PurchHeader);
                                                PurchHeader.Modify(true);
                                            end;
                                        until PurchHeader.Next = 0;

                                    ConPOHeader.Reset;
                                    ConPOHeader.SetRange("No.", PurchHeader."CPO No.");
                                    if ConPOHeader.FindSet then
                                        repeat

                                            PurchHeader."Posting Date" := ConPOHeader."Posting Date";
                                            PurchHeader."Document Date" := ConPOHeader."Posting Date";

                                            //ModifiedDate @ 4-Sep-2023
                                            if (PurchHeader."Payment Terms Code" <> '') and (PurchHeader."Document Date" <> 0D) then begin
                                                PaymentTerms.Reset;
                                                PaymentTerms.SetRange(Code, PurchHeader."Payment Terms Code");
                                                if PaymentTerms.FindSet then
                                                    repeat

                                                        PurchHeader."Due Date" := CalcDate(PaymentTerms."Due Date Calculation", PurchHeader."Document Date");

                                                    until PaymentTerms.Next = 0;

                                            end
                                            else begin

                                                PurchHeader."Due Date" := PurchHeader."Document Date";

                                            end;
                                            PurchHeader.Modify;

                                        until ConPOHeader.Next = 0;//added by CSH


                                until ConPODetailLines.Next = 0;
                            Message('Succefully applied to all Purchase Order!');
                            AlreadApplied := true;

                        end;
                    end;
                }
                action("Clear Consolidate PO Lines")
                {
                    Image = Restore;

                    trigger OnAction()
                    var
                        ConPoDetailLine: Record "Consolidate PO Detail Line";
                    begin

                        ConPOLine.Reset;
                        ConPOLine.SetRange("Document No.", Rec."No.");
                        if ConPOLine.FindSet then
                            repeat
                                ConPOLine.Delete;
                            until ConPOLine.Next = 0;

                        ConPoDetailLine.Reset;
                        ConPoDetailLine.SetRange("Document No.", Rec."No.");
                        if ConPoDetailLine.FindSet then
                            repeat
                                ConPoDetailLine.Delete;
                            until ConPoDetailLine.Next = 0;

                        PurchHeader.Reset;
                        PurchHeader.SetRange("CPO No.", Rec."No.");
                        if PurchHeader.FindSet then
                            repeat
                                PurchHeader."CPO Confirm" := false;
                                PurchHeader."CPO No." := '';
                                PurchHeader.Modify(true);
                            until PurchHeader.Next = 0;
                    end;
                }
                action("Update PO Posting Date")
                {
                    Image = UpdateDescription;

                    trigger OnAction()
                    var
                        ConPoDetailLine: Record "Consolidate PO Detail Line";
                        FieldEditReport: Report "Posting Date Filter";
                    begin

                        Commit;
                        Clear(FieldEditReport);
                        FieldEditReport.VendorNoAndItemNo(Rec."No.");
                        FieldEditReport.Run;
                    end;
                }
            }
            group(Action10014518)
            {
                Caption = 'Post';
                Image = Post;
                action(Post)
                {
                    Image = PostOrder;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ConPoDetailLine: Record "Consolidate PO Detail Line";
                        Answer: Boolean;
                        InStr: InStream;
                        BinaryReader: DotNet BinaryReader;
                        BinaryWriter: DotNet BinaryWriter;
                        Encoding: DotNet Encoding;
                        MyText: Text;
                        InputLongTextTest: Page InputLongTextTest;
                        NewText: Text;
                        OutStr: OutStream;
                        CPOListPage: Page "Consolidate PO List";
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        if AlreadApplied = true then begin
                            ConPOLine.Reset;
                            ConPOLine.SetRange("Document No.", Rec."No.");
                            if ConPOLine.FindSet then
                                repeat
                                    if ConPOLine."Retrieve Purchase Lines" = true then begin
                                        ConPOLine."Lock PO" := true;
                                        ConPOLine.Modify;
                                    end;

                                until ConPOLine.Next = 0;

                            if Rec."Vendor No." = '' then
                                Error('"Vendor No." must be filled to post this document!');

                            ConPOLine.Reset;
                            ConPOLine.SetRange("Document No.", Rec."No.");
                            if ConPOLine.FindFirst = false then
                                Error('There is no CPO Line to post this document!');


                            Answer := DIALOG.Confirm('Do you want to post this Consolidate Purchase Order?', false);
                            if Answer = true then begin
                                PostedCPOHeader.Init;
                                PostedCPOHeader."No." := Rec."No.";
                                PostedCPOHeader.Validate("Vendor No.", Rec."Vendor No.");
                                PostedCPOHeader.Validate("Vendor Name", Rec."Vendor Name");
                                PostedCPOHeader.Validate("Document Date", Rec."Document Date");
                                PostedCPOHeader.Validate("External Document No.", Rec."External Document No.");
                                PostedCPOHeader.Validate("FOC PO No.", Rec."FOC PO No.");
                                PostedCPOHeader.Validate("Consolidate Starting Date", Rec."Consolidate Starting Date");
                                PostedCPOHeader.Validate("Consolidate Ending Date", Rec."Consolidate Ending Date");
                                PostedCPOHeader.Validate("Location Code", Rec."Location Code");
                                PostedCPOHeader.Validate("Total Discount Amount", Rec."Total Discount Amount");
                                PostedCPOHeader.Validate("Total Line Amount Excl. VAT", Rec."Total Line Amount Excl. VAT");
                                PostedCPOHeader.Validate("Created By", Rec."Created By");
                                PostedCPOHeader.Validate("No. Series", Rec."No. Series");
                                PostedCPOHeader.Validate(Comment, Rec.Comment);
                                PostedCPOHeader.Validate("Invoice Amount", Rec."Invoice Amount");
                                PostedCPOHeader.Validate("Invoice Discount %", Rec."Invoice Discount %");
                                PostedCPOHeader.Validate("0% Invoice Discount", Rec."0% Invoice Discount");
                                PostedCPOHeader.Insert(true);

                                ConPOHeader.Comment.CreateInStream(InStr);
                                BinaryReader := BinaryReader.BinaryReader(InStr, Encoding.UTF8);
                                if not IsNull(BinaryReader) then begin   //read value from BLOB field
                                    if BinaryReader.BaseStream.Length > 0 then
                                        MyText := BinaryReader.ReadString;
                                    BinaryReader.Close;
                                end;

                                if MyText <> '' then begin    //write value to BLOB field
                                    PostedCPOHeaderPage.GetParamComment(MyText, Rec."No.");
                                end;

                                ConPOLine.Reset;
                                ConPOLine.SetRange("Document No.", PostedCPOHeader."No.");
                                ConPOLine.SetRange("Vendor No.", PostedCPOHeader."Vendor No.");
                                if ConPOLine.FindSet then
                                    repeat
                                        PostedCPOLines.Init;
                                        PostedCPOLines."Document No." := ConPOLine."Document No.";
                                        PostedCPOLines.Validate("Vendor No.", ConPOLine."Vendor No.");
                                        PostedCPOLines.Validate("Line No.", ConPOLine."Line No.");
                                        PostedCPOLines.Validate("Item No.", ConPOLine."Item No.");
                                        PostedCPOLines.Validate(Description, ConPOLine.Description);
                                        PostedCPOLines.Validate(Quantity, ConPOLine.Quantity);
                                        PostedCPOLines.Validate("Unit of Measure Code", ConPOLine."Unit of Measure Code");
                                        PostedCPOLines.Validate("Direct Unit Cost Excl. VAT", ConPOLine."Direct Unit Cost Excl. VAT");
                                        PostedCPOLines.Validate("Net Cost Price", ConPOLine."Net Cost Price");
                                        PostedCPOLines.Validate("Total Dis AMT", ConPOLine."Total Dis AMT");
                                        PostedCPOLines.Validate("Line Amount Excl. VAT", ConPOLine."Line Amount Excl. VAT");
                                        PostedCPOLines.Validate("Scheme Code", ConPOLine."Scheme Code");
                                        PostedCPOLines.Validate("PO No.", ConPOLine."PO No.");
                                        PostedCPOLines.Validate("Total Discount Amount", ConPOLine."Total Discount Amount");
                                        PostedCPOLines.Validate("Discount Amount", ConPOLine."Discount Amount");
                                        PostedCPOLines.Validate("Total Line Amount Excl. VAT", ConPOLine."Total Line Amount Excl. VAT");
                                        PostedCPOLines.Validate("Location Code", ConPOLine."Location Code");
                                        PostedCPOLines.Validate("Retrieve Purchase Lines", ConPOLine."Retrieve Purchase Lines");
                                        PostedCPOLines.Validate("Consolidate Start Date", ConPOLine."Consolidate Start Date");
                                        PostedCPOLines.Validate("Consolidate End Date", ConPOLine."Consolidate End Date");
                                        PostedCPOLines.Validate("Total Discount Amt", ConPOLine."Total Discount Amt");
                                        PostedCPOLines.Validate("Total Line Amount", ConPOLine."Total Line Amount");
                                        PostedCPOLines.Validate(TotalAmountLoc, ConPOLine.TotalAmountLoc);

                                        PostedCPOLines.Validate(SumofQty, ConPOLine.SumofQty);
                                        PostedCPOLines.Validate(MaxQtyperUOM, ConPOLine.MaxQtyperUOM);

                                        PostedCPOLines.Validate("Total Line Amount Excl. VAT", ConPOLine."Total Line Amount Excl. VAT");

                                        PostedCPOLines.Insert(true);
                                    until ConPOLine.Next = 0;

                                ConPODetailLines.Reset;
                                ConPODetailLines.SetRange("Document No.", Rec."No.");
                                if ConPODetailLines.FindSet then
                                    repeat
                                        PurchHeader.Reset;
                                        PurchHeader.SetRange("No.", ConPODetailLines."PO No.");
                                        PurchHeader.SetRange("CPO No.", Rec."No.");
                                        //ReleasePurchDoc.PerformManualRelease(PurchHeader);
                                        if PurchHeader.FindSet then
                                            repeat
                                                PurchHeader."CPO Confirm" := true;
                                                PurchHeader.Status := PurchHeader.Status::Open;
                                                PurchHeader.Validate("LSC Retail Status", PurchHeader."LSC Retail Status"::Sent);
                                                ReleasePurchDoc.PerformManualRelease(PurchHeader);
                                                PurchHeader.Modify;

                                                PurchLine.Reset;
                                                PurchLine.SetRange("Document No.", PurchHeader."No.");
                                                if PurchLine.FindSet then
                                                    repeat
                                                        PurchLine.Validate("PO Status", PurchLine."PO Status"::Released);
                                                        PurchLine.Modify;
                                                    until PurchLine.Next = 0;
                                            until PurchHeader.Next = 0;


                                    until ConPODetailLines.Next = 0;


                                //Delete Demand Line
                                ConPOLine.Reset;
                                ConPOLine.SetRange("Document No.", Rec."No.");
                                if ConPOLine.FindSet then
                                    repeat
                                        ConPOLine.DeleteAll;
                                    until ConPOLine.Next = 0;

                                //Delete Demand Header
                                ConPOHeader.Reset;
                                ConPOHeader.SetRange("No.", Rec."No.");
                                ConPOHeader.DeleteAll;

                                Message('Consolidate Purchase Order is successfully posted.');
                                CurrPage.Close;
                            end;
                        end else
                            Error('You have not applied to all PO to post this CPO!');
                    end;
                }
            }
            group(Action10014517)
            {
                Caption = 'Comment';
                Image = Post;
                action(Comment)
                {
                    Image = ViewComments;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page "Purch. Comment Sheet";

                    trigger OnAction()
                    var
                        ConPoDetailLine: Record "Consolidate PO Detail Line";
                    begin

                        ConPOLine.Reset;
                        ConPOLine.SetRange("Document No.", Rec."No.");
                        if ConPOLine.FindSet then
                            repeat
                                if ConPOLine."Retrieve Purchase Lines" = true then begin
                                    ConPOLine."Lock PO" := true;
                                    ConPOLine.Modify;
                                end;

                            until ConPOLine.Next = 0;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        ShowCommentBlobText; //added by HMA

        ConPOLine.Reset;
        ConPOLine.SetRange("Document No.", Rec."No.");
        if ConPOLine.FindSet then
            repeat
                Rec."Posting Date" := ConPOLine."Posting Date";
                Rec.Modify;
            until ConPOLine.Next = 0;//added by CSH
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
        PurchHeader.SetRange("CPO No.", Rec."No.");
        if PurchHeader.FindSet then
            repeat
                PurchHeader."CPO Confirm" := false;
                PurchHeader."CPO No." := '';
                PurchHeader.Modify(true);
            until PurchHeader.Next = 0;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ConPOHeader."Document Date" := Today;
        ConPOHeader."Created By" := UserId;
    end;

    var
        Vend: Record Vendor;
        PurchHeader: Record "Purchase Header";
        ConPOHeader: Record "Consolidate Purchase Header";
        ConPOLine: Record "Consolidate Purchase Line";
        PurchLine: Record "Purchase Line";
        VenTradeScheme: Record "Vendor Trade Scheme";
        Purch: Record "Purchase Header";
        TempPurchLine: Record "Purchase Line";
        ConPODetailLines: Record "Consolidate PO Detail Line";
        ItemUOM: Record "Item Unit of Measure";
        value: Decimal;
        Maxvalue: Decimal;
        specific_ReceiptID_var: Code[10];
        Multi1: Decimal;
        Multi2: Decimal;
        Multi3: Decimal;
        Count1: Decimal;
        Count2: Decimal;
        Count3: Decimal;
        Count4: Decimal;
        TotalLineAmountLoc: Decimal;
        TotalLineAmount: Decimal;
        TotalDisAmountLoc: Decimal;
        TotalDisAmount: Decimal;
        SUM1: Decimal;
        SUM2: Decimal;
        QTY1: Decimal;
        ItemR: Record Item;
        PUnitofMeasure: Code[10];
        VarTemp: Integer;
        CommentTextG: Text;
        PurchLinePage: Page "Purchase Order Subform";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        AmountWithDiscountAllowed: Decimal;
        DocumentTotals: Codeunit "Document Totals";
        InvoiceDiscountAmount: Decimal;
        Currency: Record Currency;
        PostedCPOHeader: Record "Posted CPO Header";
        PostedCPOLines: Record "Posted CPO Lines";
        PostedCPOHeaderPage: Page "Posted CPO Header";
        AlreadApplied: Boolean;
        PurchaseHeader: Record "Purchase Header";
        UpdateInvDiscountQst: Label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';

    local procedure InsertConPOLines()
    var
        PurchLine: Record "Purchase Line";
        ConPODetailLine: Record "Consolidate PO Detail Line";
        MaxValue: Code[10];
        LineNo: Integer;
    begin

        PurchLine.Reset;
        PurchLine.SetRange("Buy-from Vendor No.", ConPOLine."Vendor No.");
        PurchLine.SetRange("Document No.", ConPOLine."PO No.");
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        if PurchLine.FindSet then
            repeat
                LineNo := 1000;

                ConPODetailLine.Reset;
                // ConPODetailLine.SETRANGE("Document No.",Rec."No.");
                if ConPODetailLine.FindLast then begin
                    LineNo := ConPODetailLine."Line No." + 1000;
                end;

                ConPODetailLine.Init;
                ConPODetailLine."PO No." := PurchLine."Document No.";
                ConPODetailLine."Document Type" := 'Order';
                ConPODetailLine."Vendor No." := PurchLine."Buy-from Vendor No.";
                ConPODetailLine."Line No." := LineNo;

                Vend.Reset;
                Vend.SetRange("No.", ConPODetailLine."Vendor No.");
                if Vend.FindFirst then begin
                    ConPODetailLine."Vendor Name" := Vend.Name;
                end;

                ConPODetailLine."Posting Date" := PurchHeader."Posting Date";
                ConPODetailLine."Vendor Name" := Vend.Name;
                ConPODetailLine.Type := 'Item';
                ConPODetailLine."Item No." := PurchLine."No.";
                ConPODetailLine.Scheme := PurchLine.Scheme;
                ConPODetailLine."Document No." := ConPOLine."Document No.";
                ConPODetailLine.Description := PurchLine.Description;
                ConPODetailLine."Location Code" := PurchLine."Location Code";
                ConPODetailLine.Quantity := PurchLine.Quantity;
                ConPODetailLine."Net Cost" := PurchLine."Net Price";
                ConPODetailLine."Line Discount %" := PurchLine."Line Discount %";
                ConPODetailLine."Line Discount Amount" := PurchLine."Line Discount Amount";
                ConPODetailLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                ConPODetailLine."Line Amount Excl. VAT" := PurchLine."Line Amount";
                ConPODetailLine."Unit of Measure Code" := PurchLine."Unit of Measure Code";

                ItemUOM.Reset;
                ItemUOM.SetRange("Item No.", ConPODetailLine."Item No.");
                ItemUOM.SetRange(Code, ConPODetailLine."Unit of Measure Code");
                if ItemUOM.FindSet then
                    repeat

                        ConPODetailLine."Qty per UOM" := ItemUOM."Qty. per Unit of Measure";

                    until ItemUOM.Next = 0;

                ConPODetailLine."Sum of Qty" += ConPODetailLine.Quantity * ConPODetailLine."Qty per UOM";
                ConPODetailLine."Child PO No." := PurchHeader."FOC PO No.";
                if ConPODetailLine."Child PO No." <> '' then begin
                    ConPODetailLine."Child PO No. Update" := true;
                end
                else begin
                    ConPODetailLine."Child PO No. Update" := false;
                end;



                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Item No.", ConPODetailLine."Item No.");
                ConPODetailLine.SetRange("PO No.", ConPODetailLine."PO No.");
                ConPODetailLine.SetRange("Vendor No.", ConPODetailLine."Vendor No.");
                ConPODetailLine.SetRange("Document No.", ConPODetailLine."Document No.");
                ConPODetailLine.SetRange("Line Discount Amount", ConPODetailLine."Line Discount Amount");
                ConPODetailLine.SetRange("Location Code", ConPODetailLine."Location Code");
                ConPODetailLine.SetRange("Direct Unit Cost Excl. VAT", ConPODetailLine."Direct Unit Cost Excl. VAT");
                ConPODetailLine.SetRange("Unit of Measure Code", ConPODetailLine."Unit of Measure Code");

                ConPODetailLine.SetRange(Quantity, ConPODetailLine.Quantity);
                if ConPODetailLine.FindSet then
                    repeat
                        ConPODetailLine.Delete;
                    until ConPODetailLine.Next = 0;

                ConPODetailLine.Insert;
                MaxUOMFunction(ConPOLine);
                AddUOM_CalcQty;

            //  UnitofMeasureUpdateLoc;
            until PurchLine.Next = 0;
    end;

    local procedure InsertConPOLinesLoc()
    var
        PurchLine: Record "Purchase Line";
        ConPODetailLine: Record "Consolidate PO Detail Line";
        MaxValue: Code[10];
        LineNo: Integer;
        LocCodeL: Code[200];
        ConPOHeaderL: Record "Consolidate Purchase Header";
        LineNoMsgL: Text;
        StoreNoMsgL: Text;
        ProgressBarL: Text;
        DialogBoxL: Dialog;
        NoOfRecordL: Integer;
        NextL: Integer;
        Dec: Decimal;
    begin

        PurchLine.Reset;
        PurchLine.SetRange("Buy-from Vendor No.", ConPOLine."Vendor No.");
        PurchLine.SetRange("Document No.", ConPOLine."PO No.");
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetFilter("Location Code", Rec."Location Code");

        if PurchLine.FindSet then
            repeat
                LineNo := 1000;

                ConPODetailLine.Reset;
                // ConPODetailLine.SETRANGE("Document No.",Rec."No.");
                if ConPODetailLine.FindLast then begin
                    LineNo := ConPODetailLine."Line No." + 1000;
                end;

                ConPODetailLine.Init;
                ConPODetailLine."PO No." := PurchLine."Document No.";
                ConPODetailLine."Document Type" := 'Order';
                ConPODetailLine."Vendor No." := PurchLine."Buy-from Vendor No.";
                ConPODetailLine."Line No." := LineNo;
                ConPODetailLine.Type := 'Item';
                ConPODetailLine."Item No." := PurchLine."No.";
                ConPODetailLine.Scheme := PurchLine.Scheme;
                ConPODetailLine."Document No." := ConPOLine."Document No.";
                ConPODetailLine.Description := PurchLine.Description;
                ConPODetailLine."Location Code" := PurchLine."Location Code";
                ConPODetailLine.Quantity := PurchLine.Quantity;
                ConPODetailLine."Net Cost" := PurchLine."Net Price";
                ConPODetailLine."Line Discount %" := PurchLine."Line Discount %";
                ConPODetailLine."Line Discount Amount" := PurchLine."Line Discount Amount";
                ConPODetailLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                ConPODetailLine."Line Amount Excl. VAT" := PurchLine."Line Amount";

                Vend.Reset;
                Vend.SetRange("No.", ConPODetailLine."Vendor No.");
                if Vend.FindFirst then begin
                    ConPODetailLine."Vendor Name" := Vend.Name;
                end;

                ConPODetailLine."Posting Date" := PurchHeader."Posting Date";
                ConPOLine.Reset;
                ConPOLine.SetRange("Document No.", ConPODetailLine."Document No.");
                if ConPOLine.FindSet then
                    repeat
                    //  ConPOLine."Total Line Amount Excl. VAT" += ConPODetailLine."Line Amount Excl. VAT";
                    until ConPODetailLine.Next = 0;


                ConPODetailLine."Unit of Measure Code" := PurchLine."Unit of Measure Code";
                ItemUOM.Reset;
                ItemUOM.SetRange("Item No.", ConPODetailLine."Item No.");
                ItemUOM.SetRange(Code, ConPODetailLine."Unit of Measure Code");
                if ItemUOM.FindSet then
                    repeat
                        ConPODetailLine."Qty per UOM" := ItemUOM."Qty. per Unit of Measure";
                    until ItemUOM.Next = 0;

                ConPODetailLine."Sum of Qty" += ConPODetailLine.Quantity * ConPODetailLine."Qty per UOM";
                ConPODetailLine."Child PO No." := PurchHeader."FOC PO No.";
                if ConPODetailLine."Child PO No." <> '' then begin
                    ConPODetailLine."Child PO No. Update" := true;
                end
                else begin
                    ConPODetailLine."Child PO No. Update" := false;
                end;

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Item No.", ConPODetailLine."Item No.");
                ConPODetailLine.SetRange("PO No.", ConPODetailLine."PO No.");
                ConPODetailLine.SetRange("Vendor No.", ConPODetailLine."Vendor No.");
                ConPODetailLine.SetRange("Document No.", ConPODetailLine."Document No.");
                ConPODetailLine.SetRange("Line Discount Amount", ConPODetailLine."Line Discount Amount");
                ConPODetailLine.SetRange("Location Code", ConPODetailLine."Location Code");
                ConPODetailLine.SetRange("Direct Unit Cost Excl. VAT", ConPODetailLine."Direct Unit Cost Excl. VAT");

                ConPODetailLine.SetRange(Quantity, ConPODetailLine.Quantity);
                ConPODetailLine.SetRange("Unit of Measure Code", ConPODetailLine."Unit of Measure Code");
                if ConPODetailLine.FindSet then
                    repeat
                        ConPODetailLine.Delete;
                    until ConPODetailLine.Next = 0;

                ConPODetailLine.Insert;
                MaxUOMFunction(ConPOLine);
                AddUOM_CalcQty;

            until PurchLine.Next = 0;
    end;

    local procedure MaxUOMFunction(Con_POLine: Record "Consolidate Purchase Line")
    var
        ConPODetailLine: Record "Consolidate PO Detail Line";
        CalcSUM: Decimal;
        QTYSUM1: Decimal;
        QTYSUM2: Integer;
        NewConPODeatilLine: Record "Consolidate PO Detail Line";
    begin


        if ConPOLine.FindSet then
            repeat

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Document No.", ConPOLine."Document No.");
                ConPODetailLine.SetRange("Item No.", ConPOLine."Item No.");
                if ConPODetailLine."Location Code" <> '' then
                    ConPODetailLine.SetRange("Location Code", ConPOLine."Location Code");

                ConPODetailLine.SetCurrentKey("Qty per UOM");
                if ConPODetailLine.Find('+') then begin

                    ConPODetailLine.MaxUOM := true;
                    ConPODetailLine.Modify;

                end; //IF ConPODetailLine.FIND ('+') THEN



            until ConPOLine.Next = 0; //IF ConPOLine.FINDSET THEN

    end;

    local procedure AddUOM_CalcQty()
    var
        ConPODetailLine: Record "Consolidate PO Detail Line";
        CalcSUM: Decimal;
        QTYSUM1: Decimal;
        QTYSUM2: Integer;
        NewConPODeatilLine: Record "Consolidate PO Detail Line";
    begin

        QTYSUM1 := 0;
        //........................................... Add UOM and Quantity ........................................................................
        // Consolidate Purchase Order Count >1

        if ConPOLine.FindSet then
            repeat

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Item No.", ConPOLine."Item No.");
                ConPODetailLine.SetRange("Document No.", ConPOLine."Document No.");

                if ConPODetailLine."Location Code" <> '' then
                    ConPODetailLine.SetRange("Location Code", ConPOLine."Location Code");
                if ConPODetailLine.FindSet then
                    repeat
                        if ConPODetailLine.Count >= 1 then begin

                            ConPODetailLine.CalcSums("Sum of Qty");
                            QTYSUM1 := ConPODetailLine."Sum of Qty";

                            if ConPODetailLine.MaxUOM = true then begin
                                ConPOLine."Unit of Measure Code" := ConPODetailLine."Unit of Measure Code";
                                ConPOLine.MaxQtyperUOM := ConPODetailLine."Qty per UOM";
                                ConPOLine.Quantity := QTYSUM1 / ConPOLine.MaxQtyperUOM;
                                ConPOLine."Direct Unit Cost Excl. VAT" := ConPODetailLine."Direct Unit Cost Excl. VAT";
                                ConPOLine."Line Amount Excl. VAT" := (ConPOLine.Quantity * ConPOLine."Direct Unit Cost Excl. VAT") - ConPOLine."Total Discount Amt";
                                ConPOLine.Modify(true);
                            end;

                        end;  //IF ConPODetailLine.COUNT > 1 THEN

                    until ConPODetailLine.Next = 0; //IF ConPODetailLine.FINDSET THEN
            until ConPOLine.Next = 0;
    end;



    local procedure InsertConPOLinesLocDateBlank()
    var
        PurchLine: Record "Purchase Line";
        ConPODetailLine: Record "Consolidate PO Detail Line";
        MaxValue: Code[10];
        LineNo: Integer;
        LocCodeL: Code[200];
        ConPOHeaderL: Record "Consolidate Purchase Header";
        LineNoMsgL: Text;
        StoreNoMsgL: Text;
        ProgressBarL: Text;
        DialogBoxL: Dialog;
        NoOfRecordL: Integer;
        NextL: Integer;
        Dec: Decimal;
    begin

        PurchLine.Reset;
        PurchLine.SetRange("Buy-from Vendor No.", ConPOLine."Vendor No.");
        PurchLine.SetRange("Document No.", ConPOLine."PO No.");
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        //PurchLine.SETFILTER("Location Code",'<>%1',' ');
        PurchLine.SetFilter("Location Code", Rec."Location Code");
        //MESSAGE('%1',PurchLine."Location Code");

        if PurchLine.FindSet then
            repeat
                LineNo := 1000;

                ConPODetailLine.Reset;
                // ConPODetailLine.SETRANGE("Document No.",Rec."No.");
                if ConPODetailLine.FindLast then begin
                    LineNo := ConPODetailLine."Line No." + 1000;
                end;

                ConPODetailLine.Init;
                ConPODetailLine."PO No." := PurchLine."Document No.";
                ConPODetailLine."Document Type" := 'Order';
                ConPODetailLine."Vendor No." := PurchLine."Buy-from Vendor No.";
                ConPODetailLine."Line No." := LineNo;
                ConPODetailLine.Type := 'Item';
                ConPODetailLine."Item No." := PurchLine."No.";
                ConPODetailLine.Scheme := PurchLine.Scheme;

                ConPODetailLine."Document No." := ConPOLine."Document No.";
                ConPODetailLine.Description := PurchLine.Description;
                ConPODetailLine."Location Code" := PurchLine."Location Code";
                ConPODetailLine.Quantity := PurchLine.Quantity;
                ConPODetailLine."Net Cost" := PurchLine."Net Price";
                ConPODetailLine."Line Discount %" := PurchLine."Line Discount %";
                ConPODetailLine."Line Discount Amount" := PurchLine."Line Discount Amount";
                ConPODetailLine."Direct Unit Cost Excl. VAT" := PurchLine."Direct Unit Cost";
                ConPODetailLine."Line Amount Excl. VAT" := PurchLine."Line Amount";

                Vend.Reset;
                Vend.SetRange("No.", ConPODetailLine."Vendor No.");
                if Vend.FindFirst then begin
                    ConPODetailLine."Vendor Name" := Vend.Name;
                end;

                ConPODetailLine."Posting Date" := PurchHeader."Posting Date";
                ConPOLine.Reset;
                ConPOLine.SetRange("Document No.", ConPODetailLine."Document No.");
                if ConPOLine.FindSet then
                    repeat
                    //  ConPOLine."Total Line Amount Excl. VAT" += ConPODetailLine."Line Amount Excl. VAT";
                    until ConPODetailLine.Next = 0;


                ConPODetailLine."Unit of Measure Code" := PurchLine."Unit of Measure Code";
                ItemUOM.Reset;
                ItemUOM.SetRange("Item No.", ConPODetailLine."Item No.");
                ItemUOM.SetRange(Code, ConPODetailLine."Unit of Measure Code");
                if ItemUOM.FindSet then
                    repeat
                        ConPODetailLine."Qty per UOM" := ItemUOM."Qty. per Unit of Measure";
                    until ItemUOM.Next = 0;

                ConPODetailLine."Sum of Qty" += ConPODetailLine.Quantity * ConPODetailLine."Qty per UOM";
                ConPODetailLine."Child PO No." := PurchHeader."FOC PO No.";
                if ConPODetailLine."Child PO No." <> '' then begin
                    ConPODetailLine."Child PO No. Update" := true;
                end
                else begin
                    ConPODetailLine."Child PO No. Update" := false;
                end;

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Item No.", ConPODetailLine."Item No.");
                ConPODetailLine.SetRange("PO No.", ConPODetailLine."PO No.");
                ConPODetailLine.SetRange("Vendor No.", ConPODetailLine."Vendor No.");
                ConPODetailLine.SetRange("Document No.", ConPODetailLine."Document No.");
                ConPODetailLine.SetRange("Line Discount Amount", ConPODetailLine."Line Discount Amount");
                ConPODetailLine.SetRange("Location Code", ConPODetailLine."Location Code");
                ConPODetailLine.SetRange("Direct Unit Cost Excl. VAT", ConPODetailLine."Direct Unit Cost Excl. VAT");
                ConPODetailLine.SetRange(Quantity, ConPODetailLine.Quantity);
                ConPODetailLine.SetRange("Unit of Measure Code", ConPODetailLine."Unit of Measure Code");
                if ConPODetailLine.FindSet then
                    repeat
                        ConPODetailLine.Delete;
                    until ConPODetailLine.Next = 0;

                ConPODetailLine.Insert;
                MaxUOMFunctionDateBlank(ConPOLine);
                AddUOM_CalcQtyDateBlank;

            until PurchLine.Next = 0;
    end;

    local procedure MaxUOMFunctionDateBlank(Con_POLine: Record "Consolidate Purchase Line")
    var
        ConPODetailLine: Record "Consolidate PO Detail Line";
        CalcSUM: Decimal;
        QTYSUM1: Decimal;
        QTYSUM2: Integer;
        NewConPODeatilLine: Record "Consolidate PO Detail Line";
    begin


        if ConPOLine.FindSet then
            repeat

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Document No.", ConPOLine."Document No.");
                ConPODetailLine.SetRange("Item No.", ConPOLine."Item No.");
                if ConPODetailLine."Location Code" <> '' then
                    ConPODetailLine.SetRange("Location Code", ConPOLine."Location Code");
                ConPODetailLine.SetCurrentKey("Qty per UOM");
                if ConPODetailLine.Find('+') then begin

                    ConPODetailLine.MaxUOM := true;
                    ConPODetailLine.Modify;

                end; //IF ConPODetailLine.FIND ('+') THEN



            until ConPOLine.Next = 0; //IF ConPOLine.FINDSET THEN
    end; //IF "Location Code" <> '' THEN
    // end;

    local procedure AddUOM_CalcQtyDateBlank()
    var
        ConPODetailLine: Record "Consolidate PO Detail Line";
        CalcSUM: Decimal;
        QTYSUM1: Decimal;
        QTYSUM2: Integer;
        NewConPODeatilLine: Record "Consolidate PO Detail Line";
    begin

        QTYSUM1 := 0;
        //........................................... Add UOM and Quantity ........................................................................
        // Consolidate Purchase Order Count >1

        if ConPOLine.FindSet then
            repeat

                ConPODetailLine.Reset;
                ConPODetailLine.SetRange("Item No.", ConPOLine."Item No.");
                ConPODetailLine.SetRange("Document No.", ConPOLine."Document No.");
                if ConPODetailLine."Location Code" <> '' then
                    ConPODetailLine.SetRange("Location Code", ConPOLine."Location Code");
                if ConPODetailLine.FindSet then
                    repeat
                        if ConPODetailLine.Count > 1 then begin

                            ConPODetailLine.CalcSums("Sum of Qty");
                            QTYSUM1 := ConPODetailLine."Sum of Qty";

                            if ConPODetailLine.MaxUOM = true then begin
                                ConPOLine."Unit of Measure Code" := ConPODetailLine."Unit of Measure Code";
                                ConPOLine.MaxQtyperUOM := ConPODetailLine."Qty per UOM";
                                ConPOLine.Quantity := QTYSUM1 / ConPOLine.MaxQtyperUOM;
                                ConPOLine."Direct Unit Cost Excl. VAT" := ConPODetailLine."Direct Unit Cost Excl. VAT";
                                ConPOLine."Line Amount Excl. VAT" := (ConPOLine.Quantity * ConPOLine."Direct Unit Cost Excl. VAT") - ConPOLine."Total Discount Amt";
                                ConPOLine.Modify(true);
                            end;

                        end;  //IF ConPODetailLine.COUNT > 1 THEN

                    until ConPODetailLine.Next = 0; //IF ConPODetailLine.FINDSET THEN
            until ConPOLine.Next() = 0;

    end;



    local procedure UpdateCommentBlobText(Text_Params: Text)
    var
        InStr: InStream;
        BinaryReader: DotNet BinaryReader;
        BinaryWriter: DotNet BinaryWriter;
        Encoding: DotNet Encoding;
        MyText: Text;
        InputLongTextTest: Page InputLongTextTest;
        NewText: Text;
        OutStr: OutStream;

    begin

        begin
            NewText := Text_Params;
            Clear(ConPOHeader.Comment);
            ConPOHeader.Comment.CreateOutStream(OutStr);
            BinaryWriter := BinaryWriter.BinaryWriter(OutStr, Encoding.UTF8);
            BinaryWriter.Write(NewText);
            BinaryWriter.Close;
            ConPOHeader.Modify();
        end; // IF Text_Params <> '' THEN
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
        ConPOHeader.CalcFields(ConPOHeader.Comment);
        ConPOHeader.Comment.CreateInStream(InStr);
        BinaryReader := BinaryReader.BinaryReader(InStr, Encoding.UTF8);
        if not IsNull(BinaryReader) then begin   //read value from BLOB field
            if BinaryReader.BaseStream.Length > 0 then
                MyTextL := BinaryReader.ReadString;
            BinaryReader.Close;
        end;

        CommentTextG := MyTextL;
    end;

    local procedure ValidateInvoiceDiscountAmount()
    var
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        PurchHeader.Get(PurchHeader."Document Type"::Order, PurchHeader."No.");
        if PurchHeader.InvoicedLineExists then
            //if not ConfirmManagement.ConfirmProcess(UpdateInvDiscountQst, true) then
            if not ConfirmProcessNwmm(UpdateInvDiscountQst, true) then
                exit;

        DocumentTotals.PurchaseDocTotalsNotUpToDate;
        PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, PurchHeader);
        CurrPage.Update(false);
    end;

    local procedure UpdatePurchaseLine()
    begin
        //            PurchLine."Unit of Measure Code" := ConPODetailLines."Unit of Measure Code";
        //            PurchLine."Line Amount" := PurchLine.Quantity * PurchLine."Direct Unit Cost";
        //            PurchLine.Amount:= 0;
        //            PurchLine."Amount Including VAT" := 0;
        //            PurchLine."Direct Unit Cost" := 0;
        //            PurchLine."Line Amount" := 0;
        PurchLine.Validate("Direct Unit Cost", ConPODetailLines."Direct Unit Cost Excl. VAT");
        PurchLine.Validate("Line Discount %", ConPODetailLines."Line Discount %");
        PurchLine.Validate("Line Discount Amount", ConPODetailLines."Line Discount Amount");
        PurchLine.Validate(Amount, ConPODetailLines."Line Amount Excl. VAT");
        //PurchLine."Net Price" := ConPODetailLines."Net Cost";
        //PurchLine."Inv. Discount Amount" := Rec."Invoice Amount";
    end;

    procedure ConfirmProcessNwmm(ConfirmQuestion: Text; DefaultButton: Boolean): Boolean
    begin
        IF NOT GUIALLOWED THEN
            EXIT(DefaultButton);
        EXIT(CONFIRM(ConfirmQuestion, DefaultButton));
    end;

}

