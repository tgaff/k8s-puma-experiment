rm output
rm -fr webreport/*

jmeter -n -t Scenario\ 1.jmx -l output -e -o webreport
