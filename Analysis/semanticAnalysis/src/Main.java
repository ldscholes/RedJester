import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class Main {

	public static void main(String[] args) throws IOException {
         new Checker("This is a great excellent awful sample sentence.");
         new Checker("This is a great awful sample sentence.");
         new Checker("This is a awful sample sentence.");
         new Checker("This is a great excellent sample sentence.");
         new Checker("This is a gret excelent sample sentence.");
	}
}
