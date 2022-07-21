
/// <summary>
/// TableExtension ExtSalesAndReceivablesSetupAF (ID 50852) extends Record Sales Receivables Setup.
/// AF-001 - Developer - Christian Gonzales
/// </summary>
tableextension 50852 ExtSalesAndReceivablesSetupAF extends "Sales & Receivables Setup"
{
    fields
    {
        field(50800; "Cut off Time AF"; Time)
        {
            Caption = 'Cut off Time';
            DataClassification = CustomerContent;
        }
        field(50801; "Del. Time Before Cut off AF"; DateFormula)
        {
            Caption = 'Delivery Time Before Cut off';
            DataClassification = CustomerContent;
        }
        field(50802; "Del. Time After Cut off AF"; DateFormula)
        {
            Caption = 'Delivery Time After Cut off';
            DataClassification = CustomerContent;
        }

        field(50810; "Minimum Order Value"; Decimal)
        {
            Caption = 'Minimum Order Value';
            DataClassification = CustomerContent;
        }

        field(50811; "Delivery Fee G/L Account"; Code[20])
        {
            Caption = 'Delivery Fee G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No.";
        }
        field(50812; "Delivery Fee"; Decimal)
        {
            Caption = 'Delivery Fee';
            DataClassification = CustomerContent;
        }
    }
}