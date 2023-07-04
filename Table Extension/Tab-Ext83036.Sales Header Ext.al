tableextension 83036 "Sales Header Ext" extends "Sales Header"
{
    // #001 09/11/2022 - JC Posting Date should be same as the document date 
    // #001 >>
    fields
    {




        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin

                // Rec."Document Date" := Rec."Posting Date"
            end;

        }
        field(82005; "External Payment Gateway"; Enum "External Payment Gateway")
        {
            DataClassification = ToBeClassified;
        }

        field(83002; "Stripe Invoice ID"; Text[250]) { Caption = 'Stripe/QFPay Invoice ID'; }

        field(83003; "Lease Contract No."; Code[50]) { Caption = 'Lease Contract No.'; }

        field(83004; "Lease Contract Name"; Text[250]) { Caption = 'Lease Contract Name'; }

        field(83005; "Lease Contract Creation Date"; Date) { Caption = 'Lease Contract Creation Date'; }

        field(83006; "Contract Start Date"; Date) { Caption = 'Contract Start Date'; }

        field(83007; "Contract End Date"; Date) { Caption = 'Contract End Date'; }

        field(83008; "Contract Termination Date"; Date) { Caption = 'Contract Termination Date'; }
        field(83009; "Commission Type"; Enum "Commission Type")
        {
            Caption = 'Comission Type';
        }
        field(83010; "Calculation Type"; Enum "Calculation Type") { Caption = 'Calculation Type'; }

        field(83011; "Commission Amount"; Decimal) { Caption = 'Commision Amount / %'; }



    }

    trigger OnInsert()
    begin

        Rec."Document Date" := Rec."Posting Date";

    end;

    Procedure DoPrintToDocumentAttachmentwhenpost(Var SalesHeader: Record "Sales Header")
    var
        ReportSelections: Record "Report Selections";
        l_recSalesInvHeader: Record "Sales Invoice Header";
        l_recBlobstorage: Record "ABS Container setup";
        l_recSalesReceivableSetup: Record "Sales & Receivables Setup";
        l_varBlobURL: Text;
    begin
        l_recBlobstorage.Get;
        l_recSalesReceivableSetup.Get;
        // l_recSalesInvHeader.SetCurrentKey(SystemCreatedAt);
        // l_recSalesInvHeader.Ascending(True);
        // l_recSalesInvHeader.setrange(SystemCreatedBy, UserSecurityId());
        // If l_recSalesInvHeader.FindLast() then begin
        //     g_docmentNo := l_recSalesInvHeader."No.";
        // end;
        l_recSalesInvHeader.reset;
        g_docmentNo := SalesHeader."No.";
        If l_recSalesReceivableSetup."Invoice Nos." = l_recSalesReceivableSetup."Posted Invoice Nos." then
            l_recSalesInvHeader.SetFilter("No.", '=%1', g_docmentNo)
        else
            l_recSalesInvHeader.SetFilter("Pre-Assigned No.", '=%1', g_docmentNo);

        //l_recSalesInvHeader.SetRecFilter();
        If l_recSalesInvHeader.findfirst then;
        If (l_recBlobstorage."Container Name" = '') or (l_recBlobstorage."Account Name" = '') or (l_recBlobstorage."Shared Access Key" = '') then begin
            Message('%1', 'Please set up the Azure Blob Storage.');
        end else begin
            ReportSelections.SaveAsDocumentAttachment(
                ReportSelections.Usage::"S.Invoice".AsInteger(), l_recSalesInvHeader, l_recSalesInvHeader."No.", l_recSalesInvHeader."Bill-to Customer No.", ShowNotificationAction);
            // Message('%1', l_recSalesInvHeader."No.");
        end;
    end;

    Procedure DoPrintToDocumentAttachmentwhenpostcreditmemo(Var SalesHeader: Record "Sales Header")
    var
        ReportSelections: Record "Report Selections";
        l_recSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        l_recBlobstorage: Record "ABS Container setup";
        l_recSalesReceivableSetup: Record "Sales & Receivables Setup";
        l_varBlobURL: Text;
    begin
        l_recBlobstorage.Get;
        l_recSalesReceivableSetup.Get;
        // l_recSalesInvHeader.SetCurrentKey(SystemCreatedAt);
        // l_recSalesInvHeader.Ascending(True);
        // l_recSalesInvHeader.setrange(SystemCreatedBy, UserSecurityId());
        // If l_recSalesInvHeader.FindLast() then begin
        //     g_docmentNo := l_recSalesInvHeader."No.";
        // end;
        l_recSalesCrMemoHeader.reset;
        g_docmentNo := SalesHeader."No.";
        If l_recSalesReceivableSetup."Invoice Nos." = l_recSalesReceivableSetup."Posted Credit Memo Nos." then
            l_recSalesCrMemoHeader.SetFilter("No.", '=%1', g_docmentNo)
        else
            l_recSalesCrMemoHeader.SetFilter("Pre-Assigned No.", '=%1', g_docmentNo);
        // Message('%1', g_docmentNo);
        //l_recSalesInvHeader.SetRecFilter();
        If l_recSalesCrMemoHeader.findfirst then;
        If (l_recBlobstorage."Container Name" = '') or (l_recBlobstorage."Account Name" = '') or (l_recBlobstorage."Shared Access Key" = '') then begin
            Message('%1', 'Please set up the Azure Blob Storage.');
        end else begin
            ReportSelections.SaveAsDocumentAttachment(
                ReportSelections.Usage::"S.Cr.Memo".AsInteger(), l_recSalesCrMemoHeader, l_recSalesCrMemoHeader."No.", l_recSalesCrMemoHeader."Bill-to Customer No.", ShowNotificationAction);
            // Message('%1', l_recSalesInvHeader."No.");
        end;
    end;



    var
        ShowNotificationAction: Boolean;
        g_docmentNo: Code[20];
    // #001 <<
}
