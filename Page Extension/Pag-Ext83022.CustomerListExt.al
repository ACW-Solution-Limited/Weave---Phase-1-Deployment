pageextension 83022 CustomerListExt extends "Customer List"
{


    layout
    {
        addafter("Sales (LCY)")
        {
            field("HK Customer"; Rec."HK Customer") { ApplicationArea = all; }
            field("SG Customer"; Rec."SG Customer") { ApplicationArea = all; }
        }
    }


    trigger OnOpenPage()
    var
        CRMAccouttoBC: Report "CRM account Update to BC ";
        l_recCompanyInformation: Record "Company Information";



    begin
        // CRMAccouttoBC.Run();

        if l_recCompanyInformation.Get() then begin
            if NOT (l_recCompanyInformation."Customer Type" = l_recCompanyInformation."Customer Type"::Both) then begin
                Rec.FilterGroup(2);
                if l_recCompanyInformation."Customer Type" = l_recCompanyInformation."Customer Type"::"HK Customer" then
                    Rec.SetRange("HK Customer", true);
                if l_recCompanyInformation."Customer Type" = l_recCompanyInformation."Customer Type"::"SG Customer" then
                    Rec.SetRange("SG Customer", true);
                Rec.FilterGroup(0);
            end;
        end;
    end;
}
