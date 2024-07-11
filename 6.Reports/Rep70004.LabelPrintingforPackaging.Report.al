report 70004 "Label Printing for Packaging"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/LabelPrintingforPackaging.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Packaging Information"; "Packaging Information")
        {
            column(PackRefNo; "Packaging Information"."Packaging Ref No.")
            {
            }
            column(ShipmentDate; ShipmentDate)
            {
            }
            column(Address_Comp; Address)
            {
            }
            column(PhoneNo_Comp; PhoneNo)
            {
            }
            column(Priority; PriorityP)
            {
            }
            column(ShippingAddress; ShippingAddress)
            {
            }
            column(OrderNo; OrderNo)
            {
            }
            column(Shipping_Service; ShippingService)
            {
            }
            column(TrackingNo; TrackingNo)
            {
            }
            column(ShippingNotes; ShippingNotes)
            {
            }
            column(ItemNo; "Packaging Information"."Item No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                WarehouseShipmentHeader.Reset;
                WarehouseShipmentHeader.SetRange("No.", "Packaging Information"."Document No.");
                if WarehouseShipmentHeader.FindSet then
                    repeat
                        ShipmentDate := WarehouseShipmentHeader."Shipment Date";
                        ShippingService := WarehouseShipmentHeader."Shipping Agent Service Code";
                        PriorityP := WarehouseShipmentHeader.Priority;

                        LocationP.Reset;
                        LocationP.SetRange(Code, WarehouseShipmentHeader."Location Code");
                        if LocationP.FindSet then
                            repeat

                                Address := LocationP.Address + LocationP."Address 2";
                                PhoneNo := LocationP."Phone No.";

                            until LocationP.Next = 0;

                    until WarehouseShipmentHeader.Next = 0;


                WarehouseShipmentLine.Reset;
                WarehouseShipmentLine.SetRange("No.", "Packaging Information"."Document No.");
                if WarehouseShipmentLine.FindSet then
                    repeat

                        OrderNo := WarehouseShipmentLine."Source No.";

                        // Outbound Transfer
                        if WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Outbound Transfer" then begin
                            TransferHeader.Reset;
                            TransferHeader.SetRange("No.", WarehouseShipmentLine."Source No.");
                            if TransferHeader.FindFirst then begin
                                LocationP.Reset;
                                LocationP.SetRange(Code, TransferHeader."Transfer-to Code");
                                if LocationP.FindFirst then begin

                                    ShippingAddress := LocationP.Address + LocationP."Address 2" + LocationP."Post Code" + LocationP.City;

                                end; //IF LocationP.FINDFIRST THEN

                            end; //IF TransferShipmentHeader.FINDFIRST THEN
                        end; // IF WarehouseShipmentLine."Source Document" := WarehouseShipmentLine."Source Document"::"Outbound Transfer" THEN

                        // Sale Order
                        if WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Sales Order" then begin

                            SaleHeader.Reset;
                            SaleHeader.SetRange("No.", WarehouseShipmentLine."Source No.");
                            if SaleHeader.FindFirst then begin

                                ShippingAddress := SaleHeader."Sell-to Address" + SaleHeader."Sell-to Address 2" + SaleHeader."Sell-to Post Code" + SaleHeader."Sell-to City";

                            end;// IF SaleHeader.FINDFIRST THEN
                        end; // IF WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Sales Order" THEN

                        // Purchase Order
                        if WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Purchase Order" then begin

                            PurchaseHeader.Reset;
                            PurchaseHeader.SetRange("No.", WarehouseShipmentLine."Source No.");
                            if PurchaseHeader.FindFirst then begin

                                ShippingAddress := PurchaseHeader."Ship-to Address" + PurchaseHeader."Ship-to Address 2" + PurchaseHeader."Ship-to Post Code" + PurchaseHeader."Ship-to City" + PurchaseHeader."Ship-to County";

                            end;// IF PurchaseHeader.FINDFIRST THEN
                        end; //  IF WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Purchase Order" THEN


                    until WarehouseShipmentLine.Next = 0;

                DetailPackagingInfo.Reset;
                DetailPackagingInfo.SetRange("Document No.", "Packaging Information"."Document No.");
                if DetailPackagingInfo.FindSet then
                    repeat

                        TrackingNo := DetailPackagingInfo."Tracking No.";
                        ShippingNotes := DetailPackagingInfo."Shipping Notes";

                    until DetailPackagingInfo.Next = 0;
            end;
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
        LocationP: Record Location;
        Address: Text;
        PhoneNo: Text;
        ShipmentDate: Date;
        PriorityP: Text;
        ShippingAddress: Text;
        OrderNo: Text;
        PackagingReferenceNo: Code[100];
        ShippingService: Code[100];
        TrackingNo: Code[100];
        ShippingNotes: Text;
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        DetailPackagingInfo: Record "Details Packaging Info.";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        SaleHeader: Record "Sales Header";
        TransferHeader: Record "Transfer Header";
        PurchaseHeader: Record "Purchase Header";
}

