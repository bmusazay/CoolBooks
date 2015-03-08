package transaction;



public class Transaction {
	
	private String email;
	private String isbn;
	private int quantity;
	private double total;
	private String transDate;
	private int tranNumber;
	
	public Transaction() {}

	public Transaction(String email, String isbn, int quantity, double price, String purchaseDate)
	{
		this.email = email;
		this.isbn = isbn;
		this.quantity = quantity;
		this.total = (price * quantity);
		this.tranNumber = 0;
		this.transDate = purchaseDate;
	}
	
	public String getEmail()
	{
		return this.email;
	}
	
	public void setEmail(String email)
	{
		this.email = email;
	}
	
	public String getIsbn()
	{
		return this.isbn;
	}
	
	public void setIsbn(String isbn)
	{
		this.isbn = isbn;
	}
	
	public Double getTotal()
	{
		return this.total;
	}
	
	public void setTotal(double total)
	{	
		this.total = total;
	}
	
	public int getQuantity()
	{
		return this.quantity;
	}
	
	public void setQuantity(int quantity)
	{
		this.quantity = quantity;
	}
	
	public void setTranNumber(int tranNumber)
	{
		this.tranNumber = tranNumber;
	}

	public int getTranNumber()
	{
		return this.tranNumber;
	}
	
	public void setTranDate(String tranDate)
	{
		this.transDate = tranDate;
	}

	public String getTranDate()
	{
		return this.transDate;
	}
}
