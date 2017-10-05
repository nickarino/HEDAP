/**
* Created by nick on 7/28/17.
*/
@isTest
//tests run as a system user
//"with sharing" means that Apex respects the current running user's priviledges.
//"without sharing" means that Apex does not respect the current running user's priviledges.
//TODO: clean up these tests (7/28/17)

public with sharing class CON_Simple_Test
{

@isTest
public static void simpleContact() {

Contact contact1 = new Contact(
LastName = 'TestersonA'
);
List<Contact> contacts = new Contact[]{contact1};

//Usually where you call the method
//If you get lost go to the SRS
//https://powerofus.force.com/servlet/fileField?retURL=%2Farticles%2FResource%2FHigher-Education-Data-Architecture-HEDA-Software-Requirements-Specification&entityId=ka080000000HfmYAAS&field=File__Body__s
Test.startTest();
insert contacts;
Test.stopTest();

contacts = [select ID, LastName
from Contact where ID in :contacts order by LastName];
Contact contactFetched = contacts[0];

System.assertNotEquals(contactFetched.ID, null, 'should not be null');
System.assertEquals(contact1.LastName, contactFetched.LastName, 'names should be same');
}

//https://salesforce.stackexchange.com/questions/30056/how-to-create-csv-files-in-controller-method-from-list
@isTest
public static void generate() {

    Contact[] contacts = new Contact[]{
    new Contact(
    FirstName = 'Jane',
    LastName = 'Doe'
    ),
    new Contact(
    FirstName = 'John',
    LastName = 'Smith',
    Birthdate = Date.newInstance(1985, 2, 3),
    Email = 'abc@def.com',
    Phone = '222 444 55555'
    )
    };

    insert contacts;

    String expected = ''
    + '"First Name","Last Name","Birthdate","Email","Phone"\n'
    + '"Jane","Doe","","",""\n'
    + '"John","Smith","2/3/1985","abc@def.com","222 444 55555"\n'
    ;


    System.assertEquals(expected, new Csv().generate(contacts));

    Blob txtBlob = Blob.valueOf('Chan Li is great'); //Convert it to a blob
    Attachment attach = new Attachment(); //Make an attachment
    attach.Name ='text.xml';
    attach.Body = txtBlob;
    attach.ContentType= 'application/xml'; //Signal what the file's MIME type is
    attach.ParentID = contacts[0].ID;
    insert attach;

}




}