tableextension 70030 "Transfer Header Extension" extends "Transfer Header"
{
    fields
    {
        field(70000; "Transfer From"; Option)
        {
            OptionMembers = " ","Transfer to TO","Purchase to TO";
            Caption = 'Transfer From';
            OptionCaption = ' ,Transfer to TO,Purchase to TO';
            DataClassification = ToBeClassified;
        }
        field(70001; "Transfer PO No."; Code[100])
        {
            Caption = 'Transfer PO No.';
            DataClassification = ToBeClassified;
        }
        field(70002; "Store-to"; Code[10])
        {
            Caption = 'Store-to';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store";
            trigger OnValidate()
            var
                lStoreRec: Record "LSC Store";
            begin
                //LS -
                //LS-12507 TestStatusOpen;
                TESTFIELD(Status, Status::Open); //LS-12507
                "Transfer-to Code" := '';
                IF "Store-to" <> '' THEN
                    IF lStoreRec.GET("Store-to") THEN
                        VALIDATE("Transfer-to Code", lStoreRec."Location Code");
                //LS +

                //LS-12465 SetStoreDimension(FIELDNO("Store-to"));
                RetailTransferOrderExt.SetStoreDimension(Rec, Rec.FIELDNO("Store-to")); //LS-12465
            end;
        }
        field(70003; "Store-from"; Code[10])
        {
            Caption = 'Store-from';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Store";
            trigger OnValidate()
            var
                lStoreRec: Record "LSC Store";
            begin
                //LS -
                //LS-12507 TestStatusOpen;
                TESTFIELD(Status, Status::Open); //LS-12507
                "Transfer-from Code" := '';
                IF "Store-from" <> '' THEN
                    IF lStoreRec.GET("Store-from") THEN
                        VALIDATE("Transfer-from Code", lStoreRec."Location Code");
                //LS +

                //LS-12465 SetStoreDimension(FIELDNO("Store-from"));
                RetailTransferOrderExt.SetStoreDimension(Rec, Rec.FIELDNO("Store-from")); //LS-12465
            end;
        }
        field(70004; "Customer Order ID"; Code[20])
        {
            Caption = 'Customer Order ID';
            DataClassification = ToBeClassified;
        }
        // field(70005; "Retail Status"; Option)
        // {
        //     OptionMembers = New,Sent,"Part. receipt","Closed - ok","Closed - difference","To receive","Planned receive";
        //     Caption = 'Retail Status';
        //     DataClassification = ToBeClassified;
        // }
        field(70006; "Reciving/Picking No."; Code[20])
        {
            Caption = 'Reciving/Picking No.';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Posted P/R Counting Header";
        }
        field(70007; "RTC Filtering Type"; Option)
        {
            OptionMembers = None,"Store-to","Store-from";
            Caption = 'RTC Filtering Type';
            DataClassification = ToBeClassified;
        }
        field(70008; "Buyer ID"; Code[50])
        {
            Caption = 'Buyer ID';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Retail User";
        }
        field(70009; "Buyer Group Code"; Code[10])
        {
            Caption = 'Buyer Group Code';
            DataClassification = ToBeClassified;
            TableRelation = "LSC Buyer Group";
        }
        field(70010; "Created By Source Code"; Code[10])
        {
            Caption = 'Created By Source Code';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(70011; "Transfer Type"; Option)
        {
            OptionMembers = ,"Planned Cross Docking","Buyer's Push",Replenishment,"Stock Recall","Special Order";
            Caption = 'Transfer Type';
            DataClassification = ToBeClassified;
        }
        field(70012; "New Dimension Set ID"; Integer)
        {
            Caption = 'New Dimension Set ID';
            DataClassification = ToBeClassified;
        }
        field(70013; "New Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'New Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            begin
                //LS-12465 ValidateNewShortcutDimCode(1,"New Shortcut Dimension 1 Code");
                //RetailTransferOrderExt.ValidateNewShortcutDimCode(Rec, 1, "New Shortcut Dimension 1 Code");//LS-12465
                ValidateNewShortcutDimCodeNwmm(Rec, 1, "New Shortcut Dimension 1 Code");//LS-12465
            end;
        }
        field(70014; "New Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'New Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            begin
                //LS-12465 ValidateNewShortcutDimCode(2,"New Shortcut Dimension 2 Code");
                //RetailTransferOrderExt.ValidateNewShortcutDimCode(Rec, 2, "New Shortcut Dimension 2 Code"); //LS-12465
                ValidateNewShortcutDimCodeNwmm(Rec, 2, "New Shortcut Dimension 2 Code"); //LS-12465
            end;
        }

    }
    var
        RetailTransferOrderExt: Codeunit "LSC Retail Transfer Order Ext.";

    procedure ValidateNewShortcutDimCodeNwmm(var TransferHeader: Record "Transfer Header"; FieldNumber: Integer; var NewShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, NewShortcutDimCode, TransferHeader."LSC New Dimension Set ID");
    end;


}
