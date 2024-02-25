use case_study;


-- Create Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genre VARCHAR(100)
);

-- Create Borrowers table
CREATE TABLE Borrowers (
    borrower_id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(20)
);

-- Create Transactions table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    book_id INT,
    borrower_id INT,
    checkout_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (borrower_id) REFERENCES Borrowers(borrower_id)
);

-- Create Copies table
CREATE TABLE Copies (
    copy_id INT PRIMARY KEY,
    book_id INT,
    status VARCHAR(20),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Create Reservations table
CREATE TABLE Reservations (
    reservation_id INT PRIMARY KEY,
    book_id INT,
    borrower_id INT,
    reservation_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (borrower_id) REFERENCES Borrowers(borrower_id)
);
