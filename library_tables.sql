create database library;

use library;

-- Table: tbl_publisher
CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress TEXT,
    publisher_PublisherPhone VARCHAR(15)
);

-- Table: tbl_book
CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName)
);

-- Table: tbl_book_authors
CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255),
    FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID)
);

-- Table: tbl_library_branch
CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress TEXT
);

-- Table: tbl_book_copies
CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID)
);

-- Table: tbl_borrower
CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress TEXT,
    borrower_BorrowerPhone VARCHAR(15)
);

-- Table: tbl_book_loans
CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut DATE,
    book_loans_DueDate DATE,
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID),
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo)
);

select * from tbl_publisher;
select * from tbl_book;
select * from tbl_book_copies;
select * from tbl_book_authors;
select * from tbl_library_branch;
select * from tbl_borrower;
select * from tbl_book_loans;

SET SQL_SAFE_UPDATES = 0;
SELECT book_authors_BookID, book_authors_AuthorName
FROM tbl_book_authors
WHERE book_authors_BookID IS NULL;

SET @i = 0;

UPDATE tbl_book_authors
SET book_authors_BookID = (@i := @i + 1)
WHERE book_authors_BookID IS NULL
LIMIT 20;

DESCRIBE tbl_book_loans;

UPDATE tbl_book_loans
SET
  book_loans_DateOut = STR_TO_DATE(
      CONCAT('2018-', LPAD(MONTH(book_loans_DateOut),2,'0'), '-', LPAD(DAY(book_loans_DateOut),2,'0')),
      '%Y-%m-%d'
  ),
  book_loans_DueDate = STR_TO_DATE(
      CONCAT('2018-', LPAD(MONTH(book_loans_DueDate),2,'0'), '-', LPAD(DAY(book_loans_DueDate),2,'0')),
      '%Y-%m-%d'
  );
  
SELECT book_loans_DateOut, book_loans_DueDate
FROM tbl_book_loans;

-- 0002-03-18







