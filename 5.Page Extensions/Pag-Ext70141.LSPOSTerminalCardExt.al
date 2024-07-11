pageextension 70141 LSPOSTerminalCardExt extends "LSC POS Terminal Card"        //Created By MK
{
    layout
    {

        addafter(Printing)
        {
            group("NaviWorld Myanmar Customization")
            {
                group("POS Printing")
                {
                    field("Show VAT Code in Receipt Line"; Rec."Show VAT Code in Receipt Line")
                    {
                        ApplicationArea = ALl;
                    }
                    field("Show Price Check Line"; Rec."Show Price Check Line")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
}
