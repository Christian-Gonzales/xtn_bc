
/// <summary>
/// TableExtension ExtShipToAddressAF (ID 50850) extends Record Ship-to Address.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
tableextension 50850 ExtShipToAddressAF extends "Ship-to Address"
{
    fields
    {
        field(50800; "Delivery Run Code AF"; Code[20])
        {
            Caption = 'Delivery Run Code';
            DataClassification = CustomerContent;
            TableRelation = "Delivery Run AF"."Run Code";
            ValidateTableRelation = true;
        }
    }
}