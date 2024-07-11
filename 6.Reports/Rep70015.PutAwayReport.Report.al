report 70015 "Put Away Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/PutAwayReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(Time; Time)
            {
            }
            column(No_WarehouseActivityHeader; "Warehouse Activity Header"."No.")
            {
            }
            column(LocationCode_WarehouseActivityHeader; "Warehouse Activity Header"."Location Code")
            {
            }
            column(AssignedUserID_WarehouseActivityHeader; "Warehouse Activity Header"."Assigned User ID")
            {
            }
            column(CurrReportPageNoCaptionLbl; CurrReportPageNoCaptionLbl)
            {
            }
            dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
            {
                DataItemLink = "Activity Type" = FIELD(Type), "No." = FIELD("No.");
                column(SourceNo_WarehouseActivityLine; "Warehouse Activity Line"."Source No.")
                {
                }
                column(DueDate_WarehouseActivityLine; "Warehouse Activity Line"."Due Date")
                {
                }
                column(VariantCode_WarehouseActivityLine; "Warehouse Activity Line"."Variant Code")
                {
                }
                column(ItemNo_WarehouseActivityLine; "Warehouse Activity Line"."Item No.")
                {
                }
                column(Description_WarehouseActivityLine; "Warehouse Activity Line".Description)
                {
                }
                column(UnitofMeasureCode_WarehouseActivityLine; "Warehouse Activity Line"."Unit of Measure Code")
                {
                }
                column(QtytoHandle_WarehouseActivityLine; "Warehouse Activity Line"."Qty. to Handle")
                {
                }
                column(BinCode_WarehouseActivityLine; "Warehouse Activity Line"."Bin Code")
                {
                }
                column(ZoneCode_WarehouseActivityLine; "Warehouse Activity Line"."Zone Code")
                {
                }
                column(ActionType_WarehouseActivityLine; "Warehouse Activity Line"."Action Type")
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
                column(Remark_WarehouseActivityLine; "Warehouse Activity Line".Remark)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PurR.Reset;
                    PurR.SetRange("No.", "Warehouse Activity Line"."Source No.");
                    if PurR.FindFirst then
                        VendorName := PurR."Buy-from Vendor Name";



                    ItemR.Reset;
                    ItemR.SetRange("No.", "Warehouse Activity Line"."Item No.");
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
        CurrReportPageNoCaptionLbl: Label 'Page';
        VariantDescription: Text;
        VariantR: Record "Item Variant";
        PackagingInfo: Text;
        ItemR: Record Item;
}

