table 83024 "Sales Commission Setup"
{
    Caption = 'Sales Commission Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ",DirectBooking,B2COutreach,B2BOutreach,B2CCompanyAssign,B2BRenewal,B2CRenewal,"B2CCompanyAssign-PropertyViewing(OperationTeam)";
            DataClassification = ToBeClassified;
        }
        field(2; "Calculation Type"; Enum "Calculation Type")
        {
            Caption = 'Commission Type';
            DataClassification = ToBeClassified;
            NotBlank = True;
            // OptionMembers = "","By Percentage","By Amount";
            trigger OnValidate()

            begin
                If Type = Rec.Type::B2CRenewal then
                    If "Calculation Type" = "Calculation Type"::ByPrecentage then
                        Error('%1', 'The calculation type cannot be by percentage for B2CRenewal.');
            end;


        }
        field(3; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            Trigger OnValidate()
            begin
                If "Calculation Type" = "Calculation Type"::ByPrecentage then
                    If Amount > 100 then
                        Error('%1', 'The percentage cannot be greater than 100.');
            end;
        }
        field(4; "Minimum Contract Period"; Integer)
        {
            Caption = 'Minimum Contract Period';
            DataClassification = ToBeClassified;

        }
    }
    keys
    {
        key(PK; "Type")
        {
            Clustered = true;
        }
    }
}
