// page 70034 "Tablet User Card"
// {
//     PageType = Card;
//     SourceTable = "Tablet User";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group("Login Credential")
//             {
//                 grid(Control10014519)
//                 {
//                     GridLayout = Rows;
//                     ShowCaption = false;
//                     group(Control10014514)
//                     {
//                         ShowCaption = false;
//                         field("User Name"; Rec."User Name")
//                         {

//                             trigger OnValidate()
//                             begin

//                                 Rec.CheckDuplicateUserName(Rec."User Name");
//                             end;
//                         }
//                         field(Password; Rec.Password)
//                         {
//                             ExtendedDatatype = Masked;
//                         }
//                         field("User Type"; Rec."User Type")
//                         {
//                         }
//                     }
//                     group(Control10014515)
//                     {
//                         ShowCaption = false;
//                         field("IMEI Number"; Rec."IMEI Number")
//                         {
//                         }
//                         field("Check IMEI"; Rec."Check IMEI")
//                         {
//                         }
//                         field("Location Code"; Rec."Location Code")
//                         {
//                         }
//                     }
//                 }
//             }
//             group("Personal Information")
//             {
//                 grid(Control10014502)
//                 {
//                     ShowCaption = false;
//                     group(Control10014522)
//                     {
//                         ShowCaption = false;
//                         group(Control10014516)
//                         {
//                             ShowCaption = false;
//                             field(Email; Rec.Email)
//                             {
//                             }
//                         }
//                         group(Control10014521)
//                         {
//                             ShowCaption = false;
//                             field("Phone Number"; Rec."Phone Number")
//                             {
//                             }
//                         }
//                         group(Control10014520)
//                         {
//                             ShowCaption = false;
//                             group(Control10014518)
//                             {
//                                 ShowCaption = false;
//                                 field(Address; Rec.Address)
//                                 {
//                                 }
//                                 field("Address 2"; Rec."Address 2")
//                                 {
//                                 }
//                             }
//                         }
//                     }
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(Control1; "Tablet User Picture")
//             {
//                 SubPageLink = ID = FIELD(ID);
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
//                 RunObject = Page "Check User";

//                 trigger OnAction()
//                 begin
//                     //
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

//     var
//         Demo: Text;
// }

