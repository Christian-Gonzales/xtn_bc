
/// <summary>
/// Page Delivery Run Card AF (ID 50831).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
page 50831 "Delivery Run Card AF"
{
    Caption = 'Delivery Run Card Setup';
    PageType = Card;
    SourceTable = "Delivery Run AF";
    DelayedInsert = true;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            Group("Delivery Run")
            {
                Caption = 'General';
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
            }

            Group("Allowable Day")
            {
                Caption = 'Setup';
                field(Monday; Rec.Monday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow day of the week applicable for the run.';
                }
                field(Tuesday; Rec.Tuesday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow day of the week applicable for the run.';
                }

                field(Wednesday; Rec.Wednesday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow day of the week applicable for the run.';
                }

                field(Thursday; Rec.Thursday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow day of the week applicable for the run.';
                }

                field(Friday; Rec.Friday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow day of the week applicable for the run.';
                }

                field(Saturday; Rec.Saturday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow day of the week applicable for the run.';
                }
                field(Sunday; Rec.Sunday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow day of the week applicable for the run.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }
}