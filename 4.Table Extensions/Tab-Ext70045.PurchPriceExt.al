tableextension 70045 PurchPriceExt extends "Purchase Price"
{
    fields
    {
        field(70000; "Wholesale Price"; Decimal)
        {
            Caption = 'Wholesale Price';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                VALIDATE("Discount %");
            end;
        }
        field(70001; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            trigger OnValidate()
            begin
                //LS
                "Direct Unit Cost" := "Wholesale Price" * (1 - "Discount %" / 100);
            end;
        }
        field(70002; "Net Cost Price"; Decimal)
        {
            Caption = 'Net Cost Price';
            DataClassification = ToBeClassified;
        }

        field(70003; "Net Price"; Decimal)
        {
            Caption = 'Net Price';
            DataClassification = ToBeClassified;
        }

        field(70005; "Description"; Text[150])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
}
