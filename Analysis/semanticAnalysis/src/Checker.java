import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class Checker {
	public Checker(String s) throws IOException {
		int count = 0;
		System.out.println(new File(".").getAbsolutePath());
		BufferedReader bufReader = new BufferedReader(new FileReader("positive-words.txt"));
	    ArrayList<String> listOfPos = new ArrayList<>();

	    String line = bufReader.readLine();
	    while (line != null) {
	      listOfPos.add(line);
	      line = bufReader.readLine();
	    }

	    bufReader.close();
	    
		BufferedReader bufReader1 = new BufferedReader(new FileReader("negative-words.txt"));
	    ArrayList<String> listOfNeg = new ArrayList<>();

	    String line1 = bufReader1.readLine();
	    while (line1 != null) {
	      listOfNeg.add(line1);
	      line1 = bufReader1.readLine();
	    }

	    bufReader1.close();

	    java.lang.String[] words = s.split("\\s+");
	    ArrayList<String> sentance = new ArrayList<>();
	    for (int i = 0; i < words.length; i++) {
	        words[i] = words[i].replaceAll("[^\\w]", "");
	        sentance.add(words[i]);
	    }
	 
	    
	    for( String s1 : sentance){
	    	if (listOfNeg.contains(s1)) {
	    		count--;}
	    	if (listOfPos.contains(s1)){
	    		count++;}
	    }
	    
	    System.out.println(count); 
	}
}
