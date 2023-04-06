page 83005 "Property Unit List"
{
    ApplicationArea = All;
    Caption = 'Property Unit List';
    PageType = List;
    SourceTable = "Property Unit";
    UsageCategory = Lists;
    CardPageId = "Property Unit Card";
    SourceTableView = sorting("Property No.", "Sort Order") order(ascending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = rec.Indentation;
                IndentationControls = Description;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specified the value of the Type field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Cleaning Status"; rec."Cleaning Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specified the value of the Cleaning Status field.';
                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room No. field.';
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property No. field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country Code field.';
                }
                field(Floor; Rec.Floor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Floor field.';
                }
                field("Property Unit Group No."; Rec."Property Unit Group No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Unit Group No. field.';
                }
                field("Property Unit Type"; Rec."Property Unit Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Unit Type field.';
                }
                field(Indentation; rec.Indentation)
                {
                    ApplicationArea = All;
                }
                field("CRM GUID"; rec."CRM GUID")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Indent Property Units")
            {
                ApplicationArea = All;
                Image = Indent;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    l_recPropertyUnit: Record "Property Unit";
                    l_recPropertyUnitGroup: Record "Property Unit";
                begin
                    l_recPropertyUnit.reset;
                    if l_recPropertyUnit.FindSet() then
                        repeat
                            if l_recPropertyUnit."Property Unit Group No." <> '' then begin
                                if l_recPropertyUnitGroup.get(l_recPropertyUnit."Property Unit Group No.") then begin
                                    l_recPropertyUnit.Indentation := l_recPropertyUnitGroup.Indentation + 1;
                                    l_recPropertyUnit.Modify();
                                end;
                            end
                        until l_recPropertyUnit.next = 0;
                end;
            }




            group(ActionGroupCDS)
            {
                Caption = 'Dataverse';
                Visible = CDSIntegrationEnabled;

                action(CDSGotoPropertyUnit)
                {
                    Caption = 'Property Unit';
                    Image = CoupledCustomer;
                    ToolTip = 'Open the coupled Dataverse Property Unit.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(CDSSynchronizeNow)
                {
                    Caption = 'Synchronize';
                    ApplicationArea = All;
                    Visible = true;
                    Image = Refresh;
                    Enabled = CDSIsCoupledToRecord;
                    ToolTip = 'Send or get updated data to or from Microsoft Dataverse.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.UpdateOneNow(Rec.RecordId);
                    end;
                }
                action(ShowLog)
                {
                    Caption = 'Synchronization Log';
                    ApplicationArea = All;
                    Visible = true;
                    Image = Log;
                    ToolTip = 'View integration synchronization jobs for the customer table.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowLog(Rec.RecordId);
                    end;
                }
                group(Coupling)
                {
                    Caption = 'Coupling';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Business Central record and a Microsoft Dataverse row.';

                    action(ManageCDSCoupling)
                    {
                        Caption = 'Set Up Coupling';
                        ApplicationArea = All;
                        Visible = true;
                        Image = LinkAccount;
                        ToolTip = 'Create or modify the coupling to a Microsoft Dataverse Property Unit.';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.DefineCoupling(Rec.RecordId);
                        end;
                    }
                    action(DeleteCDSCoupling)
                    {
                        Caption = 'Delete Coupling';
                        ApplicationArea = All;
                        Visible = true;
                        Image = UnLinkAccount;
                        Enabled = CDSIsCoupledToRecord;
                        ToolTip = 'Delete the coupling to a Microsoft Dataverse Property Unit.';

                        trigger OnAction()
                        var
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        begin
                            CRMCouplingManagement.RemoveCoupling(Rec.RecordId);
                        end;
                    }
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if CDSIntegrationEnabled then
            CDSIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
    end;

    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        CDSIntegrationEnabled: Boolean;
        CDSIsCoupledToRecord: Boolean;
        a: Codeunit 5340;

}
