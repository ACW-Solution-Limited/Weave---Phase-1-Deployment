page 83103 "CDS Account List"
{
    ApplicationArea = All;
    Caption = 'CDS Account List';
    PageType = List;
    SourceTable = "CRM Account";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies data from a corresponding field in a Dataverse entity. For more information about Dataverse, see Dataverse Help Center.';
                }
                field(acwapp_AccountID; Rec.acwapp_AccountID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account ID field.';
                }
                field(acwapp_FirstName; Rec.acwapp_FirstName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field(acwapp_LastName; Rec.acwapp_LastName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(acwapp_CustomerName; Rec.acwapp_CustomerName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field(Address1_Line1; Rec.Address1_Line1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies data from a corresponding field in a Dataverse entity. For more information about Dataverse, see Dataverse Help Center.';
                }
                field(Address1_Line2; Rec.Address1_Line2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies data from a corresponding field in a Dataverse entity. For more information about Dataverse, see Dataverse Help Center.';
                }
                field(Address1_Line3; Rec.Address1_Line3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 1: Street 3 field.';
                }
                field(Address1_PostalCode; Rec.Address1_PostalCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies data from a corresponding field in a Dataverse entity. For more information about Dataverse, see Dataverse Help Center.';
                }
                field(Address1_City; Rec.Address1_City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies data from a corresponding field in a Dataverse entity. For more information about Dataverse, see Dataverse Help Center.';
                }
                field(Address1_Country; Rec.Address1_Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies data from a corresponding field in a Dataverse entity. For more information about Dataverse, see Dataverse Help Center.';
                }
            }
        }
    }
    var
        CurrentlyCoupledCRMAccount: Record "CRM Account";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCRMAccount(CRMAccount: Record "CRM Account")
    begin
        CurrentlyCoupledCRMAccount := CRMAccount;
    end;

}
