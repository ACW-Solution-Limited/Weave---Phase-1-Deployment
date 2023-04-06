page 83012 "Expense Claim Admins"
{
    ApplicationArea = All;
    Caption = 'Expense Claim Admins';
    PageType = List;
    SourceTable = "Expense Claim Admin";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                    trigger OnValidate()
                    var
                        l_recVendor: Record Vendor;
                    begin
                        if l_recVendor.get(rec."Vendor No.") then begin
                            rec.Name := l_recVendor.Name;
                            rec.Modify();
                        end;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
            }
        }
    }
}
