/// <summary>
/// TableExtension ExtSalesInvoiceHeaderAF (ID 50854) extends Record Sales Invoice Header.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
tableextension 50854 ExtSalesInvoiceHeaderAF extends "Sales Invoice Header"
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
        field(50801; "Order Entry Time AF"; Time)
        {
            Caption = 'Order Entry Time';
            DataClassification = CustomerContent;
        }

        field(50802; "Cust. Portal Cut off Time AF"; Time)
        {
            Caption = 'Cust. Portal Cut off Time';
            DataClassification = CustomerContent;
        }

        field(50810; "Delivery Fee AF"; Boolean)
        {
            Caption = 'Delivery Fee';
            DataClassification = CustomerContent;
            Editable = false;
        }

    }

    trigger OnInsert()
    var

    begin
       
    end;

    var
        
}