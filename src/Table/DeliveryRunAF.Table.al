/// <summary>
/// Table Delivery Run AF (ID 50830).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
table 50830 "Delivery Run AF"
{
    Caption = 'Delivery Run';
    DataCaptionFields = "Run Code", "Run Description";
    DrillDownPageID = "Delivery Run List AF";
    LookupPageID = "Delivery Run List AF";

    fields
    {
        field(1; "Run Code"; Code[20])
        {
            Caption = 'Run Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(2; "Run Description"; Text[100])
        {
            Caption = 'Run Description';
            DataClassification = CustomerContent;

        }

        field(11; Monday; Boolean)
        {
            Caption = 'Monday';
            DataClassification = CustomerContent;

        }
        field(12; Tuesday; Boolean)
        {
            Caption = 'Tuesday';
            DataClassification = CustomerContent;

        }
        field(13; Wednesday; Boolean)
        {
            Caption = 'Wednesday';
            DataClassification = CustomerContent;

        }

        field(14; Thursday; Boolean)
        {
            Caption = 'Thursday';
            DataClassification = CustomerContent;

        }

        field(15; Friday; Boolean)
        {
            Caption = 'Friday';
            DataClassification = CustomerContent;

        }

        field(16; Saturday; Boolean)
        {
            Caption = 'Saturday';
            DataClassification = CustomerContent;
        }
        field(17; Sunday; Boolean)
        {
            Caption = 'Sunday';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Run Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Run Code", "Run Description")
        {
        }
    }

    var

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}