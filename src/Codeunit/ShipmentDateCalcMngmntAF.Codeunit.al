/// <summary>
/// Codeunit Shipment Date Mngmnt AF (ID 50802).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
codeunit 50802 "Shipment Date Mngmnt AF"
{
    /// <summary>
    /// CalculateShipmentDate.
    /// </summary>
    /// <param name="SalesHeader">VAR Record "Sales Header".</param>
    procedure CalculateShipmentDate(var SalesHeader: Record "Sales Header")
    var
        DeliveryRun: Record "Delivery Run AF";
        VirtualDate: Record Date;
        IntDateCount: Integer;
        CalculatedDateCount: DateFormula;
        i: Integer;
        FromDate: Date;
        ToDate: Date;
        IsEnableInDeliVeryRun: Boolean;
        NextDate: Date;
        EntryTime: Time;
    begin

        SalesSetup.Get();

        IsEnableInDeliVeryRun := false;//Use to mark if the day is enabled in delivery runs

        FromDate := DT2Date(SalesHeader."Order Entry Date/Time AF");//Get the Date
        EntryTime := DT2Time(SalesHeader."Order Entry Date/Time AF");//Get the Time

        IF EntryTime < SalesSetup."Cut off Time AF" then //Check if Before or After Cutoff
            ToDate := Calcdate(SalesSetup."Del. Time Before Cut off AF", FromDate)
        else
            ToDate := Calcdate(SalesSetup."Del. Time After Cut off AF", FromDate);

        VirtualDate.GET(VirtualDate."Period Type"::Date, ToDate);//Use to get the Day Name of Current Date

        If DeliveryRun.Get(SalesHeader."Delivery Run Code AF") then begin
            IF DeliveryRun.Monday then Begin //Check if the date is enable
                IF VirtualDate."Period Name" = 'Monday' then begin
                    SalesHeader.Validate(SalesHeader."Shipment Date", ToDate);
                    SalesHeader.Modify;
                    IsEnableInDeliVeryRun := True;
                end;
            end;
            IF DeliveryRun.Tuesday then Begin
                IF VirtualDate."Period Name" = 'Tuesday' then begin
                    SalesHeader.Validate(SalesHeader."Shipment Date", ToDate);
                    SalesHeader.Modify;
                    IsEnableInDeliVeryRun := True;
                end;
            end;

            IF DeliveryRun.Wednesday then Begin
                IF VirtualDate."Period Name" = 'Wednesday' then begin
                    SalesHeader.Validate(SalesHeader."Shipment Date", ToDate);
                    SalesHeader.Modify;
                    IsEnableInDeliVeryRun := True;
                end;
            end;

            IF DeliveryRun.Thursday then Begin
                IF VirtualDate."Period Name" = 'Thursday' then begin
                    SalesHeader.Validate(SalesHeader."Shipment Date", ToDate);
                    SalesHeader.Modify;
                    IsEnableInDeliVeryRun := True;
                end;
            end;

            IF DeliveryRun.Friday then Begin
                IF VirtualDate."Period Name" = 'Friday' then begin
                    SalesHeader.Validate(SalesHeader."Shipment Date", ToDate);
                    SalesHeader.Modify;
                    IsEnableInDeliVeryRun := True;
                end;
            end;

            IF DeliveryRun.Saturday then Begin
                IF VirtualDate."Period Name" = 'Saturday' then begin
                    SalesHeader.Validate(SalesHeader."Shipment Date", ToDate);
                    SalesHeader.Modify;
                    IsEnableInDeliVeryRun := True;
                end;
            end;

            IF DeliveryRun.Sunday then Begin
                IF VirtualDate."Period Name" = 'Sunday' then begin
                    SalesHeader.Validate(SalesHeader."Shipment Date", ToDate);
                    SalesHeader.Modify;
                    IsEnableInDeliVeryRun := True;
                end;
            end;

            IF Not IsEnableInDeliVeryRun then begin //Loop to the next date if the ToDate (DayName) is not enable in delivery run
                For i := 1 to 6 Do begin
                    NextDate := CalcDate('''' + Format(i) + 'D' + '''', ToDate);
                    VirtualDate.GET(VirtualDate."Period Type"::Date, NextDate);
                    IF DeliveryRun.Monday then Begin
                        IF VirtualDate."Period Name" = 'Monday' then begin
                            SalesHeader.Validate(SalesHeader."Shipment Date", NextDate);
                            SalesHeader.Modify;
                            Break;//Stop the loop if already match the day name and setup in delivery Run
                        end;
                    end;
                    IF DeliveryRun.Tuesday then Begin
                        IF VirtualDate."Period Name" = 'Tuesday' then begin
                            SalesHeader.Validate(SalesHeader."Shipment Date", NextDate);
                            SalesHeader.Modify;
                            Break;
                        end;
                    end;

                    IF DeliveryRun.Wednesday then Begin
                        IF VirtualDate."Period Name" = 'Wednesday' then begin
                            SalesHeader.Validate(SalesHeader."Shipment Date", NextDate);
                            SalesHeader.Modify;
                            Break;
                        end;
                    end;

                    IF DeliveryRun.Thursday then Begin
                        IF VirtualDate."Period Name" = 'Thursday' then begin
                            SalesHeader.Validate(SalesHeader."Shipment Date", NextDate);
                            SalesHeader.Modify;
                            Break;
                        end;
                    end;

                    IF DeliveryRun.Friday then Begin
                        IF VirtualDate."Period Name" = 'Friday' then begin
                            SalesHeader.Validate(SalesHeader."Shipment Date", NextDate);
                            SalesHeader.Modify;
                            Break;
                        end;
                    end;

                    IF DeliveryRun.Saturday then Begin
                        IF VirtualDate."Period Name" = 'Saturday' then begin
                            SalesHeader.Validate(SalesHeader."Shipment Date", NextDate);
                            SalesHeader.Modify;
                            Break;
                        end;
                    end;

                    IF DeliveryRun.Sunday then Begin
                        IF VirtualDate."Period Name" = 'Sunday' then begin
                            SalesHeader.Validate(SalesHeader."Shipment Date", NextDate);
                            SalesHeader.Modify;
                            Break;
                        end;
                    end;

                end;

            end;
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";

}