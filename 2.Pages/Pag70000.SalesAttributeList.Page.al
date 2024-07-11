// page 70000 SalesAttributeList
// {
//     Caption = 'Attributes';
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "Sales Line";
//     SourceTableTemporary = true;
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Document No."; Rec."Document No.")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Line No."; Rec."Line No.")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(Type; Rec.Type)
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("No."; Rec."No.")
//                 {
//                     Editable = false;
//                 }
//                 field(Quantity; Rec.Quantity)
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Unit of Measure"; Rec."Unit of Measure")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Attribute Name"; Rec."Attribute Name")
//                 {
//                     Editable = false;
//                 }
//                 field(Value; Rec.Value)
//                 {
//                     Editable = false;
//                 }
//                 field("Attribute Type"; Rec."Attribute Type")
//                 {
//                     Editable = false;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     Caption = 'Item Description';
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin

//         GenerateSalesItemAttributes;
//     end;

//     var
//         SQDocumentNoG: Code[50];

//     [Scope('OnPrem')]
//     procedure GenerateSalesItemAttributes()
//     var
//         SalesLineL: Record "Sales Line";
//         LineCountL: Integer;
//         ItemNoL: Code[50];
//         ItemAttributeValueMappingL: Record "Item Attribute Value Mapping";
//         ItemAttributeL: Record "Item Attribute";
//         ItemAttributeValueL: Record "Item Attribute Value";
//     begin
//         if SQDocumentNoG <> '' then begin
//             SalesLineL.Reset();
//             SalesLineL.SetRange("Document No.", SQDocumentNoG);
//             SalesLineL.SetRange(Type, SalesLineL.Type::Item);
//             if SalesLineL.FindSet() then
//                 repeat

//                     if SalesLineL."No." <> '' then begin

//                         LineCountL := 0;

//                         ItemNoL := SalesLineL."No.";

//                         ItemAttributeValueMappingL.Reset();
//                         ItemAttributeValueMappingL.SetRange("No.", ItemNoL);
//                         ItemAttributeValueMappingL.SetRange("Table ID", 27);
//                         // @28_Jun_2021_09_35_AM
//                         ItemAttributeValueMappingL.SetRange("Sales Order", true);
//                         LineCountL := ItemAttributeValueMappingL.Count;
//                         if LineCountL > 0 then begin
//                             if ItemAttributeValueMappingL.FindSet() then
//                                 repeat
//                                     Rec.Init();
//                                     Rec.TransferFields(SalesLineL);
//                                     if ItemAttributeValueMappingL."Item Attribute ID" > 0 then begin
//                                         ItemAttributeL.Reset();
//                                         ItemAttributeL.Get(ItemAttributeValueMappingL."Item Attribute ID");
//                                         Rec."Attribute Name" := ItemAttributeL.Name;
//                                         Rec."Attribute Type" := ItemAttributeL.Type;

//                                         if ItemAttributeValueMappingL."Item Attribute Value ID" > 0 then begin
//                                             ItemAttributeValueL.Reset();
//                                             ItemAttributeValueL.SetCurrentKey("Attribute ID", ID);
//                                             ItemAttributeValueL.SetRange("Attribute ID", ItemAttributeValueMappingL."Item Attribute ID");
//                                             ItemAttributeValueL.SetRange(ID, ItemAttributeValueMappingL."Item Attribute Value ID");
//                                             if ItemAttributeValueL.Count > 0 then begin
//                                                 ItemAttributeValueL.FindFirst();
//                                                 Rec.Value := Format(ItemAttributeValueL.Value);
//                                             end;
//                                         end;
//                                         Rec."Line No." := SalesLineL."Line No." + LineCountL;
//                                     end; // if ItemAttributeValueMappingL."Item Attribute ID" > 0 then begin

//                                     Rec.Insert;
//                                     LineCountL -= 1;
//                                 until ItemAttributeValueMappingL.Next() = 0;
//                         end; // if LineCountL > 0 then begin
//                              //                ELSE BEGIN
//                              //                    Rec.INIT();
//                              //                    Rec.TRANSFERFIELDS(SalesLineL);
//                              //                    Rec.INSERT;
//                              //                END;
//                     end; // if SalesLineL."No." <> '' then begin
//                 until SalesLineL.Next = 0;
//         end; // if SQDocumentNoG <> '' then begin
//     end;

//     [Scope('OnPrem')]
//     procedure SetSalesDocumentNo(SalesQuoteNoP: Code[50])
//     begin
//         SQDocumentNoG := SalesQuoteNoP;
//     end;

// }

