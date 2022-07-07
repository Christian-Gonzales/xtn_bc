/// <summary>
/// Page Customer API (ID 50000) 
/// Developer - Christian Gonzales
/// Customer Lists V1.1
/// </summary>
page 50000 "Customer CP API AF"
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

                field(custContactName; Rec.Contact)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                //field(custABN; Rec.ABN) 
                //{
                //ApplicationArea = All;
                //Editable = false;
                //}
                field(custEmailAddress; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(custPhoneNo; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(custMobilePhoneNo; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(custFaxNo; Rec."Fax No.")
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