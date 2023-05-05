page 83041 APIUsersetup
{

    APIGroup = 'app1';
    APIPublisher = 'weave';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiUsersetup';
    DelayedInsert = true;
    EntityName = 'apiUsersetup';
    EntitySetName = 'apiUsersetup';
    PageType = API;
    SourceTable = "User Setup";
    ODataKeyFields = SystemId;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(allowDeferralPostingFrom; Rec."Allow Deferral Posting From")
                {
                    Caption = 'Allow Deferral Posting From';
                }
                field(allowDeferralPostingTo; Rec."Allow Deferral Posting To")
                {
                    Caption = 'Allow Deferral Posting To';
                }
                field(allowFAPostingFrom; Rec."Allow FA Posting From")
                {
                    Caption = 'Allow FA Posting From';
                }
                field(allowFAPostingTo; Rec."Allow FA Posting To")
                {
                    Caption = 'Allow FA Posting To';
                }
                field(allowPostingFrom; Rec."Allow Posting From")
                {
                    Caption = 'Allow Posting From';
                }
                field(allowPostingTo; Rec."Allow Posting To")
                {
                    Caption = 'Allow Posting To';
                }
                field(approvalAdministrator; Rec."Approval Administrator")
                {
                    Caption = 'Approval Administrator';
                }
                field(approverID; Rec."Approver ID")
                {
                    Caption = 'Approver ID';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                }
                field(genericUser; Rec."Generic User")
                {
                    Caption = 'Generic User';
                }
                field(licenseType; Rec."License Type")
                {
                    Caption = 'License Type';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                // field(purchInvoicePostingPolicy; Rec."Purch. Invoice Posting Policy")
                // {
                //     Caption = 'Purch. Invoice Posting Policy';
                // }
                field(purchaseAmountApprovalLimit; Rec."Purchase Amount Approval Limit")
                {
                    Caption = 'Purchase Amount Approval Limit';
                }
                field(purchaseRespCtrFilter; Rec."Purchase Resp. Ctr. Filter")
                {
                    Caption = 'Purchase Resp. Ctr. Filter';
                }
                field(registerTime; Rec."Register Time")
                {
                    Caption = 'Register Time';
                }
                field(requestAmountApprovalLimit; Rec."Request Amount Approval Limit")
                {
                    Caption = 'Request Amount Approval Limit';
                }
                field(salesAmountApprovalLimit; Rec."Sales Amount Approval Limit")
                {
                    Caption = 'Sales Amount Approval Limit';
                }
                // field(salesInvoicePostingPolicy; Rec."Sales Invoice Posting Policy")
                // {
                //     Caption = 'Sales Invoice Posting Policy';
                // }
                field(salesRespCtrFilter; Rec."Sales Resp. Ctr. Filter")
                {
                    Caption = 'Sales Resp. Ctr. Filter';
                }
                field(salespersPurchCode; Rec."Salespers./Purch. Code")
                {
                    Caption = 'Salespers./Purch. Code';
                }
                field(serviceRespCtrFilter; Rec."Service Resp. Ctr. Filter")
                {
                    Caption = 'Service Resp. Ctr. Filter';
                }
                field(substitute; Rec.Substitute)
                {
                    Caption = 'Substitute';
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
                field(timeSheetAdmin; Rec."Time Sheet Admin.")
                {
                    Caption = 'Time Sheet Admin.';
                }
                field(unlimitedPurchaseApproval; Rec."Unlimited Purchase Approval")
                {
                    Caption = 'Unlimited Purchase Approval';
                }
                field(unlimitedRequestApproval; Rec."Unlimited Request Approval")
                {
                    Caption = 'Unlimited Request Approval';
                }
                field(unlimitedSalesApproval; Rec."Unlimited Sales Approval")
                {
                    Caption = 'Unlimited Sales Approval';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
            }
        }
    }
}
