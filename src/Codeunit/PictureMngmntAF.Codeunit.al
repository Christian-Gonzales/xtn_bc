/// <summary>
/// Codeunit Picture Mangmnt AF (ID 50800).
/// AF-001 - Developer - Christian Gonzales
/// </summary>
codeunit 50800 "Picture Mngmnt AF"
{
    /// <summary>
    /// GetItemPictureAsJson.
    /// </summary>
    /// <param name="ItemNo">Code[20].</param>
    /// <returns>Return value of type Text.</returns>
    procedure GetItemPictureAsJson(ItemNo: Code[20]): Text;
    var
        Item: Record Item;
        //TempBlob: Codeunit "Temp Blob";
        TenantMedia: Record "Tenant Media";
        PictureAsText: Text;
        PictureInstream: Instream;
        JObject: JsonObject;
        JToken: JsonToken;
        PictureOutStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
    Begin

        Item.Get(ItemNo);

        if Item.Picture.Count = 0 then
            Exit('');

        TenantMedia.Get(Item.Picture.Item(1));
        TenantMedia.CalcFields(Content);
        if TenantMedia.Content.HasValue then begin
            Clear(PictureAsText);
            Clear(PictureInstream);
            //Clear(TempBlob);
            TenantMedia.Content.CreateInStream(PictureInstream);
            //TempBlob.CreateOutStream(PictureOutStream, TextEncoding::Windows);
            //CopyStream(PictureOutStream,PictureInstream);
            //TempBlob.CreateInStream(PictureInstream)
            PictureAsText := Base64Convert.ToBase64(PictureInstream);
            JObject.Add('picture', PictureAsText);
            JObject.SelectToken('picture', JToken);
        end;

        exit(JToken.AsValue.AsText());

    End;
}