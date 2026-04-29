books = [
  {
    title: "1984",
    author: "George Orwell",
    isbn: "978-0451524935",
    status: "Want to Read",
    rating: 5,
    review: "A chilling dystopian masterpiece that remains terrifyingly relevant today. Orwell's vision of surveillance state and thought control is both brilliant and disturbing."
  },
  {
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    isbn: "978-0061120084",
    status: "Completed",
    rating: 5,
    review: "A timeless classic about racial injustice and moral growth. Atticus Finch remains one of literature's greatest heroes, and Scout's innocent perspective makes the heavy themes accessible."
  },
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    isbn: "978-0743273565",
    status: "Want to Read",
    rating: 0,
    review: ""
  },
  {
    title: "Pride and Prejudice",
    author: "Jane Austen",
    isbn: "978-0141439518",
    status: "Completed",
    rating: 4,
    review: "Austen's wit and social commentary shine in this beloved romance. Elizabeth Bennet is a delightfully sharp protagonist, and the slow-burn romance with Mr. Darcy is perfection."
  },
  {
    title: "The Catcher in the Rye",
    author: "J.D. Salinger",
    isbn: "978-0316769488",
    status: "Currently Reading",
    rating: 3,
    review: "Holden Caulfield's voice is authentic and captures teenage angst perfectly, though the narrative can feel repetitive at times. Still, a important coming-of-age story."
  },
  {
    title: "One Hundred Years of Solitude",
    author: "Gabriel García Márquez",
    isbn: "978-0060883287",
    status: "Completed",
    rating: 5,
    review: "Magical realism at its finest. The Buendía family's multi-generational saga is both fantastical and deeply human. A challenging but rewarding read that redefines what literature can be."
  },
  {
    title: "The Hobbit",
    author: "J.R.R. Tolkien",
    isbn: "978-0547928227",
    status: "Want to Read",
    rating: 0,
    review: ""
  },
  {
    title: "Harry Potter and the Philosopher's Stone",
    author: "J.K. Rowling",
    isbn: "978-0747532699",
    status: "Completed",
    rating: 4,
    review: "The book that started a phenomenon. While simpler than later installments, it introduces a magical world that captures the imagination. Perfect for readers of all ages."
  },
  {
    title: "The Da Vinci Code",
    author: "Dan Brown",
    isbn: "978-0307474278",
    status: "Want to Read",
    rating: 0,
    review: ""
  },
  {
    title: "The Girl with the Dragon Tattoo",
    author: "Stieg Larsson",
    isbn: "978-0307949486",
    status: "On Hold",
    rating: 4,
    review: "A gripping thriller with complex characters and a twisty plot. Lisbeth Salander is an unforgettable protagonist, though the graphic content may not be for everyone."
  },
  {
    title: "The Hunger Games",
    author: "Suzanne Collins",
    isbn: "978-0439023481",
    status: "Want to Read",
    rating: 0,
    review: ""
  },
  {
    title: "The Road",
    author: "Cormac McCarthy",
    isbn: "978-0307387899",
    status: "Dropped",
    rating: 2,
    review: "The prose is beautifully sparse and haunting, but the relentless bleakness became too much for me. Appreciate the literary merit but couldn't finish due to the overwhelming despair."
  },
  {
    title: "The Book Thief",
    author: "Markus Zusak",
    isbn: "978-0375842207",
    status: "Completed",
    rating: 5,
    review: "Narrated by Death, this WWII story is heartbreaking yet ultimately hopeful. Liesel's love of books in dark times is incredibly moving. One of the best YA novels ever written."
  },
  {
    title: "The Kite Runner",
    author: "Khaled Hosseini",
    isbn: "978-1594631931",
    status: "Want to Read",
    rating: 0,
    review: ""
  },
  {
    title: "The Alchemist",
    author: "Paulo Coelho",
    isbn: "978-0062315007",
    status: "Completed",
    rating: 3,
    review: "A fable about following your dreams with some beautiful insights, though it can feel overly simplistic and repetitive at times. The allegory works better in small doses."
  },
  {
    title: "The Shining",
    author: "Stephen King",
    isbn: "978-0307743657",
    status: "Loaned Out",
    rating: 4,
    review: "King at his best - a slow-burn horror masterpiece that builds dread to unbearable levels. The Overlook Hotel is a character itself, and Jack's descent into madness is terrifying."
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
        rating: book_attrs[:rating],
        review: book_attrs[:review],
        cover_url: cover_data[:cover_url],
        description: cover_data[:description]
      )
    else
      # Fallback if API fails
      existing.update!(
        title: book_attrs[:title],
        author: book_attrs[:author],
        status: book_attrs[:status],
        rating: book_attrs[:rating],
        review: book_attrs[:review]
      )
    end
  end
end

# Create sample tags
tag_names = [ "Fiction", "Classics", "Science Fiction", "Fantasy", "Mystery", "Thriller", "Romance", "Historical", "Young Adult", "Adventure", "Philosophy", "Coming of Age" ]
tag_names.each do |name|
  Tag.find_or_create_by!(name: name)
end

# Assign tags to books (this is simplified - in a real app you might want more sophisticated logic)
books = Book.all
tags = Tag.all

books.each_with_index do |book, index|
  # Assign 1-3 tags to each book based on index for variety
  tag_count = 1 + (index % 3)
  selected_tags = tags.sample(tag_count)
  book.tags << selected_tags
  book.save
end

puts "Seeded/Updated #{Book.count} books and #{Tag.count} tags"
