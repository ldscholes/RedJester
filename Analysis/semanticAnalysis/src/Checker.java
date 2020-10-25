import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class Checker {

	public static void main(String[] args) throws IOException {

		try {
			File newoutputFile = new File("outputfile.txt");
			if (newoutputFile.createNewFile()) {
				System.out.println("output created " + newoutputFile.getName());
			} else {
				System.out.println("output file already exists.");
			}
		
			FileWriter outputFile = new FileWriter("outputfile.txt");
			
			
			
				
			File inputFile = new File("inputfile.txt");
			Scanner myReader = new Scanner(inputFile);
			while (myReader.hasNextLine()) {
				String data = myReader.nextLine();

				int count = 0;
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

				java.lang.String[] words = data.split("\\s+");
				ArrayList<String> sentance = new ArrayList<>();
				for (int i = 0; i < words.length; i++) {
					words[i] = words[i].replaceAll("[^\\w]", "");
					sentance.add(words[i]);
				}

				for (String s1 : sentance) {
					if (listOfNeg.contains(s1)) {
						count--;
					}
					if (listOfPos.contains(s1)) {
						count++;
					}
				}

				System.out.println(data+","+count);
				outputFile.write(data+","+count+ System.lineSeparator());
			}
			myReader.close();
			outputFile.close();
		} catch (FileNotFoundException e) {
			System.out.println("An error occurred.");
			e.printStackTrace();
		}
	}
}
