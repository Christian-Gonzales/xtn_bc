/// <summary>
/// Page Item API (ID 50801) 
/// AF-001 - Developer - Christian Gonzales
/// </summary>
page 50805 "Ship To Address CP API AF"
{
    APIPublisher = 'altafirma';
    APIGroup = 'sale';
    APIVersion = 'v1.0';
    EntityName = 'shipToAddressCP';
    EntitySetName = 'shipToAddressesCP';
    Caption = 'Ship to Address CP API', Locked = true;
    DelayedInsert = true;
    PageType = API;
    SourceTable = "Ship-to Address";
    InsertAllowed = false;
    DeleteAllowed = false;
    ODataKeyFields = "Customer No.", Code;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(customerNo; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(code; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(address; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(city; Rec.City)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(postCode; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(deliveryRunCode; Rec."Delivery Run Code AF")
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