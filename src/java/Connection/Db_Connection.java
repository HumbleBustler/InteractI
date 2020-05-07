package Connection;


import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;

public class Db_Connection {

    static  Connection connection = null; 
    public static void connect(){
        
       String message = "";
       try {
            String connectionURL = "jdbc:mysql://localhost:3306/Interact?autoReconnect=true&useSSL=false";
            Class.forName("com.mysql.jdbc.Driver"); 
            connection = DriverManager.getConnection(connectionURL, "root", "root");
            if(!connection.isClosed())
                System.out.println("Successfully connected to " + "MySQL server using TCP/IP...");
            }catch(Exception ex){
                out.println(ex);
            } 
    }
    
    public  static Connection connection(){
        return connection;
    }
    
    
}
