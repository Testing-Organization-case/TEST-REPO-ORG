report 70006 "Transfer Shipment Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '7.Layouts/TransferShipmentReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            column(TransfertoAddress_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Address 2")
            {
            }
            column(TransfertoCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(TransfertoName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(TransfertoPostCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Post Code")
            {
            }
            column(No_TransferShipmentHeader; "Transfer Shipment Header"."No.")
            {
            }
            column(TransferfromCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Code")
            {
            }
            column(TransferfromName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Name")
            {
            }
            column(TransferfromPostCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Post Code")
            {
            }
            column(TransferfromAddress_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Address")
            {
            }
            column(TransferfromAddress2_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Address 2")
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(PostingDate_TransferShipmentHeader; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(InTransitCode_TransferShipmentHeader; "Transfer Shipment Header"."In-Transit Code")
            {
            }
            column(ShipmentMethodCode_TransferShipmentHeader; "Transfer Shipment Header"."Shipment Method Code")
            {
            }
            column(ShipmentDate_TransferShipmentHeader; "Transfer Shipment Header"."Shipment Date")
            {
            }
            column(ShipMethod; ShipMethod)
            {
            }
            column(TransferfromCity_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from City")
            {
            }
            column(TransfertoCity_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to City")
            {
            }
            column(CountryRegionT; CountryRegionT)
            {
            }
            column(CountryRegionF; CountryRegionF)
            {
            }
            column(CurrReportPageNoCaptionLbl; CurrReportPageNoCaptionLbl)
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(UnitofMeasure_TransferShipmentLine; "Transfer Shipment Line"."Unit of Measure")
                {
                }
                column(Description_TransferShipmentLine; "Transfer Shipment Line".Description)
                {
                }

                column(ItemNo_TransferShipmentLine; "Transfer Shipment Line"."Item No.")
                {
                }
                column(Quantity_TransferShipmentLine; "Transfer Shipment Line".Quantity)
                {
                }

                column(PackagingInfo_TransferShipmentLine; "Transfer Shipment Line"."Packaging Info")
                {
                }
                column(PackagingInfo; PackagingInfo)
                {
                }
                column(LineNo_TransferShipmentLine; "Transfer Shipment Line"."Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    ItemR.Reset;
                    ItemR.SetRange("No.", "Transfer Shipment Line"."Item No.");
                    if ItemR.FindFirst then begin
                        PackagingInfo := ItemR."Packaging Info";
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ShipMR.Reset;
                ShipMR.SetRange(Code, "Transfer Shipment Header"."Shipment Method Code");
                if ShipMR.FindFirst then begin
                    ShipMethod := ShipMR.Description;
                end;

                CountryR.Reset;
                CountryR.SetRange(Code, "Transfer Shipment Header"."Trsf.-from Country/Region Code");
                if CountryR.FindFirst then begin
                    CountryRegionF := CountryR.Name;
                end;

                CountryR.Reset;
                CountryR.SetRange(Code, "Transfer Shipment Header"."Trsf.-to Country/Region Code");
                if CountryR.FindFirst then begin
                    CountryRegionT := CountryR.Name;
                end;
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
        QtyCalc: Decimal;
        UOMCalc: Decimal;
        VariantDescription: Text;
        ItemVariantRec: Record "Item Variant";
        PackagingInfo: Text;
        ItemR: Record Item;
        ShipMethod: Text;
        ShipMR: Record "Shipment Method";
        CountryRegionF: Text;
        CountryR: Record "Country/Region";
        CountryRegionT: Text;
        CurrReportPageNoCaptionLbl: Label 'Page';
}

