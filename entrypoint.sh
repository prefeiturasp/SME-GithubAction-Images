#!/bin/bash -l

set -e

#CMD> && <SUCCESS_ACTION> || <FAIL_ACTION>
#echo sonar.host.url=\"${ENVCMD//[$'\t\r\n']}\""

begin_cmd="/runner/dotnet-sonarscanner begin \\
    /k:\"${SONAR_PROJECT_KEY//[$'\t\r\n']:?Please set the projectKey environment variable.}\" \\
    /d:sonar.host=\"${SONAR_HOST:?Please set the SONAR_HOST environment variable.}\" \\
    /d:sonar.login=\"${SONAR_TOKEN:?Please set the SONAR_TOKEN environment variable.}\" "


end_cmd="/runner/dotnet-sonarscanner end \\
     /d:sonar.login=\"${SONAR_TOKEN:?Please set the SONAR_TOKEN environment variable.}\" "

#if string exists and is not empty.
if [ -n $SONAR_EXTRA_ARG ]
then
    echo "extra arguments $SONAR_EXTRA_ARG"
    begin_cmd="$begin_cmd $SONAR_EXTRA_ARG"
fi

#if string exists and is not empty.
if [ -n $DOTNET_PROJECT ]
then
  echo "dotnet project: $DOTNET_PROJECT"
  dotnet restore $DOTNET_PROJECT
fi

sh -c "$begin_cmd"

#if string exists and is not empty.
if [ -n $DOTNET_PROJECT ]
then
  dotnet build $DOTNET_PROJECT
fi
 
sh -c "$end_cmd"

echo "Checking if the result exist."
if [ -f ".sonarqube/out/.sonar/report-task.txt" ]
then
  /runner/check-quality-gate.sh .sonarqube/out/.sonar/report-task.txt 
fi
