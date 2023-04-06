page 83203 "API Vendor Ledger Entries"
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiVendorLedgerEntries';
    DelayedInsert = true;
    EntityName = 'vendorledgerentries';
    EntitySetName = 'vendorledgerentries';
    PageType = API;
    SourceTable = "Vendor Ledger Entry";
    
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
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
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
                field(vendorName; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(remainingAmount; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                }
                field(originalAmtLCY; Rec."Original Amt. (LCY)")
                {
                    Caption = 'Original Amt. (LCY)';
                }
                field(remainingAmtLCY; Rec."Remaining Amt. (LCY)")
                {
                    Caption = 'Remaining Amt. (LCY)';
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                }
                field(purchaseLCY; Rec."Purchase (LCY)")
                {
                    Caption = 'Purchase (LCY)';
                }
                field(invDiscountLCY; Rec."Inv. Discount (LCY)")
                {
                    Caption = 'Inv. Discount (LCY)';
                }
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                }
                field(vendorPostingGroup; Rec."Vendor Posting Group")
                {
                    Caption = 'Vendor Posting Group';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(purchaserCode; Rec."Purchaser Code")
                {
                    Caption = 'Purchaser Code';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(onHold; Rec."On Hold")
                {
                    Caption = 'On Hold';
                }
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type';
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                }
                field(open; Rec.Open)
                {
                    Caption = 'Open';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(pmtDiscountDate; Rec."Pmt. Discount Date")
                {
                    Caption = 'Pmt. Discount Date';
                }
                field(originalPmtDiscPossible; Rec."Original Pmt. Disc. Possible")
                {
                    Caption = 'Original Pmt. Disc. Possible';
                }
                field(pmtDiscRcdLCY; Rec."Pmt. Disc. Rcd.(LCY)")
                {
                    Caption = 'Pmt. Disc. Rcd.(LCY)';
                }
                field(origPmtDiscPossibleLCY; Rec."Orig. Pmt. Disc. Possible(LCY)")
                {
                    Caption = 'Org. Pmt. Disc. Possible (LCY)';
                }
                field(positive; Rec.Positive)
                {
                    Caption = 'Positive';
                }
                field(closedByEntryNo; Rec."Closed by Entry No.")
                {
                    Caption = 'Closed by Entry No.';
                }
                field(closedAtDate; Rec."Closed at Date")
                {
                    Caption = 'Closed at Date';
                }
                field(closedByAmount; Rec."Closed by Amount")
                {
                    Caption = 'Closed by Amount';
                }
                field(appliesToID; Rec."Applies-to ID")
                {
                    Caption = 'Applies-to ID';
                }
                field(journalTemplName; Rec."Journal Templ. Name")
                {
                    Caption = 'Journal Template Name';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(transactionNo; Rec."Transaction No.")
                {
                    Caption = 'Transaction No.';
                }
                field(closedByAmountLCY; Rec."Closed by Amount (LCY)")
                {
                    Caption = 'Closed by Amount (LCY)';
                }
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(debitAmountLCY; Rec."Debit Amount (LCY)")
                {
                    Caption = 'Debit Amount (LCY)';
                }
                field(creditAmountLCY; Rec."Credit Amount (LCY)")
                {
                    Caption = 'Credit Amount (LCY)';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(closedByCurrencyCode; Rec."Closed by Currency Code")
                {
                    Caption = 'Closed by Currency Code';
                }
                field(closedByCurrencyAmount; Rec."Closed by Currency Amount")
                {
                    Caption = 'Closed by Currency Amount';
                }
                field(adjustedCurrencyFactor; Rec."Adjusted Currency Factor")
                {
                    Caption = 'Adjusted Currency Factor';
                }
                field(originalCurrencyFactor; Rec."Original Currency Factor")
                {
                    Caption = 'Original Currency Factor';
                }
                field(originalAmount; Rec."Original Amount")
                {
                    Caption = 'Original Amount';
                }
                field(remainingPmtDiscPossible; Rec."Remaining Pmt. Disc. Possible")
                {
                    Caption = 'Remaining Pmt. Disc. Possible';
                }
                field(pmtDiscToleranceDate; Rec."Pmt. Disc. Tolerance Date")
                {
                    Caption = 'Pmt. Disc. Tolerance Date';
                }
                field(maxPaymentTolerance; Rec."Max. Payment Tolerance")
                {
                    Caption = 'Max. Payment Tolerance';
                }
                field(acceptedPaymentTolerance; Rec."Accepted Payment Tolerance")
                {
                    Caption = 'Accepted Payment Tolerance';
                }
                field(acceptedPmtDiscTolerance; Rec."Accepted Pmt. Disc. Tolerance")
                {
                    Caption = 'Accepted Pmt. Disc. Tolerance';
                }
                field(pmtToleranceLCY; Rec."Pmt. Tolerance (LCY)")
                {
                    Caption = 'Pmt. Tolerance (LCY)';
                }
                field(amountToApply; Rec."Amount to Apply")
                {
                    Caption = 'Amount to Apply';
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                    Caption = 'IC Partner Code';
                }
                field(applyingEntry; Rec."Applying Entry")
                {
                    Caption = 'Applying Entry';
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
                field(prepayment; Rec.Prepayment)
                {
                    Caption = 'Prepayment';
                }
                field(creditorNo; Rec."Creditor No.")
                {
                    Caption = 'Creditor No.';
                }
                field(paymentReference; Rec."Payment Reference")
                {
                    Caption = 'Payment Reference';
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code';
                }
                field(appliesToExtDocNo; Rec."Applies-to Ext. Doc. No.")
                {
                    Caption = 'Applies-to Ext. Doc. No.';
                }
                field(recipientBankAccount; Rec."Recipient Bank Account")
                {
                    Caption = 'Recipient Bank Account';
                }
                field(messageToRecipient; Rec."Message to Recipient")
                {
                    Caption = 'Message to Recipient';
                }
                field(exportedToPaymentFile; Rec."Exported to Payment File")
                {
                    Caption = 'Exported to Payment File';
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
                field(remitToCode; Rec."Remit-to Code")
                {
                    Caption = 'Remit-to Code';
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
