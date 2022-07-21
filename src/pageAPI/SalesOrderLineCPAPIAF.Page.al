/// <summary>
/// Page Sales Order Line CP API AF (ID 50806).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
page 50806 "Sales Order Line CP API AF"
{
    APIPublisher = 'altafirma';
    APIGroup = 'sale';
    APIVersion = 'v1.0';
    EntityName = 'SalesOrderLineCP';
    EntitySetName = 'SalesOrderLinesCP';
    Caption = 'Sales Order Line CP API', Locked = true;
    DelayedInsert = true;
    PageType = API;
    SourceTable = "Sales Line";
    InsertAllowed = true;
    DeleteAllowed = false;
    SourceTableView = where("Document Type" = const(Order));
    ODataKeyFields = "Document Type", "Document No.", "Line No.";

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
                field(recDocNo; Rec."Document No.")
                {
                    Caption = 'recDocNo';
                    ApplicationArea = All;
                }
                field(reclineNo; Rec."Line No.")
                {
                    Caption = 'recLineNo';
                    ApplicationArea = All;
                }
                field(docNo; DocNo)
                {
                    Caption = 'DocNo';
                    ApplicationArea = All;
                }
                field(lineNo; LineNo)
                {
                    Caption = 'LineNo';
                    ApplicationArea = All;
                }

                field(itemNo; ItemNo)
                {
                    Caption = 'ItemNo';
                    ApplicationArea = All;
                }

                field(quantity; Qty)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DocNo := Rec."Document No.";
        LineNo := Rec."Line No.";
        ItemNo := Rec."No.";
        Qty := Rec.Quantity;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        clear(SalesOrderLine);

        SalesOrderLine."Document Type" := SalesOrderLine."Document Type"::Order;
        SalesOrderLine."Document No." := DocNo;
        SalesOrderLine."Line No." := LineNo;
        SalesOrderLine.INSERT(TRUE);
        SalesOrderLine.Type := SalesOrderLine.Type::Item;
        SalesOrderLine.Validate("No.", ItemNo);
        SalesOrderLine.Validate(Quantity, Qty);
        SalesOrderLine.MODIFY(TRUE);
        UpdateResponse();

        exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec."No." := ItemNo;
        Rec.Quantity := Qty;
    end;

    /// <summary>
    /// UpdateResponse - use to update the API Response after insert
    /// </summary>
    local procedure UpdateResponse()
    begin
        DocNo := SalesOrderLine."Document No.";
        LineNo := SalesOrderLine."Line No.";
        ItemNo := SalesOrderLine."No.";
        Qty := SalesOrderLine.Quantity;
    end;


    var
        SalesOrderLine: Record "Sales Line";
        DocNo: Code[20];
        LineNo: Integer;
        ItemNo: Code[20];
        Qty: Decimal;

}