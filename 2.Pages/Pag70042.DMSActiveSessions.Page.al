page 70042 "DMS Active Sessions"
{
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "DMS Active Sessions";
    ApplicationArea = ALl;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("User Name"; Rec."User Name")
                {
                }
                field("Device Name"; Rec."Device Name")
                {
                }
                field("Device Type"; Rec."Device Type")
                {
                }
                field("IMEI Number"; Rec."IMEI Number")
                {
                }
                field("Login At"; Rec."Login At")
                {
                }
                field("Expired At"; Rec."Expired At")
                {
                }
                field(Token; Rec.Token)
                {
                }
            }
        }
    }

    actions
    {
    }
}

