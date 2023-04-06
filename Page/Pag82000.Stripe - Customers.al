page 82000 "Stripe Customers"
{
    ApplicationArea = All;
    Caption = 'Stripe Customers';
    PageType = List;
    SourceTable = "Stripe Customer";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Stripe Customer ID"; Rec."Stripe Customer ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stripe Customer ID field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
            }
        }
    }
}
