/// <summary>
/// Table Delivery Run Buffer AF (ID 50831).
/// Use to count the date base on Delivery Run Setup
/// AF-001 - Developer - Christian Gonzales
/// </summary>
table 50831 "Delivery Run Buffer AF"
{
    Caption = 'Delivery Run Buffer';

    fields
    {
        field(1; Day; Text[50])
        {
            Caption = 'Days';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(2; Enabled; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = CustomerContent;

        }

        field(11; "Day Count"; integer)
        {
            Caption = 'Count';
            DataClassification = CustomerContent;

        }
        field(12; "Day Integer"; integer)
        {
            Caption = 'Day Integer';
            DataClassification = CustomerContent;

        }

        field(13; "Calculated Date"; Date)
        {
            Caption = 'Calculated Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Day)
        {
            Clustered = true;
        }
        key(Key2; Enabled)
        {
        }

        key(Key3; "Day Integer")
        {
        }
    }

}