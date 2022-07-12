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
                field(itemWebName; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(itemUOM; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(itemPicture; PictureAsText)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    var
        PictureMngmnt: Codeunit "Picture Mngmnt AF";

    begin
        PictureAsText := PictureMngmnt.GetItemPictureAsJson(Rec."No.");
    end;

    var
        PictureAsText: Text;
}