/// <summary>
/// Page Item API (ID 50801) 
/// AF-001 - Developer - Christian Gonzales
/// </summary>
page 50801 "Item CP API AF"
{
    APIPublisher = 'altafirma';
    APIGroup = 'sale';
    APIVersion = 'v1.0';
    EntityName = 'itemCP';
    EntitySetName = 'itemsCP';
    Caption = 'Item CP API', Locked = true;
    DelayedInsert = true;
    PageType = API;
    SourceTable = Item;
    InsertAllowed = false;
    DeleteAllowed = false;
    ODataKeyFields = "No.";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(itemNo; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(itemName; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(itemPicture; Rec."Picture as Text AF")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

    }
    var
    trigger OnAfterGetRecord()
    var
        PictureMngmnt: Codeunit "Picture Mngmnt AF";

    begin

        Rec."Picture as Text AF" := PictureMngmnt.GetItemPictureAsJson(Rec."No.");

    end;
}