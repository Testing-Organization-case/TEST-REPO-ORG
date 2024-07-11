pageextension 70022 LSCHierarRelationCardExt extends "LSC Hierar. Relation Card"            //Created by MK
{
    layout
    {
        addafter("Show Details (Right)")
        {
            field("Last Modified User"; Rec."Last Modified User")
            {
                ApplicationArea = All;
            }
            field("Last Modified Date"; Rec."Last Modified Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Add Relation (Active)")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
        modify("Add Relation (Exclusion)")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
        modify("Remove Relation")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
        modify("Remove Relation (preserve child relations)")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
        modify("Remove all Relations")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
        modify("Update View")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
        modify("Reverse Left and Right Hier.")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
        modify("Update Item Distribution ")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
        modify("Update Data Profiles")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
        modify("Update Redist. Matrix")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
        modify("Show Redist. Matrix")
        {
            trigger OnBeforeAction()
            begin
                Rec."Last Modified Date" := CurrentDateTime;
                Rec."Last Modified User" := UserId;
            end;
        }
    }
}
