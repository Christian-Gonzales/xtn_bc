/// <summary>
/// TableExtension ExtSalesShipmentLineAF (ID 50856) extends Record Sales Shipment Line.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
tableextension 50856 ExtSalesShipmentLineAF extends "Sales Shipment Line"
{
    fields
    {
        field(50810; "Delivery Fee AF"; Boolean)
        {
            Caption = 'Delivery Fee';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    var
}