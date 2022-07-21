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
                ToolTip = 'Specifies the delivery run code use in ship to address.';
                ApplicationArea = All;
                Editable = false;
            }
            field("Order Entry Date Time AF"; Rec."Order Entry Date/Time AF")
            {
                ToolTip = 'Specifies the order entry date and time.';
                ApplicationArea = All;
                Editable = false;
            }

            field("Cust. Portal Cut off Time AF"; Rec."Cust. Portal Cut off Time AF")
            {
                ToolTip = 'Specifies the Customer Portal Cut off Time.';
                ApplicationArea = All;
                Editable = false;
            }

            field("Delivery Fee AF"; Rec."Delivery Fee AF")
            {
                ToolTip = 'Specifies the sales line having a delivery fee.';
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