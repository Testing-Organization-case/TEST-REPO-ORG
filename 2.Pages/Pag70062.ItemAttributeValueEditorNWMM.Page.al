page 70062 "Item Attribute ValueEditorNWMM"
{
    PageType = StandardDialog;
    SourceTable = Item;
    Caption = 'Item Attribute Value Editor';
    Applicationarea = All;
    layout
    {
        area(content)
        {
            part(ItemAttributeValueList; "Item Attribute Value ListNWMM")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CurrPage.ItemAttributeValueList.PAGE.LoadAttributes(Rec."No.");
    end;
}

