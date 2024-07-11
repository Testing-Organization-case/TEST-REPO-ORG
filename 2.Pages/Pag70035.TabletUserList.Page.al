// page 70035 "Tablet User List"
// {
//     CardPageID = "Tablet User Card";
//     PageType = List;
//     SourceTable = "Tablet User";
//     UsageCategory = Lists;
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field(ID; Rec.ID)
//                 {
//                     Editable = false;
//                 }
//                 field("User Name"; Rec."User Name")
//                 {

//                     trigger OnValidate()
//                     begin

//                         Rec.CheckDuplicateUserName(Rec."User Name");
//                     end;
//                 }
//                 field(Password; Rec.Password)
//                 {
//                     ExtendedDatatype = Masked;
//                     Visible = false;
//                 }
//                 field("Check IMEI"; Rec."Check IMEI")
//                 {
//                 }
//                 field("IMEI Number"; Rec."IMEI Number")
//                 {
//                 }
//                 field("Location Code"; Rec."Location Code")
//                 {
//                 }
//                 field(Email; Rec.Email)
//                 {
//                 }
//                 field(Image; Rec.Image)
//                 {
//                 }
//                 field("Phone Number"; Rec."Phone Number")
//                 {
//                 }
//                 field(Address; Rec.Address)
//                 {
//                 }
//                 field("User Type"; Rec."User Type")
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action("Check User")
//             {
//                 Caption = 'Check User';
//                 Image = ViewCheck;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     CheckUserL: Page "Check User";
//                     UserNameL: Text;
//                     PasswordL: Text;
//                     TabletUserL: Record "Tablet User";
//                     ValidL: Boolean;
//                 begin

//                     Clear(CheckUserL);
//                     if CheckUserL.RunModal = ACTION::OK then begin
//                         UserNameL := CheckUserL.GetUser;
//                         PasswordL := CheckUserL.GetPassword;
//                         Rec.Validate(Password, PasswordL);
//                         PasswordL := Rec.Password;

//                         ValidL := false;
//                         TabletUserL.Reset;
//                         TabletUserL.SetRange("User Name", UserNameL);
//                         TabletUserL.SetRange(Password, PasswordL);
//                         if TabletUserL.Count > 0 then begin
//                             ValidL := true;
//                         end; // IF TabletUserL.COUNT > 0 THEN

//                         if ValidL then begin
//                             Message('User Name and Password is Match!');
//                         end; // IF ValidL THEN
//                         if not ValidL then begin
//                             Error('User Name and Password is Doesn''t Match!');
//                         end;
//                     end;
//                 end;
//             }
//             action("Change Password")
//             {
//                 Caption = 'Change Password';
//                 Image = EncryptionKeys;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page "Change User Password";
//                 RunPageLink = ID = FIELD(ID);
//             }
//         }
//     }
// }

