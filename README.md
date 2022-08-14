# QA - Take Home Task (UPWORK)

## HOW TO USE SCRIPT

First step is to give the script permissions to execute:

```bash

chmod +x ./run.rb ./compare_results.rb 

```

Now let's execute it:

```bash

./run.rb     

```

> This will execute the script with the default browser and search engine.

To access the help:

```bash

./run.rb -h 

```

## SOME IMPORTANT FLAGS TO REMEMBER

To change the browser:

```bash

./run.rb -b [BROWSER]

```

To change the search engine:

```bash

./run.rb -s [SEARCH_ENGINE]

```

To change default text ("Cypress"):

```bash

./run.rb -t [KEYWORD]

```

Example, this uses firefox as browser, bing as search engine and the keyword is
hello (If you want to search for more than one word please use quotes,
i.e "hello everyone")

```bash

./run.rb -b firefox -s bing -t hello

```

To run parallel searches just use regular bash commands
(this is way easier than trying to manually make ruby do concurrency):

```bash

./run.rb -b firefox -s bing -t hello & ./run.rb -b google -s google -t hello

```

This will make both automations run in parallel. But it is not very helpful
if you are looking at the STDOUT. (Just something to keep in mind),
the search scraping will be stored under:

```/results/<keyword>_<search_engine>```

To compare the searches results, we will use another command:

```bash

./compare_results.rb <keyword>

```

This will print to STDOUT the url comparison.

# Areas of interest in the APP

To add a new search engine:
> script/search_engines.rb (this to add the url and make the script recognize the new engine)
create a file that inherits from the class in the file search_engines_selectors/selectors_search_engine.rb

Change the number of results that we want scrapped from the search engines?
> file: search_engines_selectors/selectors_search_engine.rb -> Change constant NUMBER_OF_RESULTS

Add a new browser?
> script/browsers_list.rb (this to add the browser and make the script recognize the added browser)
and do not forget to add the driver to the drivers/ folder. 
