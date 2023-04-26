page 83223 "API Property Unit List"
{
    APIGroup = 'PowerBI';
    APIPublisher = 'ACW';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiPropertyUnitList';
    DelayedInsert = true;
    EntityName = 'propertyunitlist';
    EntitySetName = 'propertyunitlist';
    PageType = API;
    SourceTable = "Property Unit";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(propertyNo; Rec."Property No.")
                {
                    Caption = 'Property No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(propertyUnitType; Rec."Property Unit Type")
                {
                    Caption = 'Property Unit Type';
                }
                field(propertyUnitName; Rec."Property Unit Name")
                {
                    Caption = 'Property Unit Name';
                }
                field(propertyUnitGroupNo; Rec."Property Unit Group No.")
                {
                    Caption = 'Property Unit Group No.';
                }
                field(propertyUnitGroup; Rec."Property Unit Group")
                {
                    Caption = 'Property Unit Group';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(countryCode; Rec."Country Code")
                {
                    Caption = 'Country Code';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(propertyUnit; Rec."Property Unit")
                {
                    Caption = 'Property Unit';
                }
                field(roomNo; Rec."Room No.")
                {
                    Caption = 'Room No.';
                }
                field(roomTypeName; Rec."Room Type Name")
                {
                    Caption = 'Room Type Name';
                }
                field(floor; Rec.Floor)
                {
                    Caption = 'Floor';
                }
                field(sortOrder; Rec."Sort Order")
                {
                    Caption = 'Sort Order';
                }
                field(indentation; Rec.Indentation)
                {
                    Caption = 'Indentation';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(crmGUID; Rec."CRM GUID")
                {
                    Caption = 'CRM GUID';
                }
                field(myField; Rec.MyField)
                {
                    Caption = 'MyField';
                }
                field(cleaningStatus; Rec."Cleaning Status")
                {
                    Caption = 'Cleaning Status';
                }
                field(subTypeName; Rec."Sub Type Name")
                {
                    Caption = 'Sub Type Name';
                }
                field(companyGuidForCRM; Rec."Company Guid for CRM")
                {
                    Caption = 'Company Guid for CRM';
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
