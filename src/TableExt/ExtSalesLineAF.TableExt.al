/// <summary>
/// TableExtension ExtSalesLineAF (ID 50853) extends Record Sales Header.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
tableextension 50853 ExtSalesLineAF extends "Sales Line"
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

    trigger OnInsert()
    var

    begin

    end;

    trigger OnDelete()
    var
        SalesHeader: Record "Sales Header";
    begin
        If Rec."Delivery Fee AF" then begin
            SalesHeader.Get(rec."Document Type", Rec."Document No.");
            SalesHeader."Delivery Fee AF" := false;
            SalesHeader.modify();
        end;
    end;

    var
}