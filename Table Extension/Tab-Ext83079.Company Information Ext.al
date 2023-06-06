tableextension 83079 "Company Information Ext" extends "Company Information"
{
    fields
    {
        field(83000; "Property Unit GUID"; Guid)
        {
            Caption = 'Property Unit GUID';
            DataClassification = ToBeClassified;


        }
        field(83001; "Property Unit No."; Code[50])
        {
            Caption = 'Property Unit No.';
            DataClassification = ToBeClassified;

        }

        field(83002; "Apply Property Unit No."; Boolean)
        {
            Caption = 'Apply Property Unit No.';
        }

        field(83009; "Customer Type"; Option)
        {
            OptionMembers = "HK Customer","SG Customer","Both";
            Caption = 'Customer Type';
        }
        field(83010; "HK Master Company"; Boolean) { Caption = 'HK Master Company'; trigger OnValidate() begin CheckOnlyOneAmoungAllCompany('HK Master Company') end; }
        field(83011; "SG Master Company"; Boolean) { Caption = 'SG Master Company'; trigger OnValidate() begin CheckOnlyOneAmoungAllCompany('SG Master Company') end; }

        field(83015; "HK Expense Claim Master"; Boolean) { Caption = 'HK Expense Claim Master'; trigger OnValidate() begin CheckOnlyOneAmoungAllCompany('HK Expense Claim Master') end; }
        field(83016; "SG Expense Claim Master"; Boolean) { Caption = 'SG Expense Claim Master'; trigger OnValidate() begin CheckOnlyOneAmoungAllCompany('SG Expense Claim Master') end; }

        field(83020; "CRM Company Guid"; Guid) { Caption = 'CRM Company Guid'; }
        field(83022; "CRM Currency Guid"; Guid) { Caption = 'CRM Currency Guid'; }
        field(83023; "Purch. Inv. Default Location"; Code[50]) { TableRelation = Location; }

        field(83025; "Building Name"; Text[250]) { Caption = 'Building Name'; }
        field(83026; "Name Show in Posted Sales Inv."; Text[250]) { }

    }


    procedure CheckOnlyOneAmoungAllCompany(CheckType: Text[100])
    var
        l_recCompanyInformation: Record "Company Information";
        l_recCompany: Record Company;
    begin

        case CheckType of
            'HK Master Company':
                if NOT (Rec."HK Master Company") then
                    exit;
            'SG Master Company':
                if NOT (Rec."SG Master Company") then
                    exit;
            'HK Expense Claim Master':
                if NOT (Rec."HK Expense Claim Master") then
                    exit;
            'SG Expense Claim Master':
                if NOT (Rec."SG Expense Claim Master") then
                    exit;
        end;



        l_recCompany.SetFilter(Name, '<>%1', CompanyName);
        if l_recCompany.FindFirst() then
            repeat
                l_recCompanyInformation.ChangeCompany();
                if NOT (l_recCompanyInformation.Get()) then exit;

                case CheckType of
                    'HK Master Company':
                        if l_recCompanyInformation."HK Master Company" then
                            Error(l_recCompany."Display Name" + 'has launched HK Master Company');
                    'SG Master Company':
                        if l_recCompanyInformation."SG Master Company" then
                            Error(l_recCompany."Display Name" + 'has launched SG Master Company');
                    'HK Expense Claim Master':
                        if l_recCompanyInformation."HK Expense Claim Master" then
                            Error(l_recCompany."Display Name" + 'has launched HK Expense Claim Master');
                    'SG Expense Claim Master':
                        if l_recCompanyInformation."SG Expense Claim Master" then
                            Error(l_recCompany."Display Name" + 'has launched SG Expense Claim Master');

                end;

            until l_recCompany.Next() = 0;


    end;

}
