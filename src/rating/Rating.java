package rating;
import java.io.Serializable;


public class Rating implements Serializable {
	private static final long serialVersionUID = 1L;
	private String email;
	private String isbn;
	private int rating;
	private String review;
	private String reviewDate;
	
	public Rating() {}
	
	public Rating(String email, String isbn, int rating, String review, String reviewDate)
	{
		this.email = email;
		this.isbn = isbn;
		this.rating = rating;
		this.review = review;
		this.reviewDate = reviewDate;
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
	
	public int getRating()
	{
		return this.rating;
	}
	
	public void setRating(int rating)
	{
		this.rating = rating;
	}
	
	public String getReview()
	{
		return this.review;
	}
	
	public void setReview(String review)
	{
		this.review = review;
	}
	
	public String getReviewDate()
	{
		return this.reviewDate;
	}
	
	public void setReveiwDate(String reviewDate)
	{
		this.reviewDate = reviewDate;
	}
	
	
	
}
