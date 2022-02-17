#!/bin/bash -l

set -e

#CMD> && <SUCCESS_ACTION> || <FAIL_ACTION>
#echo sonar.host.url=\"${ENVCMD//[$'\t\r\n']}\""

echo "Debug"

echo $SONAR_PROJECT_KEY
echo $SONAR_HOST
echo $SONAR_TOKEN
echo $SONAR_EXTRA_ARG

echo "end Debug"

begin_cmd="/runner/dotnet-sonarscanner begin \\
    /k:\"${SONAR_PROJECT_KEY//[$'\t\r\n']:?Please set the projectKey environment variable.}\" \\
    /d:sonar.host.url=\"${SONAR_HOST:?Please set the SONAR_HOST environment variable.}\" \\
    /d:sonar.login=\"${SONAR_TOKEN:?Please set the SONAR_TOKEN environment variable.}\" "

echo "Complete begin command"
echo $begin_cmd

end_cmd="/runner/dotnet-sonarscanner end \\
     /d:sonar.login=\"${SONAR_TOKEN:?Please set the SONAR_TOKEN environment variable.}\" "

echo "Complete end command"
echo $end_cmd

#if string exists and is not empty.
if [ ! -z "$SONAR_EXTRA_ARG" ]
then
    begin_cmd="$begin_cmd $SONAR_EXTRA_ARG"
fi

sh -c "$begin_cmd"

sh -c "$end_cmd"

echo "Checking if the result exist."
if [ -f ".sonarqube/out/.sonar/report-task.txt" ]
then
  /runner/check-quality-gate.sh .sonarqube/out/.sonar/report-task.txt 
fi
