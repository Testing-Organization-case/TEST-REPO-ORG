tableextension 70078 ReplOutOfStockLogExt extends "LSC Replen. Out of Stock Log"
{
    fields
    {


        field(70001; "Division Name"; Text[100])
        {
            Caption = 'Division Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("LSC Division".Description where(Code = field("Division Code")));
        }
        field(70002; "Item Category Name"; Text[100])
        {
            Caption = 'Item Category Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Category".Description where(Code = field("Item Category Code")));
        }
        field(70003; "Retail Product Name"; Text[100])
        {
            Caption = 'Retail Product Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("LSC Retail Product Group".Description where(Code = field("Retail Product Code")));
        }
        field(70004; Description; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }

    }
}
