This directory will house all python scripts. This will include scripts to ingest data through APIs, web scraping, and others.
These scripts will mainly be responsible for reading, transforming and moving data around.

getFakeStore.py notes
---------------------
Will have to enforce a unique column on the table for this script. Doubly so if we're going to extract data from multiple sources, will need to aggregate them for preserve uniqueness for grafana tracking. 
Trigger will need to be able to track changes and updates to individual records.