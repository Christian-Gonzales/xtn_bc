/// <summary>
/// Page Customer API (ID 50000) 
/// Developer - Christian Gonzales
/// </summary>
page 50000 "Vendor VP API BETT"
{
    APIPublisher = 'altafirma';
    APIGroup = 'sale';
    APIVersion = 'v1.0';
    EntityName = 'customerCP';
    EntitySetName = 'customersCP';
    Caption = 'Customer CP API', Locked = true;
    DelayedInsert = true;
    PageType = API;
    SourceTable = customer;
    InsertAllowed = false;
    DeleteAllowed = false;
    ODataKeyFields = "No.";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(custNo; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(custName; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(emailAddress; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(creditLimit; Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    }
    var

}