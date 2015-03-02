package book;

import java.io.Serializable;

public class Book implements Serializable
{
	private static final long serialVersionUID = 1L;
	private String isbn;
	private String title;
	private int inventory;
	private double price;
	private String category;
	private String author;
	private int year;
	private byte[] img;
	
	public Book(){
	}
	
	public Book(String isbn, String title, String author, double price, String category,
			    int year, int inventory){
		this.title = title;
		this.inventory = inventory;
		this.price = price;
		this.category = category;
		this.isbn = isbn;
		this.author = author;
		this.year = year;	
	}
	
	public String getIsbn()
	{
		return this.isbn;
	}
	public void setIsbn(String isbn)
	{
		this.isbn = isbn;
	}
	
	public String getTitle()
	{
		return this.title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	
	
	public int getInventory()
	{
		return this.inventory;
	}
	
	public void setInventory(int inventory)
	{
		this.inventory = inventory;
	}
	
	public double getPrice()
	{
		return this.price;
	}
	public void setPrice(double price)
	{
		this.price = price;
	}
	
	public String getCategory()
	{
		return this.category;
	}
	public void setCategory(String category)
	{
		this.category = category;
	}
	
	public String getAuthor()
	{
		return this.author;
	}
	public void setAuthor(String author)
	{
		this.author = author;
	}
	
	public void setYear(int year)
	{
		this.year = year;
	}
	public int getYear()
	{
		return this.year;
	}
	
	
}
