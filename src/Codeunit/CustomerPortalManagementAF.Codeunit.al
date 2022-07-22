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

    /// <summary>
    /// CalculateShipmentDate. - Modify Shipment Date base on the Delivery Runs and Sales and Receivable Setup
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    procedure CalculateShipmentDate(var SalesHeader: Record "Sales Header")
    var
        SalesOrderTimeCreation: Time;
    begin
        SalesSetup.Get();
        SalesOrderTimeCreation := DT2Time(SalesHeader."Order Entry Date/Time AF"); //Get the time
        If SalesOrderTimeCreation > SalesSetup."Cut off Time AF" then begin

        end else begin

        end;


    end;

    procedure ConvertDeiveryRunSetupToCount(var SalesHeader: Record "Sales Header")
    var
        TempDeliveryRunBuffer: Record "Delivery Run Buffer AF" temporary;
        SalesSetup: Record "Sales & Receivables Setup";
        DeliveryRun: Record "Delivery Run AF";
        StrDateFormulaBefore: Text[10];
        IntDateFormulaBefore: Integer;
        IntCountDateEnabled: Integer;
        TestDate: date;

    begin
        TempDeliveryRunBuffer.DeleteAll();
        SalesSetup.Get();
        TempDeliveryRunBuffer.Day := 'Monday';
        TempDeliveryRunBuffer.Insert();
        TempDeliveryRunBuffer.Day := 'Tuesday';
        TempDeliveryRunBuffer.Insert();
        TempDeliveryRunBuffer.Day := 'Wednesday';
        TempDeliveryRunBuffer.Insert();
        TempDeliveryRunBuffer.Day := 'Thursday';
        TempDeliveryRunBuffer.Insert();
        TempDeliveryRunBuffer.Day := 'Friday';
        TempDeliveryRunBuffer.Insert();
        TempDeliveryRunBuffer.Day := 'Saturday';
        TempDeliveryRunBuffer.Insert();
        TempDeliveryRunBuffer.Day := 'Sunday';
        TempDeliveryRunBuffer.Insert();//Insert The days

        If DeliveryRun.Get('AF-001') then begin //Update the Table Buffer for calculation
            IF DeliveryRun.Monday then begin
                TempDeliveryRunBuffer.Get('Monday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 1;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Monday');
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Monday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 1;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Monday');
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Tuesday then begin
                TempDeliveryRunBuffer.Get('Tuesday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 2;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Tuesday');
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Tuesday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 2;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Tuesday');
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Wednesday then begin
                TempDeliveryRunBuffer.Get('Wednesday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 3;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Wednesday');
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Wednesday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 3;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Wednesday');
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Thursday then begin
                TempDeliveryRunBuffer.Get('Thursday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Thursday');
                TempDeliveryRunBuffer."Day Integer" := 4;
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Thursday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 4;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Thursday');
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Friday then begin
                TempDeliveryRunBuffer.Get('Friday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 5;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Friday');
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Friday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 5;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Friday');
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Saturday then begin
                TempDeliveryRunBuffer.Get('Saturday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 6;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Saturday');
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Saturday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 6;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Saturday');
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Sunday then begin
                TempDeliveryRunBuffer.Get('Sunday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 7;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Sunday');
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Sunday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 7;
                TempDeliveryRunBuffer."Day Count" := GetVitualDatePeriodName(SalesHeader, 'Sunday');
                TempDeliveryRunBuffer.Modify();
            end;

        end;

        //Calculate the count of date to match in buffer
        StrDateFormulaBefore := '';
        IntDateFormulaBefore := 0;
        StrDateFormulaBefore := Format(SalesSetup."Del. Time Before Cut off AF");
        StrDateFormulaBefore := DelChr(StrDateFormulaBefore, '=', 'D');
        Evaluate(IntDateFormulaBefore, StrDateFormulaBefore);
        IntCountDateEnabled := IntDateFormulaBefore + 1;
        //<<Calculate the count of date to match in buffer

        Clear(TempDeliveryRunBuffer);
        TempDeliveryRunBuffer.SetRange("Day Count", IntCountDateEnabled);
        IF TempDeliveryRunBuffer.FindFirst() then begin
            If TempDeliveryRunBuffer.Enabled then begin
                testDate := CalcDate('''' + Format(IntCountDateEnabled - 1) + 'D' + '''', SalesHeader."Posting Date");
                Message('%1', Testdate);
            end else begin
                Clear(TempDeliveryRunBuffer);
                TempDeliveryRunBuffer.SetCurrentKey("Day Count");
                TempDeliveryRunBuffer.Setrange(Enabled, true);
                If TempDeliveryRunBuffer.Findset() then
                    Repeat
                        If TempDeliveryRunBuffer."Day Count" >= IntCountDateEnabled then begin
                            testDate := CalcDate('''' + Format(TempDeliveryRunBuffer."Day Count" - 1) + 'D' + '''', SalesHeader."Posting Date");
                            Message('%1', Testdate);
                            Break;
                        End;
                    Until TempDeliveryRunBuffer.Next() = 0;
            end;
        end else begin

        end;


        //Clear(TempDeliveryRunBuffer);
        //TempDeliveryRunBuffer.SetCurrentKey("Day Count");
        //TempDeliveryRunBuffer.Setrange(Enabled, true);
        //If TempDeliveryRunBuffer.Findfirst() then
        //Repeat
        //If TempDeliveryRunBuffer."Day Count" >= IntCountDateEnabled then
        //testDate := CalcDate('''' + Format(TempDeliveryRunBuffer."Day Count" - 1) + 'D' + '''', SalesHeader."Posting Date");
        //Break;
        //Until TempDeliveryRunBuffer.Next() = 0;
        //VirtualDate.GET(VirtualDate."Period Type"::Date, calcdate('+1D', SalesHeader."Posting Date"));
        //Message('%1', VirtualDate."Period No.");

    end;

    local procedure GetVitualDatePeriodName(var SalesHeader: Record "Sales Header"; PeriodName: text[20]): Integer
    var
        VirtualDate: Record Date;
    begin
        //Get the Day Name(Period Name) and assign the count to 1 and add +1 every next day
        VirtualDate.GET(VirtualDate."Period Type"::Date, SalesHeader."Posting Date");
        If VirtualDate."Period Name" = PeriodName then
            exit(1);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+1D', SalesHeader."Posting Date"));
        If VirtualDate."Period Name" = PeriodName then
            exit(2);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+2D', SalesHeader."Posting Date"));
        If VirtualDate."Period Name" = PeriodName then
            exit(3);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+3D', SalesHeader."Posting Date"));
        If VirtualDate."Period Name" = PeriodName then
            exit(4);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+4D', SalesHeader."Posting Date"));
        If VirtualDate."Period Name" = PeriodName then
            exit(5);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+5D', SalesHeader."Posting Date"));
        If VirtualDate."Period Name" = PeriodName then
            exit(6);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+6D', SalesHeader."Posting Date"));
        If VirtualDate."Period Name" = PeriodName then
            exit(7);
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
}