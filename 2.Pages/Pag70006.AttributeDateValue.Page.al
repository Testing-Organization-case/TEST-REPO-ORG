page 70006 "Attribute Date Value"
{
    PageType = StandardDialog;
    SourceTable = "LSC Attribute Value";
    SourceTableTemporary = true;
    ApplicationArea = ALl;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Date Value"; Rec."Date Value")
                {

                    trigger OnValidate()
                    begin
                        SetDate(Rec."Date Value");
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin

        Rec.Insert();
    end;

    var
        DateG: Date;

    [Scope('OnPrem')]
    local procedure SetDate(DateP: Date)
    begin
        DateG := DateP;
    end;

    [Scope('OnPrem')]
    procedure GetDate(): Date
    begin
        exit(DateG);
    end;
}

