report 70021 "Posting Date Filter"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Consolidate Purchase Line"; "Consolidate Purchase Line")
        {

            trigger OnAfterGetRecord()
            begin
                if PostingDate <> 0D then begin
                    if "Consolidate Purchase Line".Find('-') then
                        repeat

                            "Posting Date" := PostingDate;
                            "Consolidate Purchase Line".Modify;

                        until "Consolidate Purchase Line".Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin

                "Consolidate Purchase Line".SetFilter("Document No.", DocumentNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PostingDate: Date;
        DocumentNo: Code[50];

    [Scope('OnPrem')]
    procedure VendorNoAndItemNo(DocumentNoPara: Code[50])
    begin

        DocumentNo := DocumentNoPara;
    end;
}

