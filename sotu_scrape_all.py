"""
Script to scrape SOTU speeches: puts them in txt files. NOTE: a few years include multiple SOTU addresses that have multiple links on the main page. Because this was only a few years, I manually copied the text into the .txt files so that the files include all SOTU addresses for each year
"""

import requests
import os
from bs4 import BeautifulSoup
from time import sleep
import random
import codecs
import re

def scrape_speech(url):
	""" This function scrapes the SOTU speech when given a url (string), the llist to append to, and the president's name to put in the data
	"""
	page = requests.get(url)
	soup = BeautifulSoup(page.content)

	date = soup.find('span', class_ = 'docdate').text   #gets the date of the speech
	year_match = r'[A-Z][a-z]+\s*?\d+,\s*?(\d\d\d\d)' #pulls out just the year
	match = re.match(year_match, date)
	year = match.group(1)

	t = soup.find('span', class_ = 'displaytext').text

	filename = "all_speeches/sotu" + year + ".txt"
	print(year)
	with open(filename, "w") as file:
		file.write(t.encode('utf-8'))




if __name__ == '__main__':
#get list of urls
	url = "http://www.presidency.ucsb.edu/sou.php"
	page = requests.get(url)
	soup = BeautifulSoup(page.content)

	non_valid_link = '#nixon1973'

	for td in soup.find_all('td', class_='ver12'):
		try: #see if there is a url
			url = td.a.get('href')

		except AttributeError:
			continue

		if url == non_valid_link: #see if url is one of the links that doesn't go to a speech
				continue
		sleep(random.uniform(1,5))
		scrape_speech(url)












