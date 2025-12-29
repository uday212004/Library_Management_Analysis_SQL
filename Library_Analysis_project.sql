-- Q.1 How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
-- > Answer

SELECT tbl_book.book_Title as Title,tbl_library_branch.library_branch_BranchName as Branch_Name,
(tbl_book_copies.book_copies_No_Of_Copies) as Copies
FROM tbl_book_copies
JOIN tbl_book ON tbl_book_copies.book_copies_BookID = tbl_book.book_BookID
JOIN tbl_library_branch ON tbl_book_copies.book_copies_BranchID = tbl_library_branch.library_branch_BranchID
WHERE tbl_book.book_Title = 'The Lost Tribe'
AND tbl_library_branch.library_branch_BranchName = 'Sharpstown';


-- Q.2 How many copies of the book titled "The Lost Tribe" are owned by each library branch?
-- > Answer

SELECT tbl_library_branch.library_branch_BranchName as Library_Branch,
SUM(tbl_book_copies.book_copies_No_Of_Copies) AS TotalCopies
FROM tbl_book_copies
JOIN tbl_book ON tbl_book_copies.book_copies_BookID = tbl_book.book_BookID
JOIN tbl_library_branch ON tbl_book_copies.book_copies_BranchID = tbl_library_branch.library_branch_BranchID
WHERE tbl_book.book_Title = 'The Lost Tribe'
GROUP BY tbl_library_branch.library_branch_BranchName;








