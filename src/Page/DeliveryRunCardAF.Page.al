
/// <summary>
/// Page Delivery Run Card AF (ID 50831).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
page 50831 "Delivery Run Card AF"
{
    Caption = 'Delivery Run Card';
    PageType = Card;
    SourceTable = "Delivery Run AF";
    DelayedInsert = true;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Delivery Run Setup';
                field("Run Code"; Rec."Run Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the run code of delivery run.';
                }
                field("Run Description"; Rec."Run Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the run description of delivery run.';
                }
                field(Monday; Rec.Monday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allowable days of the week applicable for the run.';
                }
                field(Tuesday; Rec.Tuesday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allowable days of the week applicable for the run.';
                }

                field(Wednesday; Rec.Wednesday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allowable days of the week applicable for the run.';
                }

                field(Thursday; Rec.Thursday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allowable days of the week applicable for the run.';
                }

                field(Friday; Rec.Friday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allowable days of the week applicable for the run.';
                }

                field(Saturday; Rec.Saturday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allowable days of the week applicable for the run.';
                }
                field(Sunday; Rec.Sunday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allowable days of the week applicable for the run.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }
}