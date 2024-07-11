pageextension 70005 ItemListExt extends "Item List"         //Created By MK
{

    layout
    {

        addafter("No.")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        modify(FilterByAttributes)
        {
            Caption = 'NAV Filter by Attributes';
        }
        modify(ClearAttributes)
        {
            Caption = 'NAV Clear Attributes Filter';
        }
        modify(Attributes)
        {
            Visible = false;
        }
        addafter(Attributes)
        {
            action(AttributesNWMM)
            {
                AccessByPermission = TableData "Item Attribute" = R;
                ApplicationArea = Suite;
                Caption = 'Attributes';
                Image = Category;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Category4;
                Scope = Repeater;
                ToolTip = 'View or edit the item''s attributes, such as color, size, or other characteristics that help to describe the item.';

                trigger OnAction()
                begin
                    PAGE.RunModal(PAGE::"Item Attribute ValueEditorNWMM", Rec);
                    CurrPage.SaveRecord();
                    CurrPage.ItemAttributesFactBox.PAGE.LoadItemAttributesData(Rec."No.");
                end;
            }
        }
    }

}
