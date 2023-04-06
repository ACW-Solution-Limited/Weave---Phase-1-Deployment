page 82001 "Stripe Payment Setup"
{
    Caption = 'Stripe Payment Setup';
    UsageCategory = Tasks;
    ApplicationArea = all;
    PageType = Card;
    SourceTable = "Stripe Payment Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = not rec.Enabled;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = not rec.Enabled;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    Enabled = rec."Stripe Secret Key" <> '';
                    ToolTip = 'Specifies the value of the Enabled field.';
                    trigger OnValidate()
                    begin
                        if rec.Enabled then begin
                            rec.TestField("Stripe Secret Key");
                        end;
                    end;
                }
                field("Always Include on Documents"; Rec."Always Include on Documents")
                {
                    ApplicationArea = All;
                    Editable = not rec.Enabled;
                    ToolTip = 'Specifies the value of the Always Include on Documents field.';
                }
                field("Stripe Bank Account"; rec."Stripe Bank Account")
                {
                    ApplicationArea = All;
                }
                field("Receiving Bank Account"; rec."Receiving Bank Account")
                {
                    ApplicationArea = All;
                }
                field("Stripe Processing Fee G/L Acc."; rec."Stripe Processing Fee G/L Acc.")
                {
                    ApplicationArea = All;
                }
                field("Stripe Payment Jnl. Template"; rec."Stripe Payment Jnl. Template")
                {
                    ApplicationArea = All;
                }
                field("Stripe Payment Jnl. Batch"; rec."Stripe Payment Jnl. Batch")
                {
                    ApplicationArea = All;
                }
                field("Stripe Payout Jnl. Template"; rec."Stripe Payout Jnl. Template")
                {
                    ApplicationArea = All;
                }
                field("Stripe Payout Jnl. Batch"; rec."Stripe Payout Jnl. Batch")
                {
                    ApplicationArea = All;
                }

                field("Stripe Refund Jnl. Template"; Rec."Stripe Refund Jnl. Template") { ApplicationArea = all; }
                field("Stripe Refund Jnl. Batch"; Rec."Stripe Refund Jnl. Batch") { ApplicationArea = all; }


                field(Logo; rec.Logo)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                    end;
                }
                field("Stripe Secret Key"; rec."Stripe Secret Key")
                {
                    ApplicationArea = All;
                    Editable = not rec.Enabled;
                    ExtendedDatatype = Masked;
                }
                field("Target URL"; rec."Target URL")
                {
                    ApplicationArea = All;
                    Editable = not rec.Enabled;
                    ToolTip = 'Specifies the value of the Target URL field.';
                    // trigger OnValidate()
                    // begin
                    //     rec.SetTargetURL(TargetURL);
                    // end;


                }
                field("Terms of Service"; Rec."Terms of Service")
                {
                    ApplicationArea = All;
                    Editable = g_booTermsOfServiceEnabled;
                    ToolTip = 'Specifies the value of the Terms of Service field.';
                    trigger OnDrillDown()
                    begin
                        g_booTermsOfServiceEnabled := not g_booTermsOfServiceEnabled;
                    end;

                    trigger OnAssistEdit()
                    begin
                        if rec."Terms of Service" <> '' then begin
                            Hyperlink(rec."Terms of Service");
                        end;
                    end;
                }

            }
        }
    }

    // trigger OnAfterGetRecord()
    // begin
    //     TargetURL := rec.GetTargetURL();
    // end;

    trigger OnOpenPage()
    var
        OutStream: OutStream;
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Name := 'Stripe Payment Service';
            Rec.Description := 'Stripe Payment Service';
            // Rec."Target URL".CreateOutStream(OutStream, TEXTENCODING::UTF8);
            // OutStream.WriteText('https://api.stripe.com/v1/');
            rec."Target URL" := 'https://api.stripe.com/v1/';
            Rec."Terms of Service" := 'https://stripe.com/connect-account/legal';
            Rec.Insert;
        end;

        g_booEnabled := rec.Enabled;
    end;

    trigger OnAfterGetCurrRecord()
    begin

        g_booEnabled := rec.Enabled;
    end;

    var
        TargetURL: Text;
        g_booTermsOfServiceEnabled: Boolean;
        g_booEnabled: Boolean;
}
