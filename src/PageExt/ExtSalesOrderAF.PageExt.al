/// <summary>
/// PageExtension ExtSalesOrderAF (ID 50852) extends Record Sales Order.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
pageextension 50852 ExtSalesOrderAF extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Shipment Date AF"; Rec."Shipment Date")
            {
                ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                ApplicationArea = All;
            }
        }
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
                Editable = true;
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //Record this on page level, recording from API is the value coming from CP
        SalesSetup.GET();
        Rec."Cust. Portal Cut off Time AF" := SalesSetup."Cut off Time AF";
        Rec."Order Entry Date/Time AF" := CurrentDateTime;
        //Record this on page level, recording from API is the value coming from CP   
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";

}