/// <summary>
/// PageExtension ExtSalesOrderAF (ID 50852) extends Record Sales Order.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
pageextension 50852 ExtSalesOrderAF extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Delivery Run Code AF"; Rec."Delivery Run Code AF")
            {
                Caption = 'Delivery Run Code';
                ToolTip = 'Specifies the delivery run code use in ship to address.';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var

}