page 83024 "API Generic User"
{
    APIGroup = 'app1';
    APIPublisher = 'weave';
    APIVersion = 'v2.0';
    Caption = 'apiGenericUser';
    DelayedInsert = true;
    EntityName = 'GenericUsers';
    EntitySetName = 'GenericUsers';
    PageType = API;
    SourceTable = "Generic User";


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(userName; Rec."User Name")
                {
                    Caption = 'User Name';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                }
                field(venderNo; Rec."Vender No.")
                {
                    Caption = 'Vender No.';
                }
                field(venderName; Rec."Vender Name")
                {
                    Caption = 'Vender Name';
                }
            }
        }
    }
}
