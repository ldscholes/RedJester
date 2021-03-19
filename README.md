RedJester Hadoop Tool
==================================

Package that allows for the ingestion of Reddit, Twitter & GoogleForms data, machine evaluation of comments as either positive/negative/neutral.

Pre-requisites
--------------
Hadoop installed and a working cluster

Getting Started
---------------

1. Git clone this repo.
2. Run the setup.sh.

Ingestions
---------------
By default there are three types of ingestions

- Reddit
- Twitter
- Google Forms/sheets

You can alter the Twitter search terms in the properties file. And you can modify the Google Sheet/Form ID to download different result sets.

Machine based sentiment analysis
---------------
This is run in Java, the program has already been Javac'd. You can run the analysis by providing a text file of comments sentances. 
The output will be the sentance plus a positive, negative or 0 score.

Query First tool
---------------
The purpose of query first is to check the last time a query was run, and provide its result from its run.
From there is the query was far enough in the past and you wish to re-run it and update the result, you can.
This tool sits ontop of Hive QL. If you enter the command qf followed by a query in "".
This will active the tool, and open up the UI.

Query Checker tool
---------------
This tool is automatically run as part of an ingestion, it performs a md5 checksum on the file name and compares this to the list of stored files to see if its been processed before, if it has it cancelled ingestion and reports the error.
