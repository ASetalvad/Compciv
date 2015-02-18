username=$1
file="./data-hold/${username}-timeline.csv"
mkdir -p ./data-hold
echo "Fetching tweets for $username into $file"
t timeline -n 3200 --csv ${username} > ${file}

count=$(csvfix order -f 1 $file | wc -l)
lastdate=$(csvfix order -fn 'Posted at' $file | tail -n 1)
echo "Analyzing $count tweets by $1 since $lastdate"

echo "Top 10 hashtags by $username"
csvfix order -fn 'Text' $file |sed -e 's/^\"\|\"$//g'|tr '[:space:]\.\,' '\n' | grep -e '^#'|sed -e 's/[^[:alnum:]\#\@\_].*//g'|tr '[:upper:]' '[:lower:]' |sort |uniq -c|sort -bnr|head

echo "Top 10 retweeted users by $username"
csvfix order -fn 'Text' $file |sed -e 's/RT @/RT@/g' -e 's/^\"\|\"$//g'|tr '[:space:]\.\,' '\n' | grep -e '^RT@'|sed -e 's/[^[:alnum:]\#\@\_].*//g' -e 's/^RT//g'|tr '[:upper:]' '[:lower:]' |sort |uniq -c|sort -bnr|head

echo "Top 10 mentioned users (not including retweets) by $username"
csvfix order -fn 'Text' $file |sed -e 's/^\"\|\"$//g'|grep -v -e 'RT @\|RT: @'| tr '[:space:]\.\,' '\n' | grep -e '^@'|sed -e 's/[^[:alnum:]\#\@\_].*//g'|tr '[:upper:]' '[:lower:]' | sort |uniq -c|sort -bnr|head

#Top ten words, 5-letters or more, that are not usernames, nor hashtags, nor URLs.
echo "Top tweeted 10 words with 5+ letters by $username"
csvfix order -fn 'Text' $file |sed -e 's/RT @/@/g' -e 's/^\"\|\"$//g'|tr '[:space:]\.\,' '\n' |grep -v -e '^http://'|sed -e 's/[^[:alnum:]\#\@\_]/\n/g'|grep -E '^[[:alpha:]]{5}'|tr '[:upper:]' '[:lower:]' | sort |uniq -c|sort -bnr|head
