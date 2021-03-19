RedJester Hadoop Tool
==================================

Package that allows for the ingestion of Reddit, Twitter & GoogleForms data, machine evaluation of comments as either positive/negative/neutral.

Pre-requisites
--------------
A Hadoop installed and a working cluster

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
