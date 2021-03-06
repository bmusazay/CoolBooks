package user;
import java.io.Serializable;

public class User implements Serializable{
	private static final long serialVersionUID = 1L;
	private String email;
	private String pass;
	private String fname;
	private String lname;
	private Boolean isAdmin;
	public User(){
	}
	
	public User(String email, String pass, String fname, String lname, Boolean isAdmin){
		this.pass = pass;
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.isAdmin = isAdmin;
	}
	
	public String getPass(){
		return pass;
	}
	
	public void setPass(String pass){
		this.pass = pass;
	}
	
	public String getFName(){
		return fname;
	}
	
	public void setFName(String fname){
		this.fname = fname;
	}
	public String getLName(){
		return lname;
	}
	
	public void setLName(String lname){
		this.lname = lname;
	}
	
	public String getEmail(){
		return email;
	}
	
	public void setEmail(String email){
		this.email = email;
	}
	
	public Boolean isAdmin()
	{
		return this.isAdmin;
	}
	
	public void setAdmin(Boolean value)
	{
		this.isAdmin = value;
	}

}
