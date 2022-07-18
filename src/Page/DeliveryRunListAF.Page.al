
/// <summary>
/// Page Delivery Run List AF (ID 50830).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
page 50830 "Delivery Run List AF"
{
    Caption = 'Delivery Runs Setup';
    PageType = List;
    Editable = false;
    CardPageID = "Delivery Run Card AF";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Delivery Run AF";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
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
                    ToolTip = 'Allow day of the week applicable for the run..';
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