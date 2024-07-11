// page 70005 "Filter By Tag"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = Item;
//     SourceTableTemporary = true;
//     ApplicationArea = ALl;
//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field(Ingredient; IngredientTxtG)
//                 {
//                     MultiLine = true;
//                     Width = 200;
//                 }
//                 field(Usage; UsageTxtG)
//                 {
//                 }
//                 field(Allergy; AllergyTxtG)
//                 {
//                 }
//                 field("Complication And Side Effect"; ComplicationAndSideEffectTxtG)
//                 {
//                 }
//                 field("Mode of Application"; ModeOfApplicationTxtG)
//                 {
//                 }
//                 field("Search Description"; SearchDescriptionTxtG)
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action("Apply Filter")
//             {
//                 Image = UseFilters;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Visible = false;

//                 trigger OnAction()
//                 var
//                     ItemL: Record Item;
//                 begin
//                     //
//                 end;
//             }
//         }
//     }

//     trigger OnInit()
//     begin

//         Rec.Insert();
//     end;

//     var
//         IngredientTxtG: Text;
//         UsageTxtG: Text;
//         AllergyTxtG: Text;
//         ComplicationAndSideEffectTxtG: Text;
//         ModeOfApplicationTxtG: Text;
//         SearchDescriptionTxtG: Text;

//     [Scope('OnPrem')]
//     local procedure GetIngredient(): Text
//     begin
//         exit(IngredientTxtG);
//     end;

//     [Scope('OnPrem')]
//     local procedure GetUsage(): Text
//     begin
//         exit(UsageTxtG);
//     end;

//     [Scope('OnPrem')]
//     local procedure GetAllergy(): Text
//     begin
//         exit(AllergyTxtG);
//     end;

//     [Scope('OnPrem')]
//     local procedure GetComplicationAndSideEffect(): Text
//     begin
//         exit(ComplicationAndSideEffectTxtG);
//     end;

//     [Scope('OnPrem')]
//     local procedure GetSearchDescription(): Text
//     begin
//         exit(SearchDescriptionTxtG);
//     end;

//     [Scope('OnPrem')]
//     local procedure GetModeOfApplication(): Text
//     begin
//         exit(ModeOfApplicationTxtG);
//     end;
// }

