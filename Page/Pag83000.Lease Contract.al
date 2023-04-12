page 83000 "Lease Contract"
{
    Caption = 'Lease Contract Card';
    PageType = Document;
    SourceTable = "Lease Contract Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                //enabled = rec.Status <> rec.Status::Cancelled;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'Contract No.';
                    ApplicationArea = All;
                }
                field("Contract Name"; Rec."Contract Name")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Caption = 'Contract Name';
                    ApplicationArea = All;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ToolTip = 'Specifies the value of the Contract Start Date field.';
                    ApplicationArea = All;
                }
                field("Contract End Date"; rec."Contract End Date")
                {
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                    ApplicationArea = All;
                }
                field("Contract Termination Date"; rec."Contract Termination Date")
                {
                    ToolTip = 'Specifies the value of the Contract Termination Date field.';
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                    ApplicationArea = All;
                }
                group("Early-In / Extension")
                {
                    field("New Contract Start Date"; Rec."New Contract Start Date")
                    {
                        ToolTip = 'Specifies the value of the New Contract Start Date" field.';
                        ApplicationArea = All;
                    }
                    field("New Contract End Date"; Rec."New Contract End Date")
                    {
                        ToolTip = 'Specifies the value of the New Contract End Date field.';
                        ApplicationArea = All;
                    }
                }





                group(Property)
                {
                    field("Property Unit"; rec."Property No.")
                    {
                        ToolTip = 'Specifies the value of the Property No. field.';
                        ApplicationArea = All;
                    }

                    field("Property Unit Name"; rec."Property Name")
                    {
                        ToolTip = 'Specifies the value of the Property No. field.';
                        ApplicationArea = All;
                    }
                }
                group(Room)
                {
                    field("Room Type Name"; rec."Room Type")
                    {
                        Caption = 'Room Type Name';
                        ApplicationArea = All;
                    }
                    field("Room Name"; rec."Room No.")
                    {
                        Caption = 'Room Name';
                        ApplicationArea = All;
                    }
                }

                group(Deposit)
                {
                    field("Deposit Amount"; rec."Deposit Amount")
                    {
                        ToolTip = 'Spcifies the value of the Deposit Amount field.';
                        ApplicationArea = All;
                    }

                }

                group("Tender Discount")
                {
                    field("Tender Type"; rec."Tender Type")
                    {
                        ToolTip = 'Spcifies the value of the Tender Type field.';
                        ApplicationArea = All;
                    }
                    field("Tender Type Discount Amount"; rec."Tender Type Discount Amount")
                    {
                        ToolTip = 'Spcifies the value of the Tender Type field.';
                        ApplicationArea = All;
                    }

                }
                group(Price)
                {
                    field("Payment Type"; rec."Payment Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Rent Price"; rec.Price)
                    {
                        ApplicationArea = All;
                    }
                    field("Daily Rent"; rec."Daily Rent")
                    {
                        ApplicationArea = All;
                    }
                    field("Monthly Rent"; rec."Monthly Rent")
                    {
                        ApplicationArea = All;
                    }

                    field("Net Amount"; rec."Net Amount")
                    {
                        ApplicationArea = All;
                    }
                    field("Net Amount include VAT"; rec."Net Amount include VAT")
                    {
                        ApplicationArea = All;
                    }


                }
                group("Promotion Code")
                {
                    field("Promotion Code type"; rec."Promotion Code type")
                    {
                        Caption = 'Promotion Type';
                        ApplicationArea = All;

                    }
                    field("Contract Promotion Code"; rec."Promotion Code")
                    {
                        Caption = 'Promotion Code';
                        ApplicationArea = All;

                    }
                    field("Promotion Deduction type"; rec."Promotion Deduction type")
                    {
                        Caption = 'Promotion Deduction Type';
                        ApplicationArea = All;

                    }
                    field("Promotion Amount / %"; rec."Promotion Amount / %")
                    {
                        Caption = 'Promotion Amount / %';
                        ApplicationArea = All;

                    }

                    field("One-off Discount"; rec."One off Discount")
                    {
                        Caption = 'One-off Discount';
                        ApplicationArea = All;
                    }
                    field("Monthly Discount"; Rec."Monthly Discount")
                    {
                        ApplicationArea = All;
                    }

                }

                group(Prepayment)
                {
                    Field("Prepaid Amount"; rec."Prepaid Amount")
                    {
                        ApplicationArea = All;
                    }
                    Field("Prepaid Discount"; rec."Prepaid Discount")
                    {
                        Caption = 'Prepaid Discount %';
                        ApplicationArea = All;

                    }
                    Field("11st Pymt. Stripe/QFPay Inv. ID"; Rec."1st Payment Stripe Invoice ID")
                    {
                        caption = '1st Payment Stripe Invoice ID';
                        ApplicationArea = All;

                    }
                    Field("Payment Amount"; rec."Payment Amount")
                    {
                        ApplicationArea = All;

                    }
                }
                group(Others)
                {
                    field("No. of Extra Charge"; Rec."No. of Extra Charge") { ApplicationArea = All; }

                    field("Run Terminated Billing Sched."; Rec."Run Terminated Billing Sched.") { ApplicationArea = All; }
                    field("Deposit Returned"; Rec."Deposit Returned") { ApplicationArea = All; }

                }
                group("Sales Commission")
                {
                    field("Salesperson Email"; Rec."Salesperson Email")
                    { ApplicationArea = All; }
                    field("Salesperson Name"; Rec."Salesperson Name")
                    { ApplicationArea = All; Editable = false; }
                    field("Commission Type"; Rec."Commission Type")
                    { ApplicationArea = All; }

                }

            }
            part(LeaseContractLines; "Lease Contract Subform")
            {
                ApplicationArea = Basic, Suite;
                // Editable = DynamicEditable;
                //  Enabled = (rec."Customer No." <> '') and (rec.Status <> rec.Status::Cancelled);
                SubPageLink = "Key2" = FIELD("Key");
                UpdatePropagation = Both;
            }

        }
    }
    actions
    {
        area(Navigation)
        {
            group(Navigate)
            {
                action("Billing Schedule")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Image = ContractPayment;
                    RunObject = page "Lease Contract Billing Sched.";
                    RunPageLink = "Contract No." = field("No.");
                    RunPageView = sorting("Customer No.", "Posting Date", "Contract No.", "Line No.") order(ascending);

                }
            }
        }
        area(Processing)
        {
            group(Fuctions)
            {
                action("Refresh Billing Schedule")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    image = SuggestPayment;

                    trigger OnAction()
                    var

                        l_cduLeaseContractMgt: Codeunit "Lease Contract Management";
                    begin
                        l_cduLeaseContractMgt.RefreshBillingSchedule(rec, false);
                    end;
                }
                action("Terminate Contract")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    image = Cancel;
                    trigger OnAction()
                    var
                        l_cduLeaseContractMgt: Codeunit "Lease Contract Management";
                    begin
                        l_cduLeaseContractMgt.TerminateContract(rec, false);
                    end;

                }
                action("Create Invoice/Credit Memo")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Image = JobSalesInvoice;
                    trigger OnAction()
                    var
                        l_rptLeaseContractCreateInvoice: REport "Lease Contract Create Invoices";
                    begin
                        rec.SetRecFilter();
                        l_rptLeaseContractCreateInvoice.SetTableView(rec);

                        l_rptLeaseContractCreateInvoice.run;
                        //Report.run(report::"Lease Contract Create Invoices", true, true, rec);

                    end;
                }
            }
        }
    }
    trigger OnOpenPage()

    var
        l_recPropertyUnit: Record "Property Unit";

    begin
        // l_recPropertyUnit.SetRange("CRM GUID", Rec."Property CRMGuid");
        // If l_recPropertyUnit.FindFirst() then begin
        //     Rec."Property No." := l_recPropertyUnit."No.";
        //     Rec."Property Name" := l_recPropertyUnit.Description;
        //     Rec."Room No." := l_recPropertyUnit."Room No.";
        //     Rec."Room Type" := l_recPropertyUnit."Room Type Name";
        //     Rec.Modify();
        // end;



    end;

}
