/// <summary>
/// CP Permission AF (ID 50800).
/// Add all Customer Portal Permissions here
/// Note:
///     x = indirect
///     X = yes
///     rimd = indirect
///     RIMD = yes
/// </summary>
permissionset 50800 "CP Permission AF"
{
    Assignable = true;
    Caption = 'Customer Portal Permissions';
    // IncludedPermissionSets
    Permissions =
        tabledata "Delivery Run AF" = RIMD,

        page "Ship To Address CP API AF" = X;

}