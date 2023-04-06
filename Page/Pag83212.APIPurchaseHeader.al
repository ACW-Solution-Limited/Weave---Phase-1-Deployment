page 83212 "API Purchase Header"
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiPurchaseHeader';
    DelayedInsert = true;
    EntityName = 'purchaseheader';
    EntitySetName = 'purchaseheader';
    PageType = API;
    SourceTable = "Purchase Header";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(payToVendorNo; Rec."Pay-to Vendor No.")
                {
                    Caption = 'Pay-to Vendor No.';
                }
                field(payToName; Rec."Pay-to Name")
                {
                    Caption = 'Pay-to Name';
                }
                field(payToName2; Rec."Pay-to Name 2")
                {
                    Caption = 'Pay-to Name 2';
                }
                field(payToAddress; Rec."Pay-to Address")
                {
                    Caption = 'Pay-to Address';
                }
                field(payToAddress2; Rec."Pay-to Address 2")
                {
                    Caption = 'Pay-to Address 2';
                }
                field(payToCity; Rec."Pay-to City")
                {
                    Caption = 'Pay-to City';
                }
                field(payToContact; Rec."Pay-to Contact")
                {
                    Caption = 'Pay-to Contact';
                }
                field(yourReference; Rec."Your Reference")
                {
                    Caption = 'Your Reference';
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                    Caption = 'Ship-to Code';
                }
                field(shipToName; Rec."Ship-to Name")
                {
                    Caption = 'Ship-to Name';
                }
                field(shipToName2; Rec."Ship-to Name 2")
                {
                    Caption = 'Ship-to Name 2';
                }
                field(shipToAddress; Rec."Ship-to Address")
                {
                    Caption = 'Ship-to Address';
                }
                field(shipToAddress2; Rec."Ship-to Address 2")
                {
                    Caption = 'Ship-to Address 2';
                }
                field(shipToCity; Rec."Ship-to City")
                {
                    Caption = 'Ship-to City';
                }
                field(shipToContact; Rec."Ship-to Contact")
                {
                    Caption = 'Ship-to Contact';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(expectedReceiptDate; Rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date';
                }
                field(postingDescription; Rec."Posting Description")
                {
                    Caption = 'Posting Description';
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(paymentDiscount; Rec."Payment Discount %")
                {
                    Caption = 'Payment Discount %';
                }
                field(pmtDiscountDate; Rec."Pmt. Discount Date")
                {
                    Caption = 'Pmt. Discount Date';
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(vendorPostingGroup; Rec."Vendor Posting Group")
                {
                    Caption = 'Vendor Posting Group';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                    Caption = 'Currency Factor';
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                    Caption = 'Prices Including VAT';
                }
                field(invoiceDiscCode; Rec."Invoice Disc. Code")
                {
                    Caption = 'Invoice Disc. Code';
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code';
                }
                field(purchaserCode; Rec."Purchaser Code")
                {
                    Caption = 'Purchaser Code';
                }
                field(orderClass; Rec."Order Class")
                {
                    Caption = 'Order Class';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(noPrinted; Rec."No. Printed")
                {
                    Caption = 'No. Printed';
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
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(recalculateInvoiceDisc; Rec."Recalculate Invoice Disc.")
                {
                    Caption = 'Recalculate Invoice Disc.';
                }
                field(receive; Rec.Receive)
                {
                    Caption = 'Receive';
                }
                field(invoice; Rec.Invoice)
                {
                    Caption = 'Invoice';
                }
                field(printPostedDocuments; Rec."Print Posted Documents")
                {
                    Caption = 'Print Posted Documents';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(receivingNo; Rec."Receiving No.")
                {
                    Caption = 'Receiving No.';
                }
                field(postingNo; Rec."Posting No.")
                {
                    Caption = 'Posting No.';
                }
                field(lastReceivingNo; Rec."Last Receiving No.")
                {
                    Caption = 'Last Receiving No.';
                }
                field(lastPostingNo; Rec."Last Posting No.")
                {
                    Caption = 'Last Posting No.';
                }
                field(vendorOrderNo; Rec."Vendor Order No.")
                {
                    Caption = 'Vendor Order No.';
                }
                field(vendorShipmentNo; Rec."Vendor Shipment No.")
                {
                    Caption = 'Vendor Shipment No.';
                }
                field(vendorInvoiceNo; Rec."Vendor Invoice No.")
                {
                    Caption = 'Vendor Invoice No.';
                }
                field(vendorCrMemoNo; Rec."Vendor Cr. Memo No.")
                {
                    Caption = 'Vendor Cr. Memo No.';
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field("transactionType"; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type';
                }
                field(transportMethod; Rec."Transport Method")
                {
                    Caption = 'Transport Method';
                }
                field(vatCountryRegionCode; Rec."VAT Country/Region Code")
                {
                    Caption = 'VAT Country/Region Code';
                }
                field(buyFromVendorName; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Buy-from Vendor Name';
                }
                field(buyFromVendorName2; Rec."Buy-from Vendor Name 2")
                {
                    Caption = 'Buy-from Vendor Name 2';
                }
                field(buyFromAddress; Rec."Buy-from Address")
                {
                    Caption = 'Buy-from Address';
                }
                field(buyFromAddress2; Rec."Buy-from Address 2")
                {
                    Caption = 'Buy-from Address 2';
                }
                field(buyFromCity; Rec."Buy-from City")
                {
                    Caption = 'Buy-from City';
                }
                field(buyFromContact; Rec."Buy-from Contact")
                {
                    Caption = 'Buy-from Contact';
                }
                field(payToPostCode; Rec."Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code';
                }
                field(payToCounty; Rec."Pay-to County")
                {
                    Caption = 'Pay-to County';
                }
                field(payToCountryRegionCode; Rec."Pay-to Country/Region Code")
                {
                    Caption = 'Pay-to Country/Region Code';
                }
                field(buyFromPostCode; Rec."Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code';
                }
                field(buyFromCounty; Rec."Buy-from County")
                {
                    Caption = 'Buy-from County';
                }
                field(buyFromCountryRegionCode; Rec."Buy-from Country/Region Code")
                {
                    Caption = 'Buy-from Country/Region Code';
                }
                field(shipToPostCode; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code';
                }
                field(shipToCounty; Rec."Ship-to County")
                {
                    Caption = 'Ship-to County';
                }
                field(shipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    Caption = 'Ship-to Country/Region Code';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(orderAddressCode; Rec."Order Address Code")
                {
                    Caption = 'Order Address Code';
                }
                field(entryPoint; Rec."Entry Point")
                {
                    Caption = 'Entry Point';
                }
                field(correction; Rec.Correction)
                {
                    Caption = 'Correction';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area';
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification';
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(postingNoSeries; Rec."Posting No. Series")
                {
                    Caption = 'Posting No. Series';
                }
                field(receivingNoSeries; Rec."Receiving No. Series")
                {
                    Caption = 'Receiving No. Series';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(appliesToID; Rec."Applies-to ID")
                {
                    Caption = 'Applies-to ID';
                }
                field(vatBaseDiscount; Rec."VAT Base Discount %")
                {
                    Caption = 'VAT Base Discount %';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(invoiceDiscountCalculation; Rec."Invoice Discount Calculation")
                {
                    Caption = 'Invoice Discount Calculation';
                }
                field(invoiceDiscountValue; Rec."Invoice Discount Value")
                {
                    Caption = 'Invoice Discount Value';
                }
                field(sendICDocument; Rec."Send IC Document")
                {
                    Caption = 'Send IC Document';
                }
                field(icStatus; Rec."IC Status")
                {
                    Caption = 'IC Status';
                }
                field(buyFromICPartnerCode; Rec."Buy-from IC Partner Code")
                {
                    Caption = 'Buy-from IC Partner Code';
                }
                field(payToICPartnerCode; Rec."Pay-to IC Partner Code")
                {
                    Caption = 'Pay-to IC Partner Code';
                }
                field(icDirection; Rec."IC Direction")
                {
                    Caption = 'IC Direction';
                }
                field(prepaymentNo; Rec."Prepayment No.")
                {
                    Caption = 'Prepayment No.';
                }
                field(lastPrepaymentNo; Rec."Last Prepayment No.")
                {
                    Caption = 'Last Prepayment No.';
                }
                field(prepmtCrMemoNo; Rec."Prepmt. Cr. Memo No.")
                {
                    Caption = 'Prepmt. Cr. Memo No.';
                }
                field(lastPrepmtCrMemoNo; Rec."Last Prepmt. Cr. Memo No.")
                {
                    Caption = 'Last Prepmt. Cr. Memo No.';
                }
                field(prepayment; Rec."Prepayment %")
                {
                    Caption = 'Prepayment %';
                }
                field(prepaymentNoSeries; Rec."Prepayment No. Series")
                {
                    Caption = 'Prepayment No. Series';
                }
                field(compressPrepayment; Rec."Compress Prepayment")
                {
                    Caption = 'Compress Prepayment';
                }
                field(prepaymentDueDate; Rec."Prepayment Due Date")
                {
                    Caption = 'Prepayment Due Date';
                }
                field(prepmtCrMemoNoSeries; Rec."Prepmt. Cr. Memo No. Series")
                {
                    Caption = 'Prepmt. Cr. Memo No. Series';
                }
                field(prepmtPostingDescription; Rec."Prepmt. Posting Description")
                {
                    Caption = 'Prepmt. Posting Description';
                }
                field(prepmtPmtDiscountDate; Rec."Prepmt. Pmt. Discount Date")
                {
                    Caption = 'Prepmt. Pmt. Discount Date';
                }
                field(prepmtPaymentTermsCode; Rec."Prepmt. Payment Terms Code")
                {
                    Caption = 'Prepmt. Payment Terms Code';
                }
                field(prepmtPaymentDiscount; Rec."Prepmt. Payment Discount %")
                {
                    Caption = 'Prepmt. Payment Discount %';
                }
                field(quoteNo; Rec."Quote No.")
                {
                    Caption = 'Quote No.';
                }
                field(jobQueueStatus; Rec."Job Queue Status")
                {
                    Caption = 'Job Queue Status';
                }
                field(jobQueueEntryID; Rec."Job Queue Entry ID")
                {
                    Caption = 'Job Queue Entry ID';
                }
                field(incomingDocumentEntryNo; Rec."Incoming Document Entry No.")
                {
                    Caption = 'Incoming Document Entry No.';
                }
                field(creditorNo; Rec."Creditor No.")
                {
                    Caption = 'Creditor No.';
                }
                field(paymentReference; Rec."Payment Reference")
                {
                    Caption = 'Payment Reference';
                }
                field(journalTemplName; Rec."Journal Templ. Name")
                {
                    Caption = 'Journal Template Name';
                }
                field(vatReportingDate; Rec."VAT Reporting Date")
                {
                    Caption = 'VAT Date';
                }
                field(aRcdNotInvExVATLCY; Rec."A. Rcd. Not Inv. Ex. VAT (LCY)")
                {
                    Caption = 'Amount Received Not Invoiced (LCY)';
                }
                field(amtRcdNotInvoicedLCY; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    Caption = 'Amount Received Not Invoiced (LCY) Incl. VAT';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(remitToCode; Rec."Remit-to Code")
                {
                    Caption = 'Remit-to Code';
                }
                field(invoiceDiscountAmount; Rec."Invoice Discount Amount")
                {
                    Caption = 'Invoice Discount Amount';
                }
                field(noOfArchivedVersions; Rec."No. of Archived Versions")
                {
                    Caption = 'No. of Archived Versions';
                }
                field(docNoOccurrence; Rec."Doc. No. Occurrence")
                {
                    Caption = 'Doc. No. Occurrence';
                }
                field(campaignNo; Rec."Campaign No.")
                {
                    Caption = 'Campaign No.';
                }
                field(buyFromContactNo; Rec."Buy-from Contact No.")
                {
                    Caption = 'Buy-from Contact No.';
                }
                field(payToContactNo; Rec."Pay-to Contact No.")
                {
                    Caption = 'Pay-to Contact No.';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(partiallyInvoiced; Rec."Partially Invoiced")
                {
                    Caption = 'Partially Invoiced';
                }
                field(completelyReceived; Rec."Completely Received")
                {
                    Caption = 'Completely Received';
                }
                field(postingFromWhseRef; Rec."Posting from Whse. Ref.")
                {
                    Caption = 'Posting from Whse. Ref.';
                }
                field(requestedReceiptDate; Rec."Requested Receipt Date")
                {
                    Caption = 'Requested Receipt Date';
                }
                field(promisedReceiptDate; Rec."Promised Receipt Date")
                {
                    Caption = 'Promised Receipt Date';
                }
                field(leadTimeCalculation; Rec."Lead Time Calculation")
                {
                    Caption = 'Lead Time Calculation';
                }
                field(inboundWhseHandlingTime; Rec."Inbound Whse. Handling Time")
                {
                    Caption = 'Inbound Whse. Handling Time';
                }
                field(vendorAuthorizationNo; Rec."Vendor Authorization No.")
                {
                    Caption = 'Vendor Authorization No.';
                }
                field(returnShipmentNo; Rec."Return Shipment No.")
                {
                    Caption = 'Return Shipment No.';
                }
                field(returnShipmentNoSeries; Rec."Return Shipment No. Series")
                {
                    Caption = 'Return Shipment No. Series';
                }
                field(ship; Rec.Ship)
                {
                    Caption = 'Ship';
                }
                field(lastReturnShipmentNo; Rec."Last Return Shipment No.")
                {
                    Caption = 'Last Return Shipment No.';
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method';
                }
                field(id; Rec.Id)
                {
                    Caption = 'Id';
                }
                field(assignedUserID; Rec."Assigned User ID")
                {
                    Caption = 'Assigned User ID';
                }
                field(pendingApprovals; Rec."Pending Approvals")
                {
                    Caption = 'Pending Approvals';
                }
                field(companyFilter; Rec."Company Filter")
                {
                    Caption = 'Company filter for Powerapp';
                }
                field(userName; Rec."User Name")
                {
                    Caption = 'User Name';
                }
                field(assignedPONo; Rec."Assigned PO No.")
                {
                    Caption = 'Assigned PO NO.';
                }
                field(requestApproval; Rec."Request Approval")
                {
                    Caption = 'Request Approval';
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
