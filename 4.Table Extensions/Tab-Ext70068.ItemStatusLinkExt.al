tableextension 70068 ItemStatusLinkExt extends "LSC Item Status Link"
{
    fields
    {

        field(70001; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = ToBeClassified;
        }
        field(70002; "Modified by"; Code[30])
        {
            Caption = 'Modified by';
            DataClassification = ToBeClassified;
        }
        field(70003; Priority; Boolean)
        {
            Caption = 'Priority';
            DataClassification = ToBeClassified;
        }


    }
    trigger OnModify()
    begin
        "Modified by" := USERID;
    end;


}
