report 70019 "Reg. Put Away Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/RegPutAwayReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Registered Whse. Activity Hdr."; "Registered Whse. Activity Hdr.")
        {
            column(No_RegisteredWhseActivityHdr; "Registered Whse. Activity Hdr."."No.")
            {
            }
            column(LocationCode_RegisteredWhseActivityHdr; "Registered Whse. Activity Hdr."."Location Code")
            {
            }
            column(AssignedUserID_RegisteredWhseActivityHdr; "Registered Whse. Activity Hdr."."Assigned User ID")
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(Time; Time)
            {
            }
            column(AssignmentDate_RegisteredWhseActivityHdr; "Registered Whse. Activity Hdr."."Assignment Date")
            {
            }
            column(AssignmentTime_RegisteredWhseActivityHdr; "Registered Whse. Activity Hdr."."Assignment Time")
            {
            }
            column(SortingMethod_RegisteredWhseActivityHdr; "Registered Whse. Activity Hdr."."Sorting Method")
            {
            }
            column(RegisteringDate_RegisteredWhseActivityHdr; "Registered Whse. Activity Hdr."."Registering Date")
            {
            }
            column(NoPrinted_RegisteredWhseActivityHdr; "Registered Whse. Activity Hdr."."No. Printed")
            {
            }
            column(WhseActivityNo_RegisteredWhseActivityHdr; "Registered Whse. Activity Hdr."."Whse. Activity No.")
            {
            }
            dataitem("Registered Whse. Activity Line"; "Registered Whse. Activity Line")
            {
                DataItemLink = "Activity Type" = FIELD(Type), "No." = FIELD("No.");
                column(SourceNo_RegisteredWhseActivityLine; "Registered Whse. Activity Line"."Source No.")
                {
                }
                column(ItemNo_RegisteredWhseActivityLine; "Registered Whse. Activity Line"."Item No.")
                {
                }
                // column(VariantCode_RegisteredWhseActivityLine; "Registered Whse. Activity Line"."Variant Code")
                // {
                // }
                column(UnitofMeasureCode_RegisteredWhseActivityLine; "Registered Whse. Activity Line"."Unit of Measure Code")
                {
                }
                column(Description_RegisteredWhseActivityLine; "Registered Whse. Activity Line".Description)
                {
                }
                column(DueDate_RegisteredWhseActivityLine; "Registered Whse. Activity Line"."Due Date")
                {
                }
                column(BinCode_RegisteredWhseActivityLine; "Registered Whse. Activity Line"."Bin Code")
                {
                }
                column(ZoneCode_RegisteredWhseActivityLine; "Registered Whse. Activity Line"."Zone Code")
                {
                }
                column(ActionType_RegisteredWhseActivityLine; "Registered Whse. Activity Line"."Action Type")
                {
                }
                column(VendorName; VendorName)
                {
                }
                // column(VariantDescription; VariantDescription)
                // {
                // }
                column(PackagingInfo; PackagingInfo)
                {
                }
                column(Quantity_RegisteredWhseActivityLine; "Registered Whse. Activity Line".Quantity)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PurR.Reset;
                    PurR.SetRange("No.", "Registered Whse. Activity Line"."Source No.");
                    if PurR.FindFirst then
                        VendorName := PurR."Buy-from Vendor Name";


                    ItemR.Reset;
                    ItemR.SetRange("No.", "Registered Whse. Activity Line"."Item No.");
                    if ItemR.FindFirst then
                        PackagingInfo := ItemR."Packaging Info";
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        VendorName: Text;
        PurR: Record "Purchase Header";
        VariantDescription: Text;
        VariantR: Record "Item Variant";
        PackagingInfo: Text;
        ItemR: Record Item;
}

