package Connection;

import static java.lang.System.out;
import java.sql.ResultSet;
import java.sql.Statement;


public class Db_Returns {
    public static String Db_Return(String table ,String matchingColumn , String name , String returnColumn){
        String abc = null;
        try {   
             Statement st = Db_Connection.connection().createStatement();
            String query = "select *  from "+table+" where  "+matchingColumn+" = '"+name+"' ";
            ResultSet rs = st.executeQuery(query);
           if(rs.next()){
                abc = rs.getString(returnColumn);
           }else{
                out.println(returnColumn+" no exist in "+table+" Table");   
            }
            rs.close();
        } catch (Exception e) {
            out.println("database returnings class . code return functioin  "+e);
        }//end of catch statement   
        return abc;
    }//end of funciton
}
