/// <summary>
/// TableExtension ExtSalesHeaderAF (ID 50851) extends Record Sales Header.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
tableextension 50851 ExtSalesHeaderAF extends "Sales Header"
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

        modify("Ship-to code")
        {
            trigger OnAfterValidate()
            var
                ShipToAddress: Record "Ship-to Address";
            begin
                If ShipToAddress.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code") then
                    If ShipToAddress."Delivery Run Code AF" = '' then
                        Error('Delivery Run Code field must have a value in Ship-to Address %1', Rec."Ship-to Code")
                    Else
                        Rec."Delivery Run Code AF" := ShipToAddress."Delivery Run Code AF";
            end;
        }
    }

    trigger OnInsert()
    var

    begin
        //To-Do need to check if that should be recorded when using manual sales order only
        SalesSetup.GET();
        Rec."Cust. Portal Cut off Time AF" := SalesSetup."Cut off Time AF";
        Rec."Order Entry Time AF" := Time;
        //To-Do need to check if that should be recorded when using manual sales order only
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
}