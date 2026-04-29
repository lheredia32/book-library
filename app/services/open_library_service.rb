# frozen_string_literal: true

require "net/http"
require "json"

class OpenLibraryService
  BASE_URL = "https://openlibrary.org"

  def self.fetch_by_isbn(isbn)
    return nil if isbn.blank?

    isbn_formatted = isbn.gsub(/-/, "").strip
    uri = URI("#{BASE_URL}/api/books?bibkeys=ISBN:#{isbn_formatted}&format=json&jscmd=data")

    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    book_data = data["ISBN:#{isbn_formatted}"]
    return nil unless book_data

    {
      title: book_data["title"],
      author: book_data["authors"]&.map { |a| a["name"] }&.join(", "),
      description: extract_description(book_data),
      cover_url: book_data["cover"]&.dig("medium")
    }
  rescue JSON::ParserError, StandardError
    nil
  end

  def self.extract_description(book_data)
    desc = book_data["notes"] || book_data["excerpts"]&.first&.dig("text")
    return nil unless desc

    desc.gsub(/<[^>]*>/, "").strip[0..500]
  end
end