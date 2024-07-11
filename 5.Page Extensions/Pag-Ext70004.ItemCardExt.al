pageextension 70004 ItemCardExt extends "Item Card"     //Created By MK
{
    actions
    {
        addafter(Dimensions)
        {
            action("Cross Re&ferences")
            {
                Image = Change;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                RunObject = Page "Item Reference Entries";
                RunPageLink = "Item No." = FIELD("No.");
            }
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
                ApplicationArea = Basic, Suite;
                Caption = 'Attributes';
                Image = Category;
                ToolTip = 'View or edit the item''s attributes, such as color, size, or other characteristics that help to describe the item.';

                trigger OnAction()
                begin
                    PAGE.RunModal(PAGE::"Item Attribute ValueEditorNWMM", Rec);
                    CurrPage.SaveRecord();
                    CurrPage.ItemAttributesFactbox.PAGE.LoadItemAttributesData(Rec."No.");
                end;
            }
        }
    }
}
