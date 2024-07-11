page 70036 "Check User"
{
    PageType = StandardDialog;
    SourceTable = "Tablet User";
    SourceTableTemporary = true;
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("User Name"; UserNameG)
                {
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        UserNameG := UpperCase(UserNameG);
                    end;
                }
                field(Password; PasswordG)
                {
                    ExtendedDatatype = Masked;
                    ShowMandatory = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin

        Rec.Insert;
    end;

    var
        UserNameG: Text;
        PasswordG: Text;

    //[Scope('Internal')]
    procedure GetUser(): Text
    begin
        exit(UserNameG);
    end;

    //[Scope('Internal')]
    procedure GetPassword(): Text
    begin
        exit(PasswordG);
    end;
}

