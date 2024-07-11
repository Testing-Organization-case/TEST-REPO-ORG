report 70007 "Picking Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/PickingReport.rdl';
    WordMergeDataItem = "Warehouse Activity Header";
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
            column(AssignmentDate_WarehouseActivityHeader; "Warehouse Activity Header"."Assignment Date")
            {
            }
            column(LocationCode_WarehouseActivityHeader; "Warehouse Activity Header"."Location Code")
            {
            }
            column(AssignmentTime_WarehouseActivityHeader; "Warehouse Activity Header"."Assignment Time")
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
                column(SourceDocument_WarehouseActivityLine; "Warehouse Activity Line"."Source Document")
                {
                }
                column(SourceNo_WarehouseActivityLine; "Warehouse Activity Line"."Source No.")
                {
                }
                column(DestinationType_WarehouseActivityLine; "Warehouse Activity Line"."Destination Type")
                {
                }
                column(DestinationNo_WarehouseActivityLine; "Warehouse Activity Line"."Destination No.")
                {
                }
                column(DueDate_WarehouseActivityLine; "Warehouse Activity Line"."Due Date")
                {
                }
                column(ActionType_WarehouseActivityLine; "Warehouse Activity Line"."Action Type")
                {
                }
                column(Description_WarehouseActivityLine; "Warehouse Activity Line".Description)
                {
                }
                column(ItemNo_WarehouseActivityLine; "Warehouse Activity Line"."Item No.")
                {
                }

                column(ZoneCode_WarehouseActivityLine; "Warehouse Activity Line"."Zone Code")
                {
                }
                column(BinCode_WarehouseActivityLine; "Warehouse Activity Line"."Bin Code")
                {
                }
                column(QtytoHandle_WarehouseActivityLine; "Warehouse Activity Line"."Qty. to Handle")
                {
                }
                column(QtyBase_WarehouseActivityLine; "Warehouse Activity Line"."Qty. (Base)")
                {
                }
                column(Quantity_WarehouseActivityLine; "Warehouse Activity Line".Quantity)
                {
                }
                column(UnitofMeasureCode_WarehouseActivityLine; "Warehouse Activity Line"."Unit of Measure Code")
                {
                }
                column(PackagingInfo_WarehouseActivityLine; "Warehouse Activity Line"."Packaging Info")
                {
                }
                column(VaraintDescription; VaraintDescription)
                {
                }
                column(PackagingInfo; PackagingInfo)
                {
                }
                column(WhseDocumentNo_WarehouseActivityLine; "Warehouse Activity Line"."Whse. Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    GetPackagingInfo;
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
        VariantR: Record "Item Variant";
        VaraintDescription: Text;
        ItemR: Record Item;
        PackagingInfo: Text;
        CurrReportPageNoCaptionLbl: Label 'Page';
        WareActiviyLine: Record "Warehouse Activity Line";
        WareActivityHeader: Record "Warehouse Activity Header";



    local procedure GetPackagingInfo()
    begin
        ItemR.Reset;
        ItemR.SetRange("No.", "Warehouse Activity Line"."Item No.");
        if ItemR.FindFirst then begin
            PackagingInfo := ItemR."Packaging Info";
        end else begin
            PackagingInfo := '';
        end;
    end;
}

