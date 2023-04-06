
page 83019 "Azure Blob Storage"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ABS Container setup";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(AccountName; rec."Account Name")
                {
                    ApplicationArea = all;
                }
                field(ContainerName; rec."Container Name")
                {
                    ApplicationArea = all;
                }
                field(SharedAccessKey; rec."Shared Access Key")
                {
                    ApplicationArea = all;
                    ExtendedDatatype = Masked;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    var
        ABSOperationResponse: Codeunit "ABS Operation Response";
        ABSBlobClient: codeunit "ABS Blob Client";
        ABSContainerClient: Codeunit "ABS Container Client";
        Authorization: Interface "Storage Service Authorization";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        Response: Codeunit "ABS Operation Response";
        ABSContainerContent: Record "ABS Container Content";
}