report 70026 "Warehouse Shipment Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/WarehouseShipmentReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Posted Whse. Shipment Header"; "Posted Whse. Shipment Header")
        {
            dataitem("Posted Whse. Shipment Line"; "Posted Whse. Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                column(SourceNo_PostedWhseShipmentLine; "Posted Whse. Shipment Line"."Source No.")
                {
                }
                column(ItemNo_PostedWhseShipmentLine; "Posted Whse. Shipment Line"."Item No.")
                {
                }
                column(Quantity_PostedWhseShipmentLine; "Posted Whse. Shipment Line".Quantity)
                {
                }
                column(UnitofMeasureCode_PostedWhseShipmentLine; "Posted Whse. Shipment Line"."Unit of Measure Code")
                {
                }
                column(VariantCode_PostedWhseShipmentLine; "Posted Whse. Shipment Line"."Variant Code")
                {
                }
                column(Description_PostedWhseShipmentLine; "Posted Whse. Shipment Line".Description)
                {
                }
                column(PackagingInfo_PostedWhseShipmentLine; "Posted Whse. Shipment Line"."Packaging Info")
                {
                }
                column(VatiantDescriptions_PostedWhseShipmentLine; "Posted Whse. Shipment Line"."Vatiant Descriptions")
                {
                }
                dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
                {
                    DataItemLink = "Transfer Order No." = FIELD("Source No."), "No." = FIELD("Posted Source No.");
                    column(TransferTo1; TransferTo[1])
                    {
                    }
                    column(TransferTo2; TransferTo[2])
                    {
                    }
                    column(TransferTo3; TransferTo[3])
                    {
                    }
                    column(TransferTo4; TransferTo[4])
                    {
                    }
                    column(TransferFrom1; TransferFrom[1])
                    {
                    }
                    column(TransferFrom2; TransferFrom[2])
                    {
                    }
                    column(TransferFrom3; TransferFrom[3])
                    {
                    }
                    column(TransferFrom4; TransferFrom[4])
                    {
                    }
                    column(ShipmentNo_TransferShipmentHeader; "Transfer Shipment Header"."Shipment No")
                    {
                    }
                    column(PostingDate_TransferShipmentHeader; "Transfer Shipment Header"."Posting Date")
                    {
                    }
                    column(ShipmentDate_TransferShipmentHeader; "Transfer Shipment Header"."Shipment Date")
                    {
                    }
                    column(InTransitCode_TransferShipmentHeader; "Transfer Shipment Header"."In-Transit Code")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        //For Transfer To

                        CountryR.Reset;
                        CountryR.SetRange(Code, "Transfer Shipment Header"."Trsf.-to Country/Region Code");
                        if CountryR.FindSet then
                            repeat
                                CountryRegionT := CountryR.Name;
                            until CountryR.Next = 0;

                        TransferTo[1] := "Transfer Shipment Header"."Transfer-to Name";
                        TransferTo[2] := "Transfer Shipment Header"."Transfer-to Address";
                        TransferTo[3] := "Transfer Shipment Header"."Transfer-to City" + ',' + "Transfer Shipment Header"."Transfer-to Post Code";
                        TransferTo[4] := CountryRegionT;
                        CompressArray(TransferTo);

                        //For Transfer From

                        CountryR.Reset;
                        CountryR.SetRange(Code, "Transfer Shipment Header"."Trsf.-from Country/Region Code");
                        if CountryR.FindSet then
                            repeat
                                CountryRegionF := CountryR.Name;
                            until CountryR.Next = 0;

                        TransferFrom[1] := "Transfer Shipment Header"."Transfer-from Name";
                        TransferFrom[2] := "Transfer Shipment Header"."Transfer-from Address";
                        TransferFrom[3] := "Transfer Shipment Header"."Transfer-from City" + ',' + "Transfer Shipment Header"."Transfer-from Post Code";
                        TransferFrom[4] := CountryRegionF;
                        CompressArray(TransferFrom);
                    end;
                }
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
        TransferTo: array[4] of Code[250];
        CountryRegionT: Text;
        CountryR: Record "Country/Region";
        CountryRegionF: Text;
        TransferFrom: array[4] of Code[250];
}

