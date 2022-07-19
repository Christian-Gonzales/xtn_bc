page 50804 "Sales Setup CP API AF"
{
    APIPublisher = 'altafirma';
    APIGroup = 'sale';
    APIVersion = 'v1.0';
    EntityName = 'saleSetupCP';
    EntitySetName = 'salesSetUpCP';
    Caption = 'Sales Setup CP API', Locked = true;
    DelayedInsert = true;
    PageType = API;
    SourceTable = "Sales & Receivables Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    ODataKeyFields = "Primary Key";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(primaryKey; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(cutOffTime; Rec."Cut off Time AF")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(deliveryTimeAfterCutOff; Rec."Del. Time Before Cut off AF")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(DeliveryTimeBeforeCutOff; Rec."Del. Time After Cut off AF")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    var

    begin

    end;

    var

}