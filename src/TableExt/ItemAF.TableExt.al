
/// <summary>
/// TableExtension ItemAF (ID 50800) extends Record Item.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
tableextension 50800 ItemAF extends "Item"//xtn-Should not be included
{
    fields
    {
        field(50800; "Picture as Text AF"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Picture as Text';
        }
    }
}