package data

type Book struct {
	Id        string `json:"id"`
	Title     string `json:"title"`
	Author    string `json:"author"`
	Category  string `json:"category"`
	CoverURL  string `json:"coverURL"`
	Language  string `json:"language"`
	Likes     int    `json:"likes"`
	Loans     int    `json:"loans"`
	Summary   string `json:"summary"`
	Available bool   `json:"available"`
}

type Books []*Book

func GetBooks() Books {
	return BooksList
}

func GetBookById(id string) (*Book, int, error) {
	for i, book := range BooksList {
		if book.Id == id {
			return book, i, nil
		}
	}
	return nil, -1, ErrBookNotFound
}

func AddBook(book *Book) {
	BooksList = append(BooksList, book)
}

func UpdateBook(id string, book *Book) error {
	_, i, err := GetBookById(id)
	if err != nil {
		return err
	}
	BooksList[i] = book
	return nil
}

func DeleteBook(id string) error {
	_, i, err := GetBookById(id)
	if err != nil {
		return err
	}
	BooksList = append(BooksList[:i], BooksList[i+1:]...)
	return nil
}

var BooksList = Books{
	&Book{
		Id:        "1",
		Title:     "Book 1",
		Author:    "Author 1",
		Category:  "Category 1",
		CoverURL:  "https://example.com/book1.jpg",
		Language:  "English",
		Likes:     10,
		Loans:     5,
		Summary:   "Summary of Book 1",
		Available: true,
	},
	&Book{
		Id:        "2",
		Title:     "Book 2",
		Author:    "Author 2",
		Category:  "Category 2",
		CoverURL:  "https://example.com/book2.jpg",
		Language:  "English",
		Likes:     15,
		Loans:     8,
		Summary:   "Summary of Book 2",
		Available: true,
	},
	&Book{
		Id:        "3",
		Title:     "Book 3",
		Author:    "Author 3",
		Category:  "Category 3",
		CoverURL:  "https://example.com/book3.jpg",
		Language:  "English",
		Likes:     20,
		Loans:     12,
		Summary:   "Summary of Book 3",
		Available: true,
	},
	&Book{
		Id:        "4",
		Title:     "Book 4",
		Author:    "Author 4",
		Category:  "Category 4",
		CoverURL:  "https://example.com/book4.jpg",
		Language:  "English",
		Likes:     5,
		Loans:     2,
		Summary:   "Summary of Book 4",
		Available: true,
	},
}
