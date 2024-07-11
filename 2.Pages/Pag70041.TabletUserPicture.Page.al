
// dotnet
// {

//     assembly("Microsoft.Dynamics.Nav.ClientExtensions")
//     {

//         type("Microsoft.Dynamics.Nav.Client.Capabilities.CameraProvider"; CameraProvider)
//         {

//         }

//         type("Microsoft.Dynamics.Nav.Client.Capabilities.CameraOptions"; CameraOptions)
//         {

//         }
//     }
// }

// page 70041 "Tablet User Picture"     //Created By MK
// {
//     PageType = CardPart;
//     SourceTable = "Tablet User";

//     layout
//     {
//         area(content)
//         {
//             field(Image; Rec.Image)
//             {
//                 ShowCaption = false;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(TakePicture)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Take';
//                 Image = Camera;
//                 //Promoted = true;
//                 //PromotedCategory = Process;
//                 //PromotedIsBig = true;
//                 ToolTip = 'Activate the camera on the device.';
//                 Visible = CameraAvailable;

//                 trigger OnAction()
//                 var
//                     CameraOptions: DotNet CameraOptions;
//                 // CameraOptions: DotNet UT_CameraProvider;
//                 begin
//                     Rec.TestField(ID);
//                     Rec.TestField("User Name");
//                     if not CameraAvailable then
//                         exit;
//                     CameraOptions := CameraOptions.CameraOptions;
//                     CameraOptions.Quality := 100;
//                     CameraProvider.RequestPictureAsync(CameraOptions);
//                 end;
//             }
//             action(ImportPicture)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Import';
//                 Image = Import;
//                 ToolTip = 'Import a picture file.';

//                 trigger OnAction()
//                 var
//                     FileManagement: Codeunit "File Management";
//                     FileName: Text;
//                     ClientFileName: Text;
//                 begin
//                     Rec.TestField(ID);
//                     Rec.TestField("User Name");

//                     if Rec.Image.HasValue then
//                         if not Confirm(OverrideImageQst) then
//                             exit;

//                     FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
//                     if FileName = '' then
//                         exit;

//                     Clear(Rec.Image);
//                     Rec.Image.ImportFile(FileName, ClientFileName);
//                     Rec.Modify(true);

//                     if FileManagement.DeleteServerFile(FileName) then;
//                 end;
//             }
//             action(ExportFile)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Export';
//                 Enabled = DeleteExportEnabled;
//                 Image = Export;
//                 ToolTip = 'Export the picture to a file.';

//                 trigger OnAction()
//                 var
//                     DummyPictureEntity: Record "Picture Entity";
//                     FileManagement: Codeunit "File Management";
//                     ToFile: Text;
//                     ExportPath: Text;
//                 begin
//                     Rec.TestField(ID);
//                     Rec.TestField("User Name");

//                     ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
//                     ExportPath := TemporaryPath + Rec."User Name" + Format(Rec.Image.MediaId);
//                     Rec.Image.ExportFile(ExportPath);

//                     FileManagement.ExportImage(ExportPath, ToFile);
//                 end;
//             }
//             action(DeletePicture)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Delete';
//                 Enabled = DeleteExportEnabled;
//                 Image = Delete;
//                 ToolTip = 'Delete the record.';

//                 trigger OnAction()
//                 begin
//                     Rec.TestField("User Name");

//                     if not Confirm(DeleteImageQst) then
//                         exit;

//                     Clear(Rec.Image);
//                     Rec.Modify(true);
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin

//         CameraAvailable := CameraProvider.IsAvailable;
//         if CameraAvailable then
//             CameraProvider := CameraProvider.Create;
//     end;

//     var


//         CameraProvider: DotNet CameraProvider;
//         CameraAvailable: Boolean;
//         DeleteExportEnabled: Boolean;
//         OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
//         DeleteImageQst: Label 'Are you sure you want to delete the picture?';
//         SelectPictureTxt: Label 'Select a picture to upload';

// }


