books = [
  {
    title: "1984",
    author: "George Orwell",
    isbn: "978-0451524935",
    status: "Want to Read"
  },
  {
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    isbn: "978-0061120084",
    status: "Completed"
  },
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    isbn: "978-0743273565",
    status: "Want to Read"
  },
  {
    title: "Pride and Prejudice",
    author: "Jane Austen",
    isbn: "978-0141439518",
    status: "Completed"
  },
  {
    title: "The Catcher in the Rye",
    author: "J.D. Salinger",
    isbn: "978-0316769488",
    status: "Currently Reading"
  },
  {
    title: "One Hundred Years of Solitude",
    author: "Gabriel García Márquez",
    isbn: "978-0060883287",
    status: "Completed"
  },
  {
    title: "The Hobbit",
    author: "J.R.R. Tolkien",
    isbn: "978-0547928227",
    status: "Want to Read"
  },
  {
    title: "Harry Potter and the Philosopher's Stone",
    author: "J.K. Rowling",
    isbn: "978-0747532699",
    status: "Completed"
  },
  {
    title: "The Da Vinci Code",
    author: "Dan Brown",
    isbn: "978-0307474278",
    status: "Want to Read"
  },
  {
    title: "The Girl with the Dragon Tattoo",
    author: "Stieg Larsson",
    isbn: "978-0307949486",
    status: "On Hold"
  },
  {
    title: "The Hunger Games",
    author: "Suzanne Collins",
    isbn: "978-0439023481",
    status: "Want to Read"
  },
  {
    title: "The Road",
    author: "Cormac McCarthy",
    isbn: "978-0307387899",
    status: "Dropped"
  },
  {
    title: "The Book Thief",
    author: "Markus Zusak",
    isbn: "978-0375842207",
    status: "Completed"
  },
  {
    title: "The Kite Runner",
    author: "Khaled Hosseini",
    isbn: "978-1594631931",
    status: "Want to Read"
  },
  {
    title: "The Alchemist",
    author: "Paulo Coelho",
    isbn: "978-0062315007",
    status: "Completed"
  },
  {
    title: "The Shining",
    author: "Stephen King",
    isbn: "978-0307743657",
    status: "Loaned Out"
  }
]

books.each do |book_attrs|
  isbn = book_attrs[:isbn]
  existing = Book.find_by(isbn: isbn)
  
  if existing.nil?
    cover_data = OpenLibraryService.fetch_by_isbn(isbn)
    book_attrs[:cover_url] = cover_data[:cover_url] if cover_data
    book_attrs[:description] = cover_data[:description] if cover_data
    Book.create!(book_attrs)
  else
    # Update existing book with latest data
    cover_data = OpenLibraryService.fetch_by_isbn(isbn)
    if cover_data
      existing.update!(
        title: book_attrs[:title],
        author: book_attrs[:author],
        status: book_attrs[:status],
        cover_url: cover_data[:cover_url],
        description: cover_data[:description]
      )
    else
      # Fallback if API fails
      existing.update!(
        title: book_attrs[:title],
        author: book_attrs[:author],
        status: book_attrs[:status]
      )
    end
  end
end

puts "Seeded/Updated #{Book.count} books"