page 83034 "Company with Location"
{
    ApplicationArea = All;
    Caption = 'Company with Location';
    PageType = List;
    SourceTable = "Companies with location";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Display Name"; Rec."Display Name")
                {
                    ToolTip = 'Specifies the value of the Display Name field.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.';
                }
            }

        }



    }
    actions
    {

        area(Processing)

        {

            action("&InsertCompany")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Insert Company';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;
                //ShortCutKey = 'Shift+Enter';
                //ToolTip = 'View information about the item.';
                trigger OnAction()
                var
                    l_reccompany: Record Company;
                    l_reccompanywithlocation: Record "Companies with location";
                begin
                    //     l_reccompany.reset;
                    //     l_reccompanywithlocation.Get;
                    //     If l_reccompany.FindSet() then begin
                    //         repeat
                    //             l_reccompanywithlocation.reset;
                    //             l_reccompanywithlocation.SetRange(Name, l_reccompany.Name);
                    //             If Not l_reccompanywithlocation.FindSet() then begin
                    //                 l_reccompanywithlocation.init;
                    //                 l_reccompanywithlocation.Name := l_reccompany.Name;
                    //                 l_reccompanywithlocation."Display Name" := l_reccompany."Display Name";
                    //                 l_reccompanywithlocation.Insert();

                    //             end;

                    // end;
                end;
            }



        }
    }

}
