page 83100 "CRM Property Unit List"
{
    // ApplicationArea = All;
    Caption = 'Property Unit List';
    PageType = List;
    SourceTable = "CDS acwapp_propertyunit";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {



                field(acwapp_PropertyID; Rec.acwapp_PropertyID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property ID field.';
                }
                field(acwapp_Type; Rec.acwapp_Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(acwapp_EnglishShortDescription; Rec.acwapp_EnglishShortDescription)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(acwapp_name; Rec.acwapp_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Name field.';
                }
                field(acwapp_PropertyNo; rec.acwapp_PropertyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field(acwapp_CleaningStatus; Rec.acwapp_CleaningStatus)
                {
                    ApplicationArea = All;
                }
                field(acwapp_RoomTypeName; Rec.acwapp_RoomTypeName)
                {
                    ApplicationArea = all;
                    Caption = 'Room Type Name';
                }
                field(acwapp_Unit; Rec.acwapp_Unit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit field.';
                }
                field(acwapp_AddressLine1; Rec.acwapp_AddressLine1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address Line 1 field.';
                }
                field(acwapp_AddressLine2; Rec.acwapp_AddressLine2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address Line 2 field.';
                }
                field(acwapp_AddressLine3; Rec.acwapp_AddressLine3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address Line 3 field.';
                }

                field(acwapp_PostCode; Rec.acwapp_PostCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(acwapp_CityName; Rec.acwapp_CityName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_CityName field.';
                }

                field(acwapp_CountryName; Rec.acwapp_CountryName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_CountryName field.';
                }


                field(acwapp_Floor; Rec.acwapp_Floor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Floor field.';
                }
            }
        }
    }

    var
        CurrentlyCoupledCRMPropertyUnit: Record "CDS acwapp_propertyunit";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    trigger OnOpenPage()
    var
        l_recCompanyInformation: Record "Company Information";
    begin
        if l_recCompanyInformation.Get() then
            if l_recCompanyInformation."Apply Property Unit No." then
                Rec.SetFilter(acwapp_PropertyNo, l_recCompanyInformation."Property Unit No.")
            else
                Error('Current Company is not allow to open this pages. Please setup on the company information.');
    end;

    procedure SetCurrentlyCoupledCRMPropertyUnit(CRMPropertyUnit: Record "CDS acwapp_propertyunit")
    begin
        CurrentlyCoupledCRMPropertyUnit := CRMPropertyUnit;
    end;
}
