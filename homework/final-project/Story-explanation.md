Demand for information security experts in the United States is outstripping the available supply by a widening margin, according to a pair of recently released reports.
 
A report from Burning Glass Technologies, which develops technologies designed to match people with jobs, shows that demand for cybersecurity professionals over the past five years grew 3.5 times faster than demand for other IT jobs and about 12 times faster than for all other jobs.The soaring demand for information security professionals suggests that enterprises and government agencies are putting a lot more money and effort into protecting their data against attacks and compromise. This may be especially true due to recent high profile hacks such as that of Sony, as well as the fact that cyber security is now a primary concern for the Obama administration.

For my final project I wanted to explore this recent uptick in demand for cybersecurity professionals, by exploring the rapid increase in cybersecurity jobs. 
 
I wrote a Python script that pulled the details of all federal cyber-related job postings from the US Jobs website we used previously to see if there was an uptick in these types of jobs and if so, analyse it across time/industry. The problem I immeditely came across was that the jobs website is updated regularly and does not maintain an archive, or let you sort jobs by when they are posted. So although my script is able to pull the total number of cybersecurity jobs posted on the website on the day that it is run, it does not let you compare the present demand with past demand.

However, my script did fulfill the other tasks that I hoped it would. The steps that my script goes through are:
  - read a list of json files and pull a list of job openings from those json files (scraped from the US government jobs website)
  - look for ‘Information Technology Specialist’ openings under Job Title
  - search Job Descriptions for cybersecurity, cyber security, cyber breach, cyber risk, cyber threat, data breach, cyber-security and other related keywords that are included in the types of job postings I wanted to find
  - list the unique postings in a numbered list, along with minimum salary, maximum salary, department and agency, as well as providing the total number of postings
