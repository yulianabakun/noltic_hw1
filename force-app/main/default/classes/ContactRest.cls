/**
 * Created by Yulisha on 9/2/2022.
 */

@RestResource(UrlMapping='/contact/*')
global class ContactRest {

    final static String lastEndpointSection = 'contact';

    @HttpGet
    global static void getContacts() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String contactId = req.requestUri.substring(
                req.requestURI.lastIndexOf(lastEndpointSection) + lastEndpointSection.length())
                .removeStart('/');

        res.headers.put('Content-Type', 'application/json');

        if (String.isBlank(contactId)) {
            res.responseBody = Blob.valueOf(JSON.serializePretty([
                    SELECT Id, Name
                    FROM Contact
            ]));
        } else {
            res.responseBody = Blob.valueOf(JSON.serializePretty([
                    SELECT Id, Name
                    FROM Contact
                    WHERE Id = :contactId
            ]));
        }
    }

    @HttpPost
    global static void createContact(String lastName, String firstName) {
        RestResponse res = RestContext.response;

        if (String.isBlank(lastName)) {
            res.statusCode = 400;
            res.responseBody = Blob.valueOf('Last name is missing');
        }

        Contact c = new Contact(LastName = lastName, FirstName = firstName);

        insert c;

        res.headers.put('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(c));
    }

    @HttpPatch
    global static void updateContact(String email) {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String contactId = req.requestUri.substring(
                req.requestURI.lastIndexOf(lastEndpointSection) + lastEndpointSection.length())
                .removeStart('/');

        if (String.isBlank(contactId)) {
            res.statusCode = 400;
            res.responseBody = Blob.valueOf('Contact Id is missing');

            return;
        }

        List<Contact> contacts = [SELECT Id FROM Contact WHERE Id = :contactId];
        if (contacts.isEmpty()){
            res.statusCode = 404;
            res.responseBody = Blob.valueOf('Contact not found.');

            return;
        }

        Contact c = contacts[0];

        c.Email = email;

        update c;

        res.headers.put('Content-Type', 'application/json');
        res.responseBody = Blob.valueOf(JSON.serialize(c));
    }

    @HttpDelete
    global static void deleteContact() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String contactId = req.requestUri.substring(
                req.requestURI.lastIndexOf(lastEndpointSection) + lastEndpointSection.length())
                .removeStart('/');

        if (String.isBlank(contactId)) {
            res.statusCode = 400;
            res.responseBody = Blob.valueOf('Contact Id is missing');

            return;
        }

        List<Contact> contacts = [SELECT Id FROM Contact WHERE Id = :contactId];
        if (contacts.isEmpty()){
            res.statusCode = 404;
            res.responseBody = Blob.valueOf('Contact not found.');

            return;
        }

        delete contacts;
    }
}