
public with sharing class Nick_Temp {

    public String callCsv() {

        Contact[] contacts = new Contact[]{
                new Contact(
                        FirstName = 'John',
                        LastName = 'Smith2',
                        Birthdate = Date.newInstance(1985, 2, 3),
                        Email = 'abc@def.com',
                        Phone = '222 444 55555'
                )
        };

        insert contacts;

        Blob txtBlob = Blob.valueOf(new Csv().generate(contacts)); //Convert it to a blob
        Attachment attach = new Attachment(); //Make an attachment
        attach.Name = 'text.csv';
        attach.Body = txtBlob;
        attach.ContentType = 'text/csv'; //Signal what the file's MIME type is
        attach.ParentID = contacts[0].ID;
        insert attach;
        return '';
    }

//Below from Chan Li
//public static void Test(){
//
//Blob txtBlob = Blob.valueOf('TEST'); //Convert it to a blob
//Document attach = new Document(); //Make an attachment
//attach.Name = 'test.txt';
//attach.Body = txtBlob;
//attach.ContentType= 'text/plain'; //Signal what the file's MIME type is
//attach.FolderId =  [select id from Folder where name='TestFolder' LIMIT 1].ID;
////attach.ParentID = [Select Id from ContentDocument limit 1].ID;
////ApexPages.currentPage();
////[Select Id from ContentDocument limit 1].ID;//069f1000003OvdZAAS
//insert attach;
//
//System.debug('Test File!');
//}


}