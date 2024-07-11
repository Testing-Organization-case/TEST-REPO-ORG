report 70005 "Label Printing for PostPckg."
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/LabelPrintingforPostPckg.rdl';
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

                PostedWhShiHeader.Reset;
                PostedWhShiHeader.SetRange("Whse. Shipment No.", "Packaging Information"."Document No.");
                if PostedWhShiHeader.FindSet then
                    repeat
                        ShipmentDate := PostedWhShiHeader."Shipment Date";
                        ShippingService := PostedWhShiHeader."Shipping Agent Service Code";
                        PriorityP := PostedWhShiHeader.Priority;

                        LocationP.Reset;
                        LocationP.SetRange(Code, PostedWhShiHeader."Location Code");
                        if LocationP.FindSet then
                            repeat

                                Address := LocationP.Address + LocationP."Address 2";
                                PhoneNo := LocationP."Phone No.";

                            until LocationP.Next = 0;

                    until PostedWhShiHeader.Next = 0;


                PostedWhShiLine.Reset;
                PostedWhShiLine.SetRange("Whse. Shipment No.", "Packaging Information"."Document No.");
                if PostedWhShiLine.FindSet then
                    repeat

                        OrderNo := PostedWhShiLine."Source No.";

                        // Outbound Transfer
                        if PostedWhShiLine."Source Document" = PostedWhShiLine."Source Document"::"Outbound Transfer" then begin
                            TransferShipHeader.Reset;
                            TransferShipHeader.SetRange("Transfer Order No.", PostedWhShiLine."Source No.");
                            if TransferShipHeader.FindFirst then begin
                                LocationP.Reset;
                                LocationP.SetRange(Code, TransferShipHeader."Transfer-to Code");
                                if LocationP.FindFirst then begin

                                    ShippingAddress := LocationP.Address + LocationP."Address 2" + LocationP."Post Code" + LocationP.City;

                                end; //IF LocationP.FINDFIRST THEN

                            end; //IF TransferShipmentHeader.FINDFIRST THEN
                        end; // IF WarehouseShipmentLine."Source Document" := WarehouseShipmentLine."Source Document"::"Outbound Transfer" THEN

                        // Sale Order
                        if PostedWhShiLine."Source Document" = PostedWhShiLine."Source Document"::"Sales Order" then begin

                            SalesShipmentHeader.Reset;
                            SalesShipmentHeader.SetRange("Order No.", PostedWhShiLine."Source No.");
                            if SalesShipmentHeader.FindFirst then begin

                                ShippingAddress := SalesShipmentHeader."Sell-to Address" + SalesShipmentHeader."Sell-to Address 2" + SalesShipmentHeader."Sell-to Post Code" + SalesShipmentHeader."Sell-to City";

                            end;// IF SaleHeader.FINDFIRST THEN
                        end; // IF WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Sales Order" THEN

                    // Purchase Order
                    //     IF PostedWhShiLine."Source Document" = PostedWhShiLine."Source Document"::"Purchase Order" THEN
                    //     BEGIN
                    //
                    //       PurchaseHeader.RESET;
                    //       PurchaseHeader.SETRANGE("No.",PostedWhShiLine."Source No.");
                    //       IF PurchaseHeader.FINDFIRST THEN
                    //         BEGIN
                    //
                    //             ShippingAddress := PurchaseHeader."Ship-to Address" + PurchaseHeader."Ship-to Address 2" + PurchaseHeader."Ship-to Post Code" + PurchaseHeader."Ship-to City" + PurchaseHeader."Ship-to County";
                    //
                    //           END;// IF PurchaseHeader.FINDFIRST THEN
                    //       END; //  IF WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Purchase Order" THEN


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
        PurchaseHeader: Record "Purchase Header";
        PostedWhShiLine: Record "Posted Whse. Shipment Line";
        TransferHeader: Integer;
        SalesShipmentHeader: Record "Sales Shipment Header";
        TransferShipHeader: Record "Transfer Shipment Header";
        PostedWhShiHeader: Record "Posted Whse. Shipment Header";
}

