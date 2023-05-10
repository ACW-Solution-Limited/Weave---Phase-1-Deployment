report 83151 "Delete All Billing Schedule"
{
    ApplicationArea = All;
    Caption = 'Delete All Billing Schedule';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    { }

    trigger OnPreReport()
    begin
        if not Confirm('You are currently in Comany ' + CompanyName + '. Are you confirm to delete all billing schedule?') then exit;
    end;

    trigger OnPostReport()
    var
        l_recBillingSchdeuld: Record "Lease Contract Billing Sched.";

    begin
        l_recBillingSchdeuld.DeleteAll();
    end;



}


