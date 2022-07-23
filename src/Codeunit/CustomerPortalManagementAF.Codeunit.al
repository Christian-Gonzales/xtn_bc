/// <summary>
/// Codeunit Customer Portal Management AF (ID 50801).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
codeunit 50801 "Customer Portal Management AF"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforePerformManualReleaseProcedure', '', false, false)]
    local procedure OnBeforePerformManualReleaseProcedure(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean);
    begin
        If Not SalesHeader."Delivery Fee AF" then
            if HasDeliveryFeeAF(SalesHeader) then
                If not Confirm('Delivery Fee will be added as it is below the Minimum Order Value. Do you want to continue?', true) then begin
                    Message('Release sales order cancelled.');
                    IsHandled := True;
                end else
                    InsertSalesLineDeliveryChargeAF(SalesHeader);
    end;

    local procedure HasDeliveryFeeAF(var SalesHeader: Record "Sales Header"): Boolean
    var
        SalesLine: Record "Sales Line";
        TotalSalesAmount: Decimal;
    begin
        SalesSetup.Get();
        TotalSalesAmount := 0;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.Findset then
            repeat
                TotalSalesAmount += SalesLine."Amount Including VAT";
            Until SalesLine.next() = 0;

        If SalesSetup."Minimum Order Value" > TotalSalesAmount then
            exit(true)
        else
            exit(false);
    end;

    local procedure InsertSalesLineDeliveryChargeAF(var SalesHeader: Record "Sales Header")
    var
        LastSalesLine: Record "Sales Line";
        LineNo: Integer;
        SalesLine: Record "Sales Line";
    begin
        SalesSetup.Get();
        SalesSetup.TestField("Delivery Fee G/L Account");
        Clear(LastSalesLine);
        LineNo := 0;
        LastSalesLine.SetRange("Document Type", SalesHeader."Document Type");
        LastSalesLine.SetRange("Document No.", SalesHeader."No.");
        LastSalesLine.FindLast();
        LineNo := LastSalesLine."Line No." + 10000;// Get and assigned the Line No.

        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := LineNo;
        SalesLine.Insert(true);
        SalesLine.Type := SalesLine.Type::"G/L Account";
        SalesLine.Validate("No.", SalesSetup."Delivery Fee G/L Account");
        SalesLine.Validate(Quantity, 1);
        SalesLine.Validate("Unit Price", SalesSetup."Delivery Fee");
        SalesLine."Delivery Fee AF" := true;
        SalesLine.Modify();

        SalesHeader."Delivery Fee AF" := true;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
}