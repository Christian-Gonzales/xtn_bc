/// <summary>
/// Page Sales Order Header CP API AF (ID 50802).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
page 50802 "Sales Order Header CP API AF"
{
    APIPublisher = 'altafirma';
    APIGroup = 'sale';
    APIVersion = 'v1.0';
    EntityName = 'insertSalesOrderHeaderCP';
    EntitySetName = 'insertSalesOrdersHeaderCP';
    Caption = 'Sales Order CP API', Locked = true;
    DelayedInsert = true;
    PageType = API;
    SourceTable = "Sales Header";
    InsertAllowed = true;
    DeleteAllowed = false;
    SourceTableView = where("Document Type" = const(Order));
    ODataKeyFields = "No.";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(docNo; DocNo)
                {
                    Caption = 'DocNo';
                    ApplicationArea = All;
                }
                field(sellToCustNo; SellToCustomerNo)
                {
                    Caption = 'DocNo';
                    ApplicationArea = All;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DocNo := Rec."No.";
        SellToCustomerNo := Rec."Sell-to Customer No.";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var

    begin
        clear(SalesOrderHeader);

        SalesOrderHeader."Document Type" := SalesOrderHeader."Document Type"::Order;
        SalesOrderHeader."No." := DocNo; //If using Manual No. Series
        SalesOrderHeader.INSERT(TRUE);
        SalesOrderHeader.Validate("Sell-to Customer No.", SellToCustomerNo);
        SalesOrderHeader.MODIFY(TRUE);

        UpdateResponse();

        exit(false);
    end;

    local procedure UpdateResponse()
    var

    begin
        DocNo := SalesOrderHeader."No.";
        SellToCustomerNo := SalesOrderHeader."Sell-to Customer No.";
    end;

    /// <summary>
    /// postOrder.
    /// </summary>
    /// <param name="actionContext">VAR WebServiceActionContext.</param>
    [ServiceEnabled]
    procedure postOrder(var actionContext: WebServiceActionContext)
    var

    begin
        HandleActionContext(actionContext, WebServiceActionResultCode::Updated);
        //Rec.Receive := true;
        //Invoice := true;
        //Rec.Modify(true);

    end;

    local procedure handleActionContext(var actionContext: WebServiceActionContext; WebServiceAction: WebServiceActionResultCode)
    begin
        //actionContext.SetObjectType(ObjectType::Page);
        //actionContext.SetObjectId(Page::"Sales Order Header CP API AF");
        //actionContext.SetResultCode(WebServiceAction);
    end;

    var
        SalesOrderHeader: Record "Sales Header";
        DocNo: Code[20];
        SellToCustomerNo: Code[20];

}