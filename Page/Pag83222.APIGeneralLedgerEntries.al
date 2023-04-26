page 83222 APIGeneralLedgerEntries
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiGeneralLedgerEntries';
    DelayedInsert = true;
    EntityName = 'glentry';
    EntitySetName = 'glentry';
    PageType = API;
    SourceTable = "G/L Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(gLAccountNo; Rec."G/L Account No.")
                {
                    Caption = 'G/L Account No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                    Caption = 'System-Created Entry';
                }
                field(priorYearEntry; Rec."Prior-Year Entry")
                {
                    Caption = 'Prior-Year Entry';
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Job No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(vatAmount; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field(businessUnitCode; Rec."Business Unit Code")
                {
                    Caption = 'Business Unit Code';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(genPostingType; Rec."Gen. Posting Type")
                {
                    Caption = 'Gen. Posting Type';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(transactionNo; Rec."Transaction No.")
                {
                    Caption = 'Transaction No.';
                }
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                }
                field(useTax; Rec."Use Tax")
                {
                    Caption = 'Use Tax';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(additionalCurrencyAmount; Rec."Additional-Currency Amount")
                {
                    Caption = 'Additional-Currency Amount';
                }
                field(addCurrencyDebitAmount; Rec."Add.-Currency Debit Amount")
                {
                    Caption = 'Add.-Currency Debit Amount';
                }
                field(addCurrencyCreditAmount; Rec."Add.-Currency Credit Amount")
                {
                    Caption = 'Add.-Currency Credit Amount';
                }
                field(closeIncomeStatementDimID; Rec."Close Income Statement Dim. ID")
                {
                    Caption = 'Close Income Statement Dim. ID';
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                    Caption = 'IC Partner Code';
                }
                field(reversed; Rec.Reversed)
                {
                    Caption = 'Reversed';
                }
                field(reversedByEntryNo; Rec."Reversed by Entry No.")
                {
                    Caption = 'Reversed by Entry No.';
                }
                field(reversedEntryNo; Rec."Reversed Entry No.")
                {
                    Caption = 'Reversed Entry No.';
                }
                field(gLAccountName; Rec."G/L Account Name")
                {
                    Caption = 'G/L Account Name';
                }
                field(journalTemplName; Rec."Journal Templ. Name")
                {
                    Caption = 'Journal Template Name';
                }
                field(vatReportingDate; Rec."VAT Reporting Date")
                {
                    Caption = 'VAT Date';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                    Caption = 'Shortcut Dimension 5 Code';
                }
                field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code")
                {
                    Caption = 'Shortcut Dimension 6 Code';
                }
                field(shortcutDimension7Code; Rec."Shortcut Dimension 7 Code")
                {
                    Caption = 'Shortcut Dimension 7 Code';
                }
                field(shortcutDimension8Code; Rec."Shortcut Dimension 8 Code")
                {
                    Caption = 'Shortcut Dimension 8 Code';
                }
                field(lastDimCorrectionEntryNo; Rec."Last Dim. Correction Entry No.")
                {
                    Caption = 'Last Dim. Correction Entry No.';
                }
                field(lastDimCorrectionNode; Rec."Last Dim. Correction Node")
                {
                    Caption = 'Last Dim. Correction Node';
                }
                field(dimensionChangesCount; Rec."Dimension Changes Count")
                {
                    Caption = 'Count of Dimension Changes';
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.';
                }
                field(faEntryType; Rec."FA Entry Type")
                {
                    Caption = 'FA Entry Type';
                }
                field(faEntryNo; Rec."FA Entry No.")
                {
                    Caption = 'FA Entry No.';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(accountId; Rec."Account Id")
                {
                    Caption = 'Account Id';
                }
                field(lastModifiedDateTime; Rec."Last Modified DateTime")
                {
                    Caption = 'Last Modified DateTime';
                }
                field(invoiceDescription; Rec."Invoice Description")
                {
                    Caption = 'Invoice Description';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
