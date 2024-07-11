report 70016 "Picking Report Word"
{
    RDLCLayout = '7.Layouts/PickingReportWord.rdl';
    WordLayout = '7.Layouts/PickingReportWord.docx';
    DefaultLayout = Word;
    WordMergeDataItem = "Warehouse Activity Header";
    ApplicationArea = All;

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(Time; Format(Time, 0, 0))
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
            column(Page_Lbl; PageCaptionLbl)
            {
            }
            dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
            {
                DataItemLink = "Activity Type" = FIELD(Type), "No." = FIELD("No.");
                column(SourceDocument_Line; "Warehouse Activity Line"."Source Document")
                {
                }
                column(SourceNo_Line; "Warehouse Activity Line"."Source No.")
                {
                }
                column(DestinationType_Line; "Warehouse Activity Line"."Destination Type")
                {
                }
                column(DestinationNo_Line; "Warehouse Activity Line"."Destination No.")
                {
                }
                column(DueDate_Line; Format("Warehouse Activity Line"."Due Date", 0, 1))
                {
                }
                column(ActionType_Line; "Warehouse Activity Line"."Action Type")
                {
                }
                column(Description_Line; "Warehouse Activity Line".Description)
                {
                }
                column(ItemNo_Line; "Warehouse Activity Line"."Item No.")
                {
                }
                column(VariantCode_Line; "Warehouse Activity Line"."Variant Code")
                {
                }
                // column(VariantDescription_Line; "Warehouse Activity Line"."Variant Description")
                // {
                // }
                column(ZoneCode_Line; "Warehouse Activity Line"."Zone Code")
                {
                }
                column(BinCode_Line; "Warehouse Activity Line"."Bin Code")
                {
                }
                column(QtytoHandle_Line; "Warehouse Activity Line"."Qty. to Handle")
                {
                }
                column(QtyBase_Line; "Warehouse Activity Line"."Qty. (Base)")
                {
                }
                column(Quantity_Line; "Warehouse Activity Line".Quantity)
                {
                }
                column(UnitofMeasureCode_Line; "Warehouse Activity Line"."Unit of Measure Code")
                {
                }
                column(PackagingInfo_Line; "Warehouse Activity Line"."Packaging Info")
                {
                }
                // column(VaraintDescription; VaraintDescription)
                // {
                // }
                column(PackagingInfo; PackagingInfo)
                {
                }
                column(WhseDocumentNo_Line; "Warehouse Activity Line"."Whse. Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //GetVariantDescription;
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
        PageLbl: Label 'Page %1', Comment = '%1 = Page No.';
        PageCaptionLbl: Label 'Page';



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

