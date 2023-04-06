tableextension 83027 "Item Ext" extends Item
{
    fields
    {
        field(83000; "Product Type Code"; Code[100])
        {
            Caption = 'Product Type';
            DataClassification = ToBeClassified;
            TableRelation = "Product Type".Code;
        }
        field(83001; "Available On Booking Site"; Boolean)
        {
            Caption = 'Available On Booking Site';
        }

        field(83020; "CRM Company Guid"; Guid)
        {
            Caption = 'CRM Company Guid';
            FieldClass = FlowField;
            CalcFormula = lookup("Company Information"."CRM Company Guid");
        }

        field(83100; "Product Type GUId for CRM"; Guid)
        {
            Caption = 'Product Type GUId for CRM';
            FieldClass = FlowField;
            CalcFormula = lookup("Product Type"."CRM GUID" where(Code = field("Product Type Code")));
        }
        field(83110; "Sub"; Guid)
        {
            Caption = 'Product Type GUId for CRM';
            FieldClass = FlowField;
            CalcFormula = lookup("Product Type"."CRM GUID" where(Code = field("Product Type Code")));
        }
        field(83115; "Subscription/Immediate"; Boolean)
        {
            Caption = 'Subscription/Immediate';

        }
        field(83120; "Subscription Period Type"; Option)
        {
            Caption = 'Subscription Period Type';
            OptionMembers = " ","Day(s)","Week(s)","Month(s)","Year(s)";
        }
        field(83125; "Subscription Period"; Integer)
        {
            Caption = 'Subscription Period';

        }
        field(83126; "CRM Currency Guid"; Guid)
        {
            Caption = 'CRM Currency Guid';
            FieldClass = FlowField;
            CalcFormula = lookup("Company Information"."CRM Currency Guid");
        }

        field(83128; "Key"; Guid)
        {
            Caption = 'Key for CRM';
            FieldClass = Normal;
            // CalcFormula = lookup("CDS acwapp_product"."acwapp_productId" where(acwapp_ProductIDform = field("No.")));
        }



    }

    // trigger OnAfterInsert()
    // var
    //     l_recCompanyInformation: Record "Company Information";
    // begin
    //     if l_recCompanyInformation.Get() then begin
    //         "CRM Company Guid" := l_recCompanyInformation."CRM Company Guid";
    //         Modify();
    //     end;
    // end;
}
