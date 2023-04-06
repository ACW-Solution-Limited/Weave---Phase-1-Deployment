table 83028 "Approval Record for PowerApp"
{
    Caption = 'Approval Record for PowerApp';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Key"; Guid)
        {
            Caption = 'Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {

            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(10; "Purchase No."; Code[20])
        {
            Caption = 'Purchase No.';
            DataClassification = ToBeClassified;
        }

        field(3; "Approver ID"; Code[100])
        {
            Caption = 'Approver ID';
            DataClassification = ToBeClassified;
        }
        field(4; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            DataClassification = ToBeClassified;
        }
        field(5; WorkingInstanceID; Guid)
        {
            Caption = 'WorkingInstanceID';
            DataClassification = ToBeClassified;
        }
        field(6; "Approve/Reject"; Option)
        {
            Caption = 'Approve/Reject';
            OptionMembers = " ",Approve,Reject;
            DataClassification = ToBeClassified;
        }
        field(7; Completed; Boolean)
        {
            Caption = 'Completed';
            DataClassification = ToBeClassified;
        }

        field(8; "Record to Approve"; RecordId)
        {
            Caption = 'Record to Approve';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Key", "Line No")
        {
            Clustered = true;
        }

    }
    trigger OnInsert()
    begin
        //   DeleteAll();
    end;

    // procedure GetNextLineNo(): Integer

    // begin
    //     if FindLast() then
    //         exit("Line No" + 10000)
    //     else
    //         exit(10000)
    // end;

}
