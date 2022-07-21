/// <summary>
/// TableExtension ExtSalesInvoiceLineAF (ID 50857) extends Record Sales Invoice Line.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
tableextension 50857 ExtSalesInvoiceLineAF extends "Sales Invoice Line"
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