/// <summary>
/// Page Delivery Run CP API AF (ID 50803).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
page 50803 "Delivery Run CP API AF"
{
    APIPublisher = 'altafirma';
    APIGroup = 'sale';
    APIVersion = 'v1.0';
    EntityName = 'deliveryRunCP';
    EntitySetName = 'deliveryRunsCP';
    Caption = 'Delivery Run CP API', Locked = true;
    DelayedInsert = true;
    PageType = API;
    SourceTable = "Delivery Run AF";
    InsertAllowed = false;
    DeleteAllowed = false;
    ODataKeyFields = "Run Code";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(runCode; Rec."Run Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(runDescription; Rec."Run Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(monday; Rec.Monday)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(tuesday; Rec.Tuesday)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(wednesday; Rec.Wednesday)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(thursday; Rec.Thursday)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(friday; Rec.Friday)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(saturday; Rec.Saturday)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(sunday; Rec.Sunday)
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