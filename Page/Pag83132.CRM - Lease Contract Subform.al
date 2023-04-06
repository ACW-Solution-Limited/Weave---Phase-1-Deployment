page 83132 "CRM Lease Contract Subform"
{
    Caption = 'Lease Contract Subform';
    PageType = ListPart;
    SourceTable = "CDS acwapp_bookingline";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(acwapp_name; Rec.acwapp_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }

                field(acwapp_PropertyUnitName; Rec.acwapp_PropertyUnitName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the acwapp_PropertyUnitName field.';
                    Caption = 'Property Unit Name';
                }
                field(acwapp_StartDate; Rec.acwapp_StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(acwapp_EndDate; Rec.acwapp_EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(acwapp_price_Base; Rec.acwapp_price_Base)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price (Base) field.';
                }

            }
        }
    }
    procedure SetCurrentlyCoupledCRMPropertybookingline(CRMPropertybookingline: Record "CDS acwapp_bookingline")
    begin
        CurrentlyCoupledCRMPropertybookingLine := CRMPropertybookingline;
    end;

    var
        CurrentlyCoupledCRMPropertybookingLine: Record "CDS acwapp_bookingline";
}



