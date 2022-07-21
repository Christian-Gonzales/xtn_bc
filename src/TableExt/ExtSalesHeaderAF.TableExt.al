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
        field(50801; "Order Entry Date/Time AF"; DateTime)
        {
            Caption = 'Order Entry Date/Time';
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

    end;

    var

}