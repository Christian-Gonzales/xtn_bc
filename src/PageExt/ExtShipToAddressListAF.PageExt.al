/// <summary>
/// PageExtension ExtShipToAddressListAF (ID 50851) extends Record Ship-to Address List.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
pageextension 50851 ExtShipToAddressListAF extends "Ship-to Address List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("Delivery Run Code AF"; Rec."Delivery Run Code AF")
            {
                Caption = 'Delivery Run Code';
                ToolTip = 'Specifies the delivery run code use in ship to address.';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var

}