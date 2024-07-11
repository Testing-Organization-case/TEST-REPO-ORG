codeunit 70001 StandardCodeunitExt
{
    EventSubscriberInstance = Manual;
    //CodeUnit 5773
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Transfer Release", OnBeforeRelease, '', false, false)]
    procedure InitializeWhseRequestNwmm(var TransferHeader: Record "Transfer Header")
    var
        WarehouseRequest: Record "Warehouse Request";
    begin
        WarehouseRequest."To Destination" := TransferHeader."Transfer-to Code";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnUpdateTempBinContentBufferOnBeforeInsert, '', false, false)]
    procedure UpdateTempBinContentBufferNwmm(var TempBinContentBuffer: Record "Bin Content Buffer" temporary; WarehouseActivityLine: Record "Warehouse Activity Line")
    begin
        TempBinContentBuffer."Lot No." := WarehouseActivityLine."Lot No.";
        TempBinContentBuffer."Serial No." := WarehouseActivityLine."Serial No.";
    end;

    // Created By MK 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", OnFromTransLine2ShptLineOnAfterInitNewLine, '', false, false)]
    local procedure AddPackageInfo(var WhseShptLine: Record "Warehouse Shipment Line"; WhseShptHeader: Record "Warehouse Shipment Header"; TransferLine: Record "Transfer Line")
    begin
        WhseShptLine."Packaging Info" := TransferLine."Packaging Info";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", OnTransLine2ReceiptLineOnAfterInitNewLine, '', false, false)]
    local procedure AddPackInfo(var WhseReceiptLine: Record "Warehouse Receipt Line"; WhseReceiptHeader: Record "Warehouse Receipt Header"; TransferLine: Record "Transfer Line")
    begin
        WhseReceiptLine."Packaging Info" := TransferLine."Packaging Info";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", OnAfterInitFromSalesLine, '', false, false)]
    local procedure OnAfterInitFromSalesLine(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line")
    begin
        SalesInvLine."Packaging Info" := SalesLine."Packaging Info";
    end;



}
