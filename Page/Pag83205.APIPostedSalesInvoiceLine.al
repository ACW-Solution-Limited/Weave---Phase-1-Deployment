page 83205 "API Posted Sales Invoice Line"
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiPostedSalesInvoiceLine';
    DelayedInsert = true;
    EntityName = 'postedsalesinvoiceline';
    EntitySetName = 'postedsalesinvoiceline';
    PageType = API;
    SourceTable = "Posted Sales Inv. Line for CRM";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(postingGroup; Rec."Posting Group")
                {
                    Caption = 'Posting Group';
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field(unitCostLCY; Rec."Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)';
                }
                field(vat; Rec."VAT %")
                {
                    Caption = 'VAT %';
                }
                field(lineDiscount; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %';
                }
                field(lineDiscountAmount; Rec."Line Discount Amount")
                {
                    Caption = 'Line Discount Amount';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(allowInvoiceDisc; Rec."Allow Invoice Disc.")
                {
                    Caption = 'Allow Invoice Disc.';
                }
                field(grossWeight; Rec."Gross Weight")
                {
                    Caption = 'Gross Weight';
                }
                field(netWeight; Rec."Net Weight")
                {
                    Caption = 'Net Weight';
                }
                field(unitsPerParcel; Rec."Units per Parcel")
                {
                    Caption = 'Units per Parcel';
                }
                field(unitVolume; Rec."Unit Volume")
                {
                    Caption = 'Unit Volume';
                }
                field(applToItemEntry; Rec."Appl.-to Item Entry")
                {
                    Caption = 'Appl.-to Item Entry';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                    Caption = 'Customer Price Group';
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Job No.';
                }
                field(workTypeCode; Rec."Work Type Code")
                {
                    Caption = 'Work Type Code';
                }
                field(shipmentNo; Rec."Shipment No.")
                {
                    Caption = 'Shipment No.';
                }
                field(shipmentLineNo; Rec."Shipment Line No.")
                {
                    Caption = 'Shipment Line No.';
                }
                field(orderNo; Rec."Order No.")
                {
                    Caption = 'Order No.';
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                    Caption = 'Order Line No.';
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                }
                field(invDiscountAmount; Rec."Inv. Discount Amount")
                {
                    Caption = 'Inv. Discount Amount';
                }
                field(dropShipment; Rec."Drop Shipment")
                {
                    Caption = 'Drop Shipment';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(vatCalculationType; Rec."VAT Calculation Type")
                {
                    Caption = 'VAT Calculation Type';
                }
                field("transactionType"; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type';
                }
                field(transportMethod; Rec."Transport Method")
                {
                    Caption = 'Transport Method';
                }
                field(attachedToLineNo; Rec."Attached to Line No.")
                {
                    Caption = 'Attached to Line No.';
                }
                field(exitPoint; Rec."Exit Point")
                {
                    Caption = 'Exit Point';
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area';
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification';
                }
                field(taxCategory; Rec."Tax Category")
                {
                    Caption = 'Tax Category';
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
                field(vatClauseCode; Rec."VAT Clause Code")
                {
                    Caption = 'VAT Clause Code';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(blanketOrderNo; Rec."Blanket Order No.")
                {
                    Caption = 'Blanket Order No.';
                }
                field(blanketOrderLineNo; Rec."Blanket Order Line No.")
                {
                    Caption = 'Blanket Order Line No.';
                }
                field(vatBaseAmount; Rec."VAT Base Amount")
                {
                    Caption = 'VAT Base Amount';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                    Caption = 'System-Created Entry';
                }
                field(lineAmount; Rec."Line Amount")
                {
                    Caption = 'Line Amount';
                }
                field(vatDifference; Rec."VAT Difference")
                {
                    Caption = 'VAT Difference';
                }
                field(vatIdentifier; Rec."VAT Identifier")
                {
                    Caption = 'VAT Identifier';
                }
                field(icPartnerRefType; Rec."IC Partner Ref. Type")
                {
                    Caption = 'IC Partner Ref. Type';
                }
                field(icPartnerReference; Rec."IC Partner Reference")
                {
                    Caption = 'IC Partner Reference';
                }
                field(prepaymentLine; Rec."Prepayment Line")
                {
                    Caption = 'Prepayment Line';
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                    Caption = 'IC Partner Code';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(icItemReferenceNo; Rec."IC Item Reference No.")
                {
                    Caption = 'IC Item Reference No.';
                }
                field(pmtDiscountAmount; Rec."Pmt. Discount Amount")
                {
                    Caption = 'Pmt. Discount Amount';
                }
                field(lineDiscountCalculation; Rec."Line Discount Calculation")
                {
                    Caption = 'Line Discount Calculation';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'Job Task No.';
                }
                field(jobContractEntryNo; Rec."Job Contract Entry No.")
                {
                    Caption = 'Job Contract Entry No.';
                }
                field(deferralCode; Rec."Deferral Code")
                {
                    Caption = 'Deferral Code';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field(faPostingDate; Rec."FA Posting Date")
                {
                    Caption = 'FA Posting Date';
                }
                field(depreciationBookCode; Rec."Depreciation Book Code")
                {
                    Caption = 'Depreciation Book Code';
                }
                field(deprUntilFAPostingDate; Rec."Depr. until FA Posting Date")
                {
                    Caption = 'Depr. until FA Posting Date';
                }
                field(duplicateInDepreciationBook; Rec."Duplicate in Depreciation Book")
                {
                    Caption = 'Duplicate in Depreciation Book';
                }
                field(useDuplicationList; Rec."Use Duplication List")
                {
                    Caption = 'Use Duplication List';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(crossReferenceNo; Rec."Cross-Reference No.")
                {
                    Caption = 'Cross-Reference No.';
                }
                field(unitOfMeasureCrossRef; Rec."Unit of Measure (Cross Ref.)")
                {
                    Caption = 'Unit of Measure (Cross Ref.)';
                }
                field(crossReferenceType; Rec."Cross-Reference Type")
                {
                    Caption = 'Cross-Reference Type';
                }
                field(crossReferenceTypeNo; Rec."Cross-Reference Type No.")
                {
                    Caption = 'Cross-Reference Type No.';
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field(nonstock; Rec.Nonstock)
                {
                    Caption = 'Catalog';
                }
                field(purchasingCode; Rec."Purchasing Code")
                {
                    Caption = 'Purchasing Code';
                }
                field(itemReferenceNo; Rec."Item Reference No.")
                {
                    Caption = 'Item Reference No.';
                }
                field(itemReferenceUnitOfMeasure; Rec."Item Reference Unit of Measure")
                {
                    Caption = 'Unit of Measure (Item Ref.)';
                }
                field(itemReferenceType; Rec."Item Reference Type")
                {
                    Caption = 'Item Reference Type';
                }
                field(itemReferenceTypeNo; Rec."Item Reference Type No.")
                {
                    Caption = 'Item Reference Type No.';
                }
                field(applFromItemEntry; Rec."Appl.-from Item Entry")
                {
                    Caption = 'Appl.-from Item Entry';
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code';
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method';
                }
                field(allowLineDisc; Rec."Allow Line Disc.")
                {
                    Caption = 'Allow Line Disc.';
                }
                field(customerDiscGroup; Rec."Customer Disc. Group")
                {
                    Caption = 'Customer Disc. Group';
                }
                field(priceDescription; Rec."Price description")
                {
                    Caption = 'Price description';
                }
                field(contractNo; Rec."Contract No.")
                {
                    Caption = 'Contract No.';
                }
                field(billingScheduleLineNo; Rec."Billing Schedule Line No.")
                {
                    Caption = 'Billing Schedule Line No.';
                }
                field(leaseFromDate; Rec."Lease From Date")
                {
                    Caption = 'Lease From Date';
                }
                field(leaseToDate; Rec."Lease To Date")
                {
                    Caption = 'Lease To Date';
                }
                field(billingScheduleType; Rec."Billing Schedule Type")
                {
                    Caption = 'Billing Schedule Type';
                }
                field(additionalSalesItemNo; Rec."Additional Sales Item No.")
                {
                    Caption = 'Additional Sales Item No.';
                }
                field(additionalItemSalesDate; Rec."Additional Item Sales Date")
                {
                    Caption = 'Additional Item Sales Date';
                }
                field(linkedAssemblyOrderNo; Rec."Linked Assembly Order No.")
                {
                    Caption = 'Linked Assembly Order No.';
                }
                field(invoiceDescription; Rec."Invoice Description")
                {
                    Caption = 'Invoice Description';
                }
                field(companyName; Rec."Company Name")
                {
                    Caption = 'Company Name';
                }
                field(companyGuidForCRM; Rec."Company Guid for CRM")
                {
                    Caption = 'Company Guid for CRM';
                }
                field(propertyBookingGuidForCRM; Rec."Property Booking Guid for CRM")
                {
                    Caption = 'Property Booking Guid for CRM';
                }
                field(salesInvoiceGuidForCRM; Rec."Sales Invoice Guid for CRM")
                {
                    Caption = 'Sales Invoice Guid for CRM';
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
