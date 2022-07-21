/// <summary>
/// PageExtension ExtSalesAndReceivablesSetupAF (ID 50853) extends Record Sales Receivables Setup.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
pageextension 50853 ExtSalesAndReceivablesSetupAF extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(Dimensions)
        {
            Group("Customer Portal Setup")
            {
                Caption = 'Customer Portal Setup';
                field("Cut off Time"; Rec."Cut off Time AF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Cut off time for Shipment Date calculation.';
                }
                field("Delivery Time Before Cut off"; Rec."Del. Time Before Cut off AF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date formula to calculate the Shipment Date when order entered before the Cut off time.';
                }
                field("Delivery Time After Cut off"; Rec."Del. Time After Cut off AF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date formula to calculate the Shipment Date when order entered after the Cut off time.';
                }
                field("Delivery Fee G/L Account"; Rec."Delivery Fee G/L Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account charging delivery fee on the sales order.';
                }
                field("Delivery Fee"; Rec."Delivery Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the delivery fee amount.';
                }
                field("Minimum Order Value"; Rec."Minimum Order Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum order total amount per sales transaction. Amount below this value will be charge delivery fee.';
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var

}