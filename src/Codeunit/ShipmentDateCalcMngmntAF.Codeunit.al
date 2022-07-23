/// <summary>
/// Codeunit Shipment Date Mngmnt AF (ID 50802).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
codeunit 50802 "Shipment Date Mngmnt AF"
{
    /// <summary>
    /// CalculateShipmentDate. - Modify Shipment Date base on the Delivery Runs and Sales and Receivable Setup
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    procedure CalculateShipmentDate2(var SalesHeader: Record "Sales Header")
    var
        SalesOrderTimeCreation: Time;
    begin
        SalesSetup.Get();
        SalesOrderTimeCreation := DT2Time(SalesHeader."Order Entry Date/Time AF"); //Get the time
        If SalesOrderTimeCreation > SalesSetup."Cut off Time AF" then begin

        end else begin

        end;


    end;

    procedure CalculateShimentDate(var SalesHeader: Record "Sales Header")
    var
        StrDateFormula: Text[10];
        IntDateFormula: Integer;
        IntCountDateEnabled: Integer;
        CountDisabledDays: Integer;
        TestDate: date;
        VirtualDate: Record Date;
        CountDisabledDays2: Integer;
        CountDisabledDays3: Integer;
        EndInitialCount: Boolean;
    begin

        SalesSetup.Get();

        EntryDate := DT2Date(SalesHeader."Order Entry Date/Time AF");

        EntryTime := DT2Time(SalesHeader."Order Entry Date/Time AF");

        VirtualDate.GET(VirtualDate."Period Type"::Date, EntryDate); //use to get the name of the Day

        CreateDeliveryRunBuffer(SalesHeader);//Create the data for logic calculation

        //<<Calculate the count of date to match in buffer
        IF EntryTime < SalesSetup."Cut off Time AF" then begin

            StrDateFormula := '';
            IntDateFormula := 0;
            StrDateFormula := Format(SalesSetup."Del. Time Before Cut off AF");// Before Cut off
            StrDateFormula := DelChr(StrDateFormula, '=', 'D');
            Evaluate(IntDateFormula, StrDateFormula);
            IntCountDateEnabled := IntDateFormula + 1;

        End else begin
            StrDateFormula := '';
            IntDateFormula := 0;
            StrDateFormula := Format(SalesSetup."Del. Time After Cut off AF");// After Cut off
            StrDateFormula := DelChr(StrDateFormula, '=', 'D');
            Evaluate(IntDateFormula, StrDateFormula);
            IntCountDateEnabled := IntDateFormula + 1;

        end;

        //>>Calculate the count of date to match in buffer
        Clear(TempDeliveryRunBuffer);
        TempDeliveryRunBuffer.SetRange("Day Count", IntCountDateEnabled);
        IF TempDeliveryRunBuffer.FindFirst() then //If enabled in Delivery Run Setup
            If TempDeliveryRunBuffer.Enabled then begin
                SalesHeader.Validate("Shipment Date", CalcDate('''' + Format(IntCountDateEnabled - 1) + 'D' + '''', EntryDate));
            end else begin
                Clear(TempDeliveryRunBuffer);
                EndInitialCount := False;
                TempDeliveryRunBuffer.SetCurrentKey("Day Count");
                //TempDeliveryRunBuffer.Setrange(Enabled, true);
                If TempDeliveryRunBuffer.Findset() then //Get the next enabled day in Delivery Run Setup
                    Repeat
                        //If TempDeliveryRunBuffer."Day Count" >= IntCountDateEnabled then begin
                        //SalesHeader.Validate("Shipment Date",
                        //                    CalcDate('''' + Format(TempDeliveryRunBuffer."Day Count" - 1) + 'D' + '''', EntryDate));
                        CountDisabledDays += 1; //Initial Count

                        IF CountDisabledDays = IntCountDateEnabled then begin
                            CountDisabledDays2 := CountDisabledDays;
                            EndInitialCount := true;
                        end;

                        If EndInitialCount then begin
                            CountDisabledDays2 := CountDisabledDays2 + 1;
                            Clear(TempDeliveryRunBuffer);
                            TempDeliveryRunBuffer.SetCurrentKey("Day Count");
                            TempDeliveryRunBuffer.Setrange("Day Count", CountDisabledDays2);//Check the next day
                            If TempDeliveryRunBuffer.FindFirst() then
                                If not TempDeliveryRunBuffer.Enabled then begin
                                    CountDisabledDays3 := CountDisabledDays2;
                                end else begin
                                    CountDisabledDays3 := CountDisabledDays2 - 1;
                                end;

                        end;
                    Until TempDeliveryRunBuffer.next() = 0;

                SalesHeader.Validate("Shipment Date", CalcDate('''' + Format(CountDisabledDays3) + 'D' + '''', EntryDate));

                //Message('%1', CountDisabledDays);
            end;

        SalesHeader.Modify();
        //TO DO - Check the Cutofftime


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

    local procedure CreateDeliveryRunBuffer(var SalesHeader: Record "Sales Header")
    var
        DeliveryRun: Record "Delivery Run AF";
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

        If DeliveryRun.Get(SalesHeader."Delivery Run Code AF") then begin //Update the Table Buffer for calculation
            IF DeliveryRun.Monday then begin
                TempDeliveryRunBuffer.Get('Monday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 1;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Monday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+6D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Monday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 1;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Monday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+6D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Tuesday then begin
                TempDeliveryRunBuffer.Get('Tuesday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 2;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Tuesday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+7D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Tuesday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 2;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Tuesday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+7D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Wednesday then begin
                TempDeliveryRunBuffer.Get('Wednesday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 3;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Wednesday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+8D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Wednesday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 3;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Wednesday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+8D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Thursday then begin
                TempDeliveryRunBuffer.Get('Thursday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Thursday');
                TempDeliveryRunBuffer."Day Integer" := 4;
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+9D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Thursday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 4;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Thursday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+9D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Friday then begin
                TempDeliveryRunBuffer.Get('Friday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 5;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Friday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+10D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Friday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 5;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Friday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+10D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Saturday then begin
                TempDeliveryRunBuffer.Get('Saturday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 6;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Saturday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+11D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Saturday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 6;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Saturday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+11D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            end;

            IF DeliveryRun.Sunday then begin
                TempDeliveryRunBuffer.Get('Sunday');
                TempDeliveryRunBuffer.Enabled := true;
                TempDeliveryRunBuffer."Day Integer" := 7;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Sunday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+12D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            End else begin
                TempDeliveryRunBuffer.Get('Sunday');
                TempDeliveryRunBuffer.Enabled := false;
                TempDeliveryRunBuffer."Day Integer" := 7;
                TempDeliveryRunBuffer."Day Count" := AssignedDayCount(SalesHeader, 'Sunday');
                TempDeliveryRunBuffer."Calculated Date" := CalcDate('+12D', EntryDate);
                TempDeliveryRunBuffer.Modify();
            end;

        end;
    end;

    local procedure AssignedDayCount(var SalesHeader: Record "Sales Header"; PeriodName: text[20]): Integer
    var
        VirtualDate: Record Date;
    begin
        //>>Get the Day Name(Period Name) and assign the count to 1 and add +1 every next day up to 6D equivalent to 7 Days(1Week)
        VirtualDate.GET(VirtualDate."Period Type"::Date, EntryDate); //use to get the name of the Day
        If VirtualDate."Period Name" = PeriodName then //Get the Name of the Day equal to Delivery Run Set up
            exit(1);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+1D', EntryDate));
        If VirtualDate."Period Name" = PeriodName then
            exit(2);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+2D', EntryDate));
        If VirtualDate."Period Name" = PeriodName then
            exit(3);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+3D', EntryDate));
        If VirtualDate."Period Name" = PeriodName then
            exit(4);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+4D', EntryDate));
        If VirtualDate."Period Name" = PeriodName then
            exit(5);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+5D', EntryDate));
        If VirtualDate."Period Name" = PeriodName then
            exit(6);

        VirtualDate.GET(VirtualDate."Period Type"::Date, Calcdate('+6D', EntryDate));
        If VirtualDate."Period Name" = PeriodName then
            exit(7);
        //<<Get the Day Name(Period Name) and assign the count to 1 and add +1 every next day up to 6D equivalent to 7 Days(1Week)
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        TempDeliveryRunBuffer: Record "Delivery Run Buffer AF" temporary;
        EntryDate: Date;
        EntryTime: Time;
}