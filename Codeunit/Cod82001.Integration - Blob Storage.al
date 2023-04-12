codeunit 83153 AttachedDocuments
{
    Permissions = tabledata "Sales Invoice Header" = rimd, tabledata "Sales Cr.Memo Header" = rimd;

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::table, 1173, 'OnBeforeInsertAttachment', '', true, true)]
    local procedure OnBeforeImportWithFilter(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        ABSBlobClient: codeunit "ABS Blob Client";
        Authorization: Interface "Storage Service Authorization";
        ABSContainersetup: Record "ABS Container setup";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        l_recSalesInvHeader: Record "Sales Invoice Header";
        l_recSalseCreditMemo: Record "Sales Cr.Memo Header";
        InS: InStream;
        OutS: OutStream;
        tempBlob: Codeunit "Temp Blob";
        Filename: Text;
        Convert: Codeunit "Base64 Convert";
    begin
        l_recSalesInvHeader.reset;
        l_recSalseCreditMemo.reset;
        ABSContainersetup.Get;
        //Message('%1', DocumentAttachment."Document Reference ID".HasValue);
        If (DocumentAttachment."Table ID" = 112) or (DocumentAttachment."Table ID" = 114) then begin
            Authorization := StorageServiceAuthorization.CreateSharedKey(ABSContainersetup."Shared Access Key");
            ABSBlobClient.Initialize(ABSContainersetup."Account Name", ABSContainersetup."Container Name", Authorization);
            //Copy from outstream to instream
            tempBlob.CreateOutStream(OutS);
            DocumentAttachment."Document Reference ID".ExportStream(OutS);
            //OutS.write(base64.FromBase64(Base64Value));
            // tempBlob.CreateInStream(InS, TextEncoding::UTF8);
            tempBlob.CreateInStream(InS);
            //  Message('1%', InS.Read());
            Filename := DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension";
            ABSBlobClient.PutBlobBlockBlobStream(Filename, InS);
            //ABSBlobClient.PutBlobAppendBlobStream(Filename);
            l_recSalesInvHeader.setrange("No.", DocumentAttachment."No.");
            If l_recSalesInvHeader.findfirst then begin
                l_recSalesInvHeader.BlobURL := StrSubstNo('https://%1.blob.core.windows.net/%2/%3', ABSContainersetup."Account Name", ABSContainersetup."Container Name", Filename);
                l_recSalesInvHeader.Modify();
            end else begin
                l_recSalseCreditMemo.setrange("No.", DocumentAttachment."No.");
                If l_recSalseCreditMemo.findfirst then begin
                    l_recSalseCreditMemo.BlobURL := StrSubstNo('https://%1.blob.core.windows.net/%2/%3', ABSContainersetup."Account Name", ABSContainersetup."Container Name", Filename);
                    l_recSalseCreditMemo.Modify();
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::table, 1173, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure DeleteDocumentAttachment(var Rec: Record "Document Attachment"; RunTrigger: Boolean)
    var
        ABSBlobClient: codeunit "ABS Blob Client";
        Authorization: Interface "Storage Service Authorization";
        ABSContainersetup: Record "ABS Container setup";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        Filename: Text;
    begin
        If (Rec."Table ID" = 112) or (Rec."Table ID" = 114) then begin
            If RunTrigger then begin
                ABSContainersetup.Get;
                Authorization := StorageServiceAuthorization.CreateSharedKey(ABSContainersetup."Shared Access Key");
                ABSBlobClient.Initialize(ABSContainersetup."Account Name", ABSContainersetup."Container Name", Authorization);
                Filename := Rec."File Name" + '.' + Rec."File Extension";
                //Filename := CONVERTSTR(Rec."File Name", ' ', '_');
                //Filename := Filename + '.' + Rec."File Extension";
                ABSBlobClient.DeleteBlob(Filename);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::table, 1173, 'OnAfterInsertEvent', '', true, true)]
    local procedure DeleteMediaField(var Rec: Record "Document Attachment"; RunTrigger: Boolean)
    begin
        If (Rec."Table ID" = 112) or (Rec."Table ID" = 114) then begin
            If RunTrigger then begin
                Clear(Rec."Document Reference ID");
                rec.Modify();
            end;
        end;
    end;


}