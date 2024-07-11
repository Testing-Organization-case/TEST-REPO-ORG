page 70057 PeriodicDiscountNwmm
{
    Editable = false;
    PageType = List;
    SourceTable = PeriodicDiscountNwmm;
    SourceTableTemporary = false;
    SourceTableView = WHERE("Finished Mark" = CONST(true));
    ApplicationArea = ALl;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Price Group"; Rec."Price Group")
                {
                }

                field("Offer Type"; Rec."Offer Type")
                {
                }
                field("Offer No."; Rec."Offer No.")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field(Priority; Rec.Priority)
                {
                }
                field("Block Infocode Discount"; Rec."Block Infocode Discount")
                {
                }
                field("Block Sales Commission"; Rec."Block Sales Commission")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Validation Period ID"; Rec."Validation Period ID")
                {
                }
                field("Validation Description"; Rec."Validation Description")
                {
                }
                field(DiscountTypeH; Rec.DiscountTypeH)
                {
                    Caption = 'H-DiscountType';
                }
                field(BenefitCode; Rec.BenefitCode)
                {
                }
                field("BenefitType"; Rec.BenefitType)
                {
                }
                field(BenefitDescription; Rec.BenefitDescription)
                {
                }
                field("Trigger Code"; Rec."Trigger Code")
                {
                }
                field(InfoDescription; Rec.InfoDescription)
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Use Trans. Line Time"; Rec."Use Trans. Line Time")
                {
                }
                field("Ending Date"; Rec."Ending Date")
                {
                }
                field("Price Group Filter"; Rec."Price Group Filter")
                {
                }
                field("Disc. Validation Period Filter"; Rec."Disc. Validation Period Filter")
                {
                }
                field("Block Periodic Discount"; Rec."Block Periodic Discount")
                {
                }
                field("Price Group Validation"; Rec."Price Group Validation")
                {
                }
                field("Sales Type Filter"; Rec."Sales Type Filter")
                {
                }
                field("Sales (Qty.)"; Rec."Sales (Qty.)")
                {
                }
                field("Sales (LCY)"; Rec."Sales (LCY)")
                {
                }
                field("COGS (LCY)"; Rec."COGS (LCY)")
                {
                }
                field("Discount Type"; Rec."Discount Type")
                {
                }
                field("Same/Diff. M&M Lines"; Rec."Same/Diff. M&M Lines")
                {
                }
                field("No. of Lines to Trigger"; Rec."No. of Lines to Trigger")
                {
                }
                field("Deal Price Value"; Rec."Deal Price Value")
                {
                }
                field("Discount % Value"; Rec."Discount % Value")
                {
                }
                field("Discount Amount Value"; Rec."Discount Amount Value")
                {
                }
                field("No. of Least Expensive Items"; Rec."No. of Least Expensive Items")
                {
                }
                field("Disc. % of Least Expensive"; Rec."Disc. % of Least Expensive")
                {
                }
                field("Skip Least Exp. Customer Opt."; Rec."Skip Least Exp. Customer Opt.")
                {
                }
                field("No. of Times Applicable"; Rec."No. of Times Applicable")
                {
                }
                field("No. of Line Groups"; Rec."No. of Line Groups")
                {
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                }
                field("Amount to Trigger"; Rec."Amount to Trigger")
                {
                }
                field("Member Value"; Rec."Member Value")
                {
                }
                field("Pop-up Line 1"; Rec."Pop-up Line 1")
                {
                }
                field("Pop-up Line 2"; Rec."Pop-up Line 2")
                {
                }
                field("Pop-up Line 3"; Rec."Pop-up Line 3")
                {
                }
                field("Discount Tracking No."; Rec."Discount Tracking No.")
                {
                }
                field("Valid From Before Exp. Date"; Rec."Valid From Before Exp. Date")
                {
                }
                field("Valid To Before Exp. Date"; Rec."Valid To Before Exp. Date")
                {
                }
                field("Planned Demand Type"; Rec."Planned Demand Type")
                {
                }
                field("Planned Demand"; Rec."Planned Demand")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Coupon Code"; Rec."Coupon Code")
                {
                }
                field("Coupon Qty Needed"; Rec."Coupon Qty Needed")
                {
                }
                field("Member Type"; Rec."Member Type")
                {
                }
                field("Member Attribute"; Rec."Member Attribute")
                {
                }
                field("Member Attribute Value"; Rec."Member Attribute Value")
                {
                }
                field("Block Manual Price Change"; Rec."Block Manual Price Change")
                {
                }
                field("Block Line Discount Offer"; Rec."Block Line Discount Offer")
                {
                }
                field("Block Total Discount Offer"; Rec."Block Total Discount Offer")
                {
                }
                field("Block Tender Type Discount"; Rec."Block Tender Type Discount")
                {
                }
                field("Block Member Points"; Rec."Block Member Points")
                {
                }
                field("Block Printing"; Rec."Block Printing")
                {
                }
                field("Buyer ID"; Rec."Buyer ID")
                {
                }
                field("Buyer Group Code"; Rec."Buyer Group Code")
                {
                }
                field("Maximum Discount Amount"; Rec."Maximum Discount Amount")
                {
                }
                field("Tender Type Code"; Rec."Tender Type Code")
                {
                }
                field("Tender Type Value"; Rec."Tender Type Value")
                {
                }
                field("Prompt for Action"; Rec."Prompt for Action")
                {
                }
                field("Tender Offer %"; Rec."Tender Offer %")
                {
                }
                field("Tender Offer Amount"; Rec."Tender Offer Amount")
                {
                }
                field("Line Discount Group Code"; Rec."Line Discount Group Code")
                {
                }
                field("Line Discount Execution"; Rec."Line Discount Execution")
                {
                }
                field("Sequence Code"; Rec."Sequence Code")
                {
                }
                field("Sequence Function"; Rec."Sequence Function")
                {
                }
                field("Member Points"; Rec."Member Points")
                {
                }
                field(ItemNo; Rec.ItemNo)
                {
                }
                field(ItemDescription; Rec.ItemDescription)
                {
                    Caption = 'Item Description';
                }
                field("Triggers Pop-up on POS"; Rec."Triggers Pop-up on POS")
                {
                }
                field("Small Business Filter"; Rec."Small Business Filter")
                {
                }
                field("Standard Price Including VAT"; Rec."Standard Price Including VAT")
                {
                }
                field("Standard Price"; Rec."Standard Price")
                {
                }
                field("Prod. Group Category"; Rec."Prod. Group Category")
                {
                }
                field("Line Group"; Rec."Line Group")
                {
                }
                field("No. of Items Needed"; Rec."No. of Items Needed")
                {
                }
                field("Offer Price"; Rec."Offer Price")
                {
                }
                field("Offer Price Including VAT"; Rec."Offer Price Including VAT")
                {
                }
                field("Discount Amount Including VAT"; Rec."Discount Amount Including VAT")
                {
                }
                field("Variant Type"; Rec."Variant Type")
                {
                }
                field("Prompt at Scan"; Rec."Prompt at Scan")
                {
                }
                field("Header Type"; Rec."Header Type")
                {
                }
                field(Exclude; Rec.Exclude)
                {
                }
                field("Primary Key"; Rec."Primary Key")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Display Prompt"; Rec."Display Prompt")
                {
                }
                field("Explanatory Header Text"; Rec."Explanatory Header Text")
                {
                }
                field("Min. Selection"; Rec."Min. Selection")
                {
                }
                field("Max. Selection"; Rec."Max. Selection")
                {
                }
                field("Multiple Selection"; Rec."Multiple Selection")
                {
                }
                field("Selected Deal Line No."; Rec."Selected Deal Line No.")
                {
                }
                field("Selected Modifier Line No."; Rec."Selected Modifier Line No.")
                {
                }
                field("Modifier Added Amount"; Rec."Modifier Added Amount")
                {
                }
                field("Default Selection"; Rec."Default Selection")
                {
                }
                field("Show on Extra Request Only"; Rec."Show on Extra Request Only")
                {
                }
                field("Line Added Amount"; Rec."Line Added Amount")
                {
                }
                field("Deal Mod. Items with Min. Sel."; Rec."Deal Mod. Items with Min. Sel.")
                {
                }
                field("Deal Modifier Size Group"; Rec."Deal Modifier Size Group")
                {
                }
                field("Deal Mod. Size Gr. Index"; Rec."Deal Mod. Size Gr. Index")
                {
                }
                field("Receipt Printing"; Rec."Receipt Printing")
                {
                }
                field("Mobile - Display Required"; Rec."Mobile - Display Required")
                {
                }
                field("Line Specific"; Rec."Line Specific")
                {
                }
                field("Value Type"; Rec."Value Type")
                {
                }
                field(Value; Rec.Value)
                {
                }
                field("Finished Mark"; Rec."Finished Mark")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Multi Delete")
            {
                Caption = 'Multi Delete';
                Image = Delete;
                Promoted = true;

                trigger OnAction()
                begin
                    PeriodDiscount.Reset;
                    PeriodDiscount.SetRange(No, Rec.No);
                    CurrPage.SetSelectionFilter(PeriodDiscount);
                    if PeriodDiscount.FindFirst then
                        repeat
                            //MESSAGE('Hi');
                            PeriodDiscount.Delete;
                        until PeriodDiscount.Next = 0;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

    end;

    var
        PeriodDiscount: Record PeriodicDiscountNwmm;
}

