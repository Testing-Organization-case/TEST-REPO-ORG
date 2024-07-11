page 70040 "DMS Setup"
{
    SourceTable = "DMS Setup";
    ApplicationArea = ALl;
    PageType = Card;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group("API Setup")
            {
                field(APIPublisher; Rec.APIPublisher)
                {
                }
                field(APIGroup; Rec.APIGroup)
                {
                }
                field(APIVersion; Rec.APIVersion)
                {
                }
            }
            group(Session)
            {
                field("Session Timeout Interval(Min)"; Rec."Session Timeout Interval")
                {
                }
            }
            group("Instance Information")
            {
                field("Server Name"; Rec."Server Name")
                {
                }
                field("Instance Name"; Rec."Instance Name")
                {
                }
                field("API Port"; Rec."API Port")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin

        if Rec.Count = 0 then begin
            Rec.Insert;
        end;
    end;
}

