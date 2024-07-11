page 70007 InputLongTextTest
{
    SourceTable = "Payment Terms";
    ApplicationArea = ALl;
    layout
    {
        area(content)
        {
            field("Search Terms"; MyText)
            {
                MultiLine = true;
            }
        }
    }

    actions
    {
    }

    var
        MyText: Text;

    [Scope('OnPrem')]
    procedure SetText(Text_Params: Text)
    begin
        MyText := Text_Params;
    end;

    [Scope('OnPrem')]
    procedure GetText(): Text
    begin
        exit(MyText);
    end;
}

