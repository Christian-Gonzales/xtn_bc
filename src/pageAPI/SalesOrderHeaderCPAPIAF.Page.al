/// <summary>
/// Page Sales Order Header CP API AF (ID 50802).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
page 50802 "Sales Order Header CP API AF"
{
    APIPublisher = 'altafirma';
    APIGroup = 'sale';
    APIVersion = 'v1.0';
    EntityName = 'SalesOrderHeaderCP';
    EntitySetName = 'SalesOrdersHeaderCP';
    Caption = 'Sales Order CP API', Locked = true;
    DelayedInsert = true;
    PageType = API;
    SourceTable = "Sales Header";
    InsertAllowed = true;
    DeleteAllowed = false;
    SourceTableView = where("Document Type" = const(Order));
    ODataKeyFields = "Document Type", "No.";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(recDocType; Rec."Document Type")
                {
                    Caption = 'recDocType';
                    ApplicationArea = All;
                }
                field(recNo; Rec."No.")
                {
                    Caption = 'recNo';
                    ApplicationArea = All;
                }
                field(docNo; DocNo)
                {
                    Caption = 'DocNo';
                    ApplicationArea = All;
                }
                field(sellToCustomerNo; SellToCustomerNo)
                {
                    Caption = 'SellToCustomerNo';
                    ApplicationArea = All;
                }

                field(externalDocNo; ExternalDocNo)
                {
                    Caption = 'ExternalDocno';
                    ApplicationArea = All;
                }

                field(shipmentDate; ShipmentDate)
                {
                    Caption = 'ShipmentDate';
                    ApplicationArea = All;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DocNo := Rec."No.";
        SellToCustomerNo := Rec."Sell-to Customer No.";
        ExternalDocNo := Rec."External Document No.";
        ShipmentDate := Rec."Shipment Date";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var

    begin
        clear(SalesOrderHeader);

        SalesOrderHeader."Document Type" := SalesOrderHeader."Document Type"::Order;
        SalesOrderHeader."No." := DocNo; //If using Manual No. Series
        SalesOrderHeader.INSERT(TRUE);
        SalesOrderHeader.Validate("Sell-to Customer No.", SellToCustomerNo);
        SalesOrderHeader."External Document No." := ExternalDocNo;
        SalesOrderHeader."Shipment Date" := ShipmentDate;
        SalesOrderHeader.MODIFY(TRUE);

        UpdateResponse();

        exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec."External Document No." := ExternalDocNo;
    end;

    /// <summary>
    /// UpdateResponse - use to update the API Response after insert
    /// </summary>
    local procedure UpdateResponse()
    var

    begin
        DocNo := SalesOrderHeader."No.";
        SellToCustomerNo := SalesOrderHeader."Sell-to Customer No.";
        ExternalDocNo := SalesOrderHeader."External Document No.";
        ShipmentDate := SalesOrderHeader."Shipment Date";
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
        ExternalDocNo: Code[20];

        ShipmentDate: Date;

}