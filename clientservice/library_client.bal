import ballerina/io;

LibraryClient ep = check new ("http://localhost:9090");

public function main() returns error? {

    ISBN isbnResponse = check ep->addBook({isbn: "book1", title: "Java for dummies", author1: "John", author2: "", location: "A1", borrowed_by: "", available: true});
    io:println(isbnResponse);

    
    ListOfBooks listAvailableBooksResponse00 = check ep->listAvailableBooks({});
    io:println(listAvailableBooksResponse00);


    Message updateBookResponse = check ep->updateBook({isbn: "book1", title: "Intro to Mathematics", author1: "Benard", author2: "Tim", location: "A1", borrowed_by: "", available: true});
    io:println(updateBookResponse);


    ListOfBooks removeBookResponse = check ep->removeBook({isbn: "abc"});
    io:println(removeBookResponse);


    User[] users = [
        {user_id: "1", full_name: "John", role: "STUDENT"},
        {user_id: "2", full_name: "Mathew", role: "STUDENT"},
        {user_id: "3", full_name: "Steven", role: "LIBRARIAN"}
        ];
    CreateUsersStreamingClient createUsersStreamingClient = check ep->createUsers();
    foreach var user in users{
        check createUsersStreamingClient->sendUser(user);
    }
    check createUsersStreamingClient->complete();
    Message? createUsersResponse = check createUsersStreamingClient->receiveMessage();
    io:println(createUsersResponse);


    BookEnquiryResponse locateBookResponse = check ep->locateBook({isbn: "book1"});
    io:println(locateBookResponse);


    ListOfBooks searchBookByTitleResponse = check ep->searchBookByTitle({message: "java"});
    io:println(searchBookByTitleResponse);


    Message borrowBookResponse = check ep->borrowBook({user_id: "1", isbn: "book1"});
    io:println(borrowBookResponse);


    ListOfBooks listBorrowedBooksResponse = check ep->listBorrowedBooks({});
    io:println(listBorrowedBooksResponse);


    Message returnBookResponse = check ep->returnBook({user_id: "1", isbn: "book1"});
    io:println(returnBookResponse);
}




