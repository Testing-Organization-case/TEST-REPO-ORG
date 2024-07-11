tableextension 70083 ReplSalesHisAdjExt extends "LSC Replen. Sales Hist. Adj."
{
    fields
    {

        field(70001; Description; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
    }
}
