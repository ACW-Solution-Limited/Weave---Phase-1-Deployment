pageextension 82006 "Bank Acc. Reconciliation Ext" extends "Bank Acc. Reconciliation"
{
    actions
    {
        addafter("Ba&nk")
        {
            action("HSBC Import Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import HSBC Bank Statement';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ImportHSBC: XmlPort "Bank Recon. HSBC";
                begin
                    ImportHSBC.SetNo(Rec."Bank Account No.", Rec."Statement No.");
                    ImportHSBC.run;
                end;

            }
            action("BEA Import Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import BEA Bank Statement';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ImportBEA: XmlPort "Bank Recon. BEA";
                begin
                    ImportBEA.SetNo(Rec."Bank Account No.", Rec."Statement No.");
                    ImportBEA.run;
                end;

            }
            action("OCBC Import Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import OCBC Bank Statement';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ImportOCBC: XmlPort "Bank Recon. OCBC";
                begin
                    ImportOCBC.SetNo(Rec."Bank Account No.", Rec."Statement No.");
                    ImportOCBC.run;
                end;

            }
        }
    }

}

